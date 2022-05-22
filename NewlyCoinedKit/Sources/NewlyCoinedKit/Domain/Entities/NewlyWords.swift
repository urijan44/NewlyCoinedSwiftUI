//
//  NewlyWords.swift
//  
//
//  Created by hoseung Lee on 2022/05/22.
//

import Foundation

typealias NewlyWord = [String: String]
struct NewlyWordsDictionary {
  let words: [String: String]

  func findWord(word: String) -> String? {
    words[word]
  }

  func randomKeywords() -> [String] {
    var randomwords: [String] = []

    for _ in 1...4 {
      randomwords.append(words.values.randomElement() ?? "")
    }
    return randomwords
  }

  init(words: NewlyWord) {
    self.words = words
  }
}
