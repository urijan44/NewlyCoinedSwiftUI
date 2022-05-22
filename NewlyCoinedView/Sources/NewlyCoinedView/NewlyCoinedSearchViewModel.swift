//
//  NewlyCoinedSearchViewModel.swift
//  
//
//  Created by hoseung Lee on 2022/05/22.
//

import Foundation
import Combine

extension NewlyCoinedSearchView {
  final public class ViewModel: ObservableObject {
    //MARK: - Properties
    @Published var searchText: String = ""
    @Published var recomendWords: [String] = []
    @Published var wordMeaning: String = ""

    //MARK: - Methods
    public init() {}
  }
}
