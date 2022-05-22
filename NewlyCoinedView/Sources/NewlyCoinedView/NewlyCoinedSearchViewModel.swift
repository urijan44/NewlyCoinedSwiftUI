//
//  NewlyCoinedSearchViewModel.swift
//  
//
//  Created by hoseung Lee on 2022/05/22.
//

import Foundation
import Combine
import NewlyCoinedKit

extension NewlyCoinedSearchView {
  final public class ViewModel: ObservableObject {
    //MARK: - Properties
    private let interactor: NewlyCoinedInteractorInterface
    @Published var searchText: String = ""
    @Published var recomendWords: [String] = []
    @Published var wordMeaning: String = ""
    private var subscriptions: Set<AnyCancellable> = []

    //MARK: - Methods
    public init(interactor: NewlyCoinedInteractorInterface) {
      self.interactor = interactor

      let _ = interactor.fetchWords()
        .sink { completionWithError in
          guard case .failure(let error) = completionWithError else { return }
          print(error)
        } receiveValue: { _ in
        }
        .store(in: &subscriptions)

      searchWord()

    }

    public func searchWord() {
      let request = NewlyCoinedMessage.Request(searchWord: searchText)
      let subject = PassthroughSubject<NewlyCoinedMessage.Response, Never>()
      let publisher = interactor.searchWord(request: request)
        .multicast(subject: subject)

      subject
        .map {
          $0.resultMeaning
        }
        .assign(to: \.wordMeaning, on: self)
        .store(in: &subscriptions)

      subject
        .map {
          $0.randomKeyword
        }
        .assign(to: \.recomendWords, on: self)
        .store(in: &subscriptions)

      let _ = publisher.connect()
    }
  }
}
