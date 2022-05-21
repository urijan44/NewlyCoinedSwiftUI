//
//  NewlyCoinedRepositoryTests.swift
//  
//
//  Created by hoseung Lee on 2022/05/20.
//

import Foundation
import XCTest
@testable import NewlyCoinedDB

final class NewlyCoinedRepositoryTests: XCTestCase {

  var sut: NewlyCoinedRepository!
  var parser: MockCSVParser!

  override func setUpWithError() throws {
    try super.setUpWithError()
    parser = MockCSVParser()
    sut = NewlyCoinedRepository(parser: parser)
  }

  override func tearDownWithError() throws {
    parser = nil
    sut = nil
    try super.tearDownWithError()
  }

  func test_repositoryInit_exsitRepository() {
    let _ = NewlyCoinedRepository(parser: MockCSVParser())
  }

  func testRepository_whenFetchCSVStrings_success() {
    // Given
    parser.success = true
    // When
    let csvContent = sut.fetchCSVStrings()
    // Then
    switch csvContent {
      case .success:
        XCTAssert(true)
      case .failure(let error):
        XCTAssert(false, error.localizedDescription)
    }
  }

  func testRepository_whenFetchCSVStrings_failureWtihError() {
    // Given
    parser.success = false
    // When
    let csvContent = sut.fetchCSVStrings()
    // Then
    switch csvContent {
      case .success:
        XCTAssert(false, "must failure")
      case .failure:
        XCTAssert(true)
    }
  }
}
