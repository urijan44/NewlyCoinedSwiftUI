//
//  NewlyCoinedMessage.swift
//  
//
//  Created by hoseung Lee on 2022/05/22.
//

import Foundation

public struct NewlyCoinedMessage {
  public struct Request {
    public let searchWord: String

    public init(searchWord: String) {
      self.searchWord = searchWord
    }
  }

  public struct Response {
    public let resultMeaning: String
    public let randomKeyword: [String]

    public init(resultMeaning: String, randomKeyword: [String]) {
      self.resultMeaning = resultMeaning
      self.randomKeyword = randomKeyword
    }
  }
}
