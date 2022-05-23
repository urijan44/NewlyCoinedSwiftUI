//
//  ContentView.swift
//  NewlyCoinedSwiftUI
//
//  Created by hoseung Lee on 2022/05/19.
//

import SwiftUI
import NewlyCoinedKit
import NewlyCoinedView
import NewlyCoinedDB

struct ContentView: View {
  var body: some View {
    makeNewlyCoinedSearchView()
  }

  @ViewBuilder
  func makeNewlyCoinedSearchView() -> some View {
    let parser = CSVParser()
    let repository = NewlyCoinedRepository(parser: parser)
    let interactor = NewlyCoinedInteractor(repository: repository)
    let usecase = NewlyCoinedUseCase(interactor: interactor)
    let viewModel = NewlyCoinedSearchView.ViewModel(usecase: usecase)
    NewlyCoinedSearchView(viewModel: viewModel)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
