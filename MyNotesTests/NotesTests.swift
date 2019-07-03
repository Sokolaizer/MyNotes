
import XCTest
@testable import MyNotes

class NotesTests: XCTestCase {
  
  private let uid = "testUID"
  private let title = "testTitle"
  private let content = "testContent"
  private let importance = Importance.regular
  private var sut: Note!
  
  override func setUp() {
    super.setUp()
    sut = Note(title: title, content: content, importance: importance, selfDestructDate: nil)
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testNote_isStruct() {
    guard let note = sut, let displayStyle = Mirror(reflecting: note).displayStyle else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(displayStyle, .struct)
  }
  
  func testNote_whenInitialized_isSetUid() {
    let note = Note(uid: uid, title: title, content: content, importance: importance, selfDestructDate: nil)
    
    XCTAssertEqual(uid, note.uid)
  }
  
  func testNote_whenInitialized_isSetDefaultUid() {
    let note = Note(title: title, content: content, importance: importance, selfDestructDate: nil)
    
    XCTAssertNotEqual(sut.uid, note.uid)
  }
  
  func testNote_whenInitialized_setTitle() {
    XCTAssertEqual(sut.title, title)
  }
  
  func testNote_whenInitialized_setContent() {
    XCTAssertEqual(sut.content, content)
  }
  
  func testNote_whenInitialized_setImportance() {
    XCTAssertEqual(sut.importance, importance)
  }
  
  
  func testNote_whenInitialized_defaultColor() {
    XCTAssertEqual(sut.color, UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
  }
  
  func testNote_whenInitialized_customColor() {
    let color = UIColor.red
    let note = Note(title: title, content: content, color: color, importance: importance, selfDestructDate: nil)
    
    XCTAssertEqual(note.color, color)
  }
  
  func testNote_whenInitialized_defaultDate() {
    XCTAssertNil(sut.selfDestructDate)
  }
  
  func testNote_whenInitialized_customDate() {
    let date = Date()
    let note = Note(title: title, content: content, importance: importance, selfDestructDate: date)
    
    XCTAssertEqual(date, note.selfDestructDate)
  }
}
