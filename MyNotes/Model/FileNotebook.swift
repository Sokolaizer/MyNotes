
import Foundation

class FileNotebook {
  public private(set) var notes = [String: Note]()
  private let fm = FileManager.default
  private let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
  private var filePath: URL? {
    return path?.appendingPathComponent("notes").appendingPathExtension("json")
  }
  public func add(_ note: Note) {
    notes[note.uid] = note
  }
  
  public func remove(with uid: String) {
    notes.removeValue(forKey: uid)
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
    } catch {
      print(error)
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
    } catch {
      print(error)
    }
  }
}
