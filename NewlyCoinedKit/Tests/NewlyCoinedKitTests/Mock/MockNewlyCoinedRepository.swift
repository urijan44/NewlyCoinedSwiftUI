//
//  MockNewlyCoinedRepository.swift
//  
//
//  Created by hoseung Lee on 2022/05/22.
//

import Foundation
import NewlyCoinedDB

final class MockNewlyCoinedRepository: NewlyCoinedRepositoryInterface {

  var handler: (() -> Void)?

  init() {}

  func fetchCSVStrings() -> Result<[[String]], ParsingError> {
    handler?()
    return .success([
      ["주불", "주소불러"],
      ["억까", "억지로 까내리다"]
    ])
  }
}
