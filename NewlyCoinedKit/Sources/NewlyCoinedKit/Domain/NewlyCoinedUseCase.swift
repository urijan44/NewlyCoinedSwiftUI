//
//  NewlyCoinedUseCase.swift
//  
//
//  Created by leehs81 on 2022/05/23.
//

import Foundation
import Combine

public protocol NewlyCoinedUseCaseInterfacoe {
  func fetchWords() -> AnyPublisher<NewlyWordsDictionary, APIError>
  func searchWord(request: NewlyCoinedMessage.Request) -> AnyPublisher<NewlyCoinedMessage.Response, Never>
}

final public class NewlyCoinedUseCase {
  private let interactor: NewlyCoinedInteractorInterface
  private var cancallable: Set<AnyCancellable> = []
  public init(interactor: NewlyCoinedInteractorInterface) {
    self.interactor = interactor
  }
}

extension NewlyCoinedUseCase: NewlyCoinedUseCaseInterfacoe {
  public func fetchWords() -> AnyPublisher<NewlyWordsDictionary, APIError> {
    interactor.fetchWords()
  }
  
  public func searchWord(request: NewlyCoinedMessage.Request) -> AnyPublisher<NewlyCoinedMessage.Response, Never> {
    let result = interactor.searchWord(request: request)
    return interactor.searchWord(request: request)
      .flatMap { [unowned self] response -> AnyPublisher<NewlyCoinedMessage.Response, Never> in
        if response.resultMeaning.isEmpty {
          return interactor.recomandWord(request: request).eraseToAnyPublisher()
        } else {
          return result
        }
      }
      .eraseToAnyPublisher()
  }
}


