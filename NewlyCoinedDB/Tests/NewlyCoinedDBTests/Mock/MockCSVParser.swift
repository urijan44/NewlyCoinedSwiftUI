//
//  MockCSVParser.swift
//  
//
//  Created by hoseung Lee on 2022/05/21.
//

import Foundation
@testable import NewlyCoinedDB

final class MockCSVParser: CSVParserInterface {
  var success: Bool = false
  init() {}

  func parseBundle(_ bundlePath: String) throws -> [[String]] {
    if success {
      return [
        ["1", "일번"],
        ["2", "이번"]
      ]
    } else {
      throw NSError(domain: "실패", code: -1)
    }
  }
}
