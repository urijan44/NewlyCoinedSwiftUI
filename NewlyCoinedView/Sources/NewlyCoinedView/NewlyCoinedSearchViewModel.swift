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
    private let usecase: NewlyCoinedUseCaseInterfacoe
    @Published var searchText: String = ""
    @Published var recomendWords: [String] = []
    @Published var wordMeaning: String = ""
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - Methods
    public init(usecase: NewlyCoinedUseCaseInterfacoe) {
      self.usecase = usecase
      
      let _ = usecase.fetchWords()
        .sink { completionWithError in
          guard case .failure = completionWithError else { return }
        } receiveValue: { _ in }
        .store(in: &subscriptions)
      
      searchWord()
    }
    
    func searchWord() {
      usecase
        .searchWord(request: NewlyCoinedMessage.Request(searchWord: searchText))
        .subscribe(on: DispatchQueue.main)
        .sink(receiveValue: { [unowned self] response in
          fetchWordHandling(response)
        })
        .store(in: &subscriptions)
    }
    
    private func fetchWordHandling(_ response: NewlyCoinedMessage.Response) {
      wordMeaning = response.resultMeaning
      recomendWords = response.randomKeyword
    }
  }
}
