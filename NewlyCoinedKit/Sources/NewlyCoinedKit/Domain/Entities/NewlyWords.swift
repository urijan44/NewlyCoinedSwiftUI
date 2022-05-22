//
//  NewlyWords.swift
//  
//
//  Created by hoseung Lee on 2022/05/22.
//

import Foundation

typealias NewlyWord = [String: String]
public struct NewlyWordsDictionary {
  let words: [String: String]

  func findWord(word: String) -> String? {
    words[word]
  }

  func randomKeywords() -> [String] {
    let random = words.keys.shuffled()
    return (0...3).map { (random[safe: $0] ?? "") }
  }

  init(words: NewlyWord) {
    self.words = words
  }
}
