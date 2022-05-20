//
//  CSVParser.swift
//  
//
//  Created by hoseung Lee on 2022/05/20.
//

import Foundation

final class CSVParser {
  init() {}

  func parseBundle(_ bundlePath: String) throws -> Data {

    let url = URL(fileURLWithPath: bundlePath)

    do {
      let data = try Data(contentsOf: url)
      return data
    } catch let error {
      throw error
    }
  }
}
