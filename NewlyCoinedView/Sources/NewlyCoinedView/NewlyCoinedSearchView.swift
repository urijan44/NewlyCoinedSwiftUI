//
//  NewlyCoinedSearchView.swift
//  
//
//  Created by hoseung Lee on 2022/05/22.
//

import SwiftUI
import Combine

public struct NewlyCoinedSearchView: View {
  @ObservedObject var viewModel: ViewModel
  @State var isShowingDisplay = true

  private var keyboardHeightPublisher: AnyPublisher<Bool, Never> {
    Publishers.Merge(
      NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .map { _ in false },
      NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in true })
    .eraseToAnyPublisher()
  }

  public var body: some View {
    ZStack {
      NewlyCoinedSearchField(
        recomendWords: $viewModel.recomendWords,
        searchText: $viewModel.searchText) { commitWord in
          print(commitWord)
        }
        .zIndex(0)
      Rectangle()
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
          endEditing()
        }
        .zIndex(-1)
      VStack {
        if isShowingDisplay {
          NewlyCoinedSearchDisplay(meaning: $viewModel.wordMeaning)
            .frame(height: UIScreen.main.bounds.height / 2)
            .padding(.horizontal)
            .transition(.move(edge: .bottom).animation(.easeIn(duration: 1)))
        }
      }
      .zIndex(1)
    }
    .onReceive(keyboardHeightPublisher) { isShowing in
      withAnimation {
        isShowingDisplay = isShowing
      }
    }
  }

  public init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }
} 

struct NewlyCoinedSearchView_Previews: PreviewProvider {
  static var previews: some View {
    NewlyCoinedSearchView(viewModel: .init())
  }
}

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
