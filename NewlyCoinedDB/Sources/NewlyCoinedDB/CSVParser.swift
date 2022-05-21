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

  func parseData(_ data: Data) throws -> [[String]] {

    guard let string = String(data: data, encoding: .utf8) else {
      throw NSError(domain: "invalid encoding type, converter encoding type is utf8", code: -1)
    }

    return separatorComma(string)
  }

  private func separatorComma(_ plainCsv: String) -> [[String]] {
    plainCsv.components(separatedBy: "\r\n").map{$0.components(separatedBy: ",")}.filter { !$0.isEmpty }
  }
}
