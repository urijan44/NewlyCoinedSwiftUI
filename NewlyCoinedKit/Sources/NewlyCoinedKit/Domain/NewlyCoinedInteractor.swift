//
//  NewlyCoinedInteractor.swift
//  
//
//  Created by hoseung Lee on 2022/05/22.
//

import Foundation
import Combine
import NewlyCoinedDB

public protocol NewlyCoinedInteractorInterface {
  func fetchWords() -> AnyPublisher<NewlyWordsDictionary, APIError>
  func searchWord(request: NewlyCoinedMessage.Request) -> AnyPublisher<NewlyCoinedMessage.Response, Never>
  func recomandWord(request: NewlyCoinedMessage.Request) -> AnyPublisher<NewlyCoinedMessage.Response, Never>
}

final public class NewlyCoinedInteractor {

  //MARK: - Properties
  private let repository: NewlyCoinedRepositoryInterface
  private var subscriptions: Set<AnyCancellable> = []
  private var newlyWords: NewlyWordsDictionary = .init(words: [:])

  //MARK: - Methods
  public init(repository: NewlyCoinedRepositoryInterface) {
    self.repository = repository
  }

  private func convertToDictionary(_ parsedCsv: [[String]]) -> NewlyWord {
    var dictionary: [String: String] = [:]
    parsedCsv
      .forEach {
        guard let key = $0[safe: 0], let value = $0[safe: 1] else { return }
        dictionary.updateValue(value, forKey: key)
      }
    return dictionary
  }
}

extension NewlyCoinedInteractor: NewlyCoinedInteractorInterface {

  public func fetchWords() -> AnyPublisher<NewlyWordsDictionary, APIError> {
    let result = repository.fetchCSVStrings()

    switch result {
      case .success(let words):
        let mapping = NewlyWordsDictionary(words: convertToDictionary(words))
        newlyWords = mapping
        return Just(mapping)
          .setFailureType(to: APIError.self)
          .eraseToAnyPublisher()
      case .failure:
        return Fail(error: .fetchFailure)
          .eraseToAnyPublisher()
    }
  }

  public func searchWord(request: NewlyCoinedMessage.Request) -> AnyPublisher<NewlyCoinedMessage.Response, Never> {
    let word = request.searchWord
    let randomKeyword = newlyWords.randomKeywords()
    let resultMeaning = newlyWords.findWord(word: word) ?? ""
    let response = NewlyCoinedMessage.Response(resultMeaning: resultMeaning, randomKeyword: randomKeyword)
    return Just(response)
      .eraseToAnyPublisher()
  }
  
    public func recomandWord(request: NewlyCoinedMessage.Request) -> AnyPublisher<NewlyCoinedMessage.Response, Never> {
    let randomKeyword = newlyWords.randomKeywords()
        let resultMeaning = "\(request.searchWord)를 찾을 수 없습니다.\n\(randomKeyword.first ?? "")의 뜻은 무엇일까요?"
    let response = NewlyCoinedMessage.Response(resultMeaning: resultMeaning, randomKeyword: randomKeyword)
    return Just(response)
      .eraseToAnyPublisher()
  }
}
