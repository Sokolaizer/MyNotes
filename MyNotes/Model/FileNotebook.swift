
import Foundation
import CocoaLumberjack

class FileNotebook {
  public let fileLogger = DDFileLogger()
  public private(set) var notes = [String: Note]()
  private let fm = FileManager.default
  private let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
  private var filePath: URL? {
    return path?.appendingPathComponent("notes").appendingPathExtension("json")
  }
  
  private func setupLogger() {
    DDLog.add(DDTTYLogger.sharedInstance)
    fileLogger.rollingFrequency = TimeInterval(60*60*24)
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7
    DDLog.add(fileLogger, with: .info)
  }
  public func add(_ note: Note) {
    notes[note.uid] = note
    #if QA
    DDLogInfo("Note \(note.uid) added")
    #endif
  }
  
  public func remove(with uid: String) {
    notes.removeValue(forKey: uid)
    #if QA
    DDLogInfo("Note \(uid) removed")
    #endif
  }
  
  public func save() {
    var json = [[String: Any]]()
    var isDir: ObjCBool = false
    guard let path = path,
      let filePath = filePath else { return }
    for note in notes {
      json.append(note.value.json)
    }
    if !fm.fileExists(atPath: path.path, isDirectory: &isDir),
      !isDir.boolValue {
      try? fm.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
    }
    do {
      let data = try JSONSerialization.data(withJSONObject: json, options: [])
      fm.createFile(atPath: filePath.path, contents: data, attributes: nil)
      #if QA
      DDLogInfo("Notes saved to file")
      #endif
    } catch {
      DDLogError("Could not save note at path:  \(filePath.path)")
    }
  }
  
  public func load() {
    guard let filePath = filePath else { return }
    do {
      let data = try Data(contentsOf: filePath)
      guard let json = try JSONSerialization.jsonObject(with: data, options:[]) as? [[String: Any]] else { return }
      try fm.removeItem(at: filePath)
      for noteJson in json {
        guard let note = Note.parse(json: noteJson) else { return }
        notes[note.uid] = note
      }
      #if QA
      DDLogInfo("Notes loaded from file")
      #endif
    } catch {
      DDLogError("Could not load note from path:  \(filePath.path)")
    }
  }
  init() {
    setupLogger()
  }
  
}
