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
  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }

  func test_repositoryInit_exsitRepository() {
    let _ = NewlyCoinedRepository()
  }


}
