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

  


}
