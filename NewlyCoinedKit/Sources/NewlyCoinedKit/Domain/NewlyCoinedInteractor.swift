//
//  NewlyCoinedInteractor.swift
//  
//
//  Created by hoseung Lee on 2022/05/22.
//

import Foundation
import Combine
import NewlyCoinedDB

protocol NewlyCoinedInteractorInterface {
  func fetchWords() -> AnyPublisher<NewlyWordsDictionary, APIError>
}

final class NewlyCoinedInteractor: NewlyCoinedInteractorInterface {

  //MARK: - Properties
  private let repository: NewlyCoinedRepositoryInterface
  private var subscriptions: Set<AnyCancellable> = []

  //MARK: - Methods
  init(repository: NewlyCoinedRepositoryInterface) {
    self.repository = repository
  }

  func fetchWords() -> AnyPublisher<NewlyWordsDictionary, APIError> {
    let result = repository.fetchCSVStrings()

    switch result {
      case .success(let words):
        let mapping = NewlyWordsDictionary(words: convertToDictionary(words))

        return Just(mapping)
          .setFailureType(to: APIError.self)
          .eraseToAnyPublisher()
      case .failure:
        return Fail(error: .fetchFailure)
          .eraseToAnyPublisher()
    }
  }

  private func convertToDictionary(_ parsedCsv: [[String]]) -> [NewlyWord] {
    parsedCsv
      .filter { $0.count == 2 }
      .compactMap {
        guard let key = $0[safe: 0], let value = $0[safe: 1] else { return nil }
        return [key: value]
      }
  }
}
