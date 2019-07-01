//
//  MyNotesTests.swift
//  MyNotesTests
//
//  Created by Roman Kozlov on 01.07.2019.
//  Copyright © 2019 Roman Kozlov. All rights reserved.
//

import XCTest
@testable import MyNotes

class MyNotesTests: XCTestCase {
  var note: MyNotes.Note!
  
  override func setUp() {
    super.setUp()
    note = Note(title: "Test Title", content: "Test Content", importance: .important)
  }
  
  override func tearDown() {
    note = nil
    super.tearDown()
  }
  
  func testNoteExtensionWithWhiteColor() {
    
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
