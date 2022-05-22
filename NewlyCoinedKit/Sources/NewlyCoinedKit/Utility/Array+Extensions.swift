//
//  Array+Extensions.swift
//  
//
//  Created by hoseung Lee on 2022/05/22.
//

import Foundation

extension Array {
  subscript(safe index: Int) -> Element? {
    guard index >= startIndex, index < endIndex else {
      return nil
    }
    return self[index]
  }
}
