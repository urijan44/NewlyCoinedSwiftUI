//
//  CSVParser.swift
//  
//
//  Created by hoseung Lee on 2022/05/20.
//

import Foundation
import XCTest
@testable import NewlyCoinedDB

final class CSVParserTests: XCTestCase {

  var sut: CSVParser!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = CSVParser()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func test_parserInit_exsit() {
    let _ = CSVParser()
  }

  func testParser_whenLoadBundlePath_makeDataOrError() {
    // Given

    // When
    do {
      let _ = try sut.parseBundle("")
      // Then
      XCTAssert(true)
    } catch let error {
      XCTAssert(true, error.localizedDescription)
    }
  }

  func testParser_whenValidBundlePath_makeData() {

    // Given
    guard let mockCSVURL = Bundle.module.path(forResource: "NewlyCoinedWords", ofType: "csv") else {
      XCTAssert(false, "Bundle not found!")
      return
    }
    // When

    do {
      let _ = try sut.parseBundle(mockCSVURL)
      // Then
      XCTAssert(true)
    } catch let error {
      XCTAssert(false, error.localizedDescription)
    }
  }

  func testParser_whenInvalidBundlePath_throwError() {
    // Given
    let invaliePath = ""
    // When
    do {
      let _ = try sut.parseBundle(invaliePath)
      XCTAssert(false, "get error")
    } catch {
      XCTAssert(true)
    }
    // Then
  }
}
