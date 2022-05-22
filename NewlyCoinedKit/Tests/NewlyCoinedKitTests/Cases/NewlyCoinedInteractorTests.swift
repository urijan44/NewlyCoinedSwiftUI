//
//  NewlyCoinedInteractorTests.swift
//  
//
//  Created by hoseung Lee on 2022/05/22.
//

import Foundation
import Combine
import XCTest
@testable import NewlyCoinedKit

final class NewlyCoinedInteractorTests: XCTestCase {

  var sut: NewlyCoinedInteractor!
  var repository: MockNewlyCoinedRepository!
  var subscriptions: Set<AnyCancellable>!

  override func setUpWithError() throws {
    try super.setUpWithError()
    repository = MockNewlyCoinedRepository()
    sut = NewlyCoinedInteractor(repository: repository)
    subscriptions = []
  }

  override func tearDownWithError() throws {
    repository = nil
    sut = nil
    subscriptions = nil
    try super.tearDownWithError()
  }

  func testInteractor_whenFetchWords_connect() {
    // Given
    let exp = expectation(description: "fetch words")

    repository.handler = {
      exp.fulfill()
    }
    // When
    let _ = sut.fetchWords()
    // Then
    wait(for: [exp], timeout: 0.1)
  }

  func testInteractor_whenFetchWordsSuccess_ReceivedWordsDictionary() {
    // Given
    let exp = expectation(description: "fetch words")
    // When
    let result = sut.fetchWords()
    // Then
    result.sink { completionWithError in
      guard case .failure(let error) = completionWithError else { return }
      XCTAssert(false, error.localizedDescription)
    } receiveValue: { values in
      print(values.words)
      XCTAssertTrue(true)
      exp.fulfill()
    }
    .store(in: &subscriptions)
    wait(for: [exp], timeout: 0.1)
  }
}
