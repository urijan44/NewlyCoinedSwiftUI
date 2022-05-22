//
//  NewlyCoinedSearchField.swift
//
//
//  Created by hoseung Lee on 2022/05/22.
//

import SwiftUI

struct NewlyCoinedSearchField: View {

  @State private var imageSize: CGSize = .zero
  @Binding var recomendWords: [String]
  @Binding var searchText: String
  var action: (String) -> Void

  var body: some View {
    VStack {
      searchField
        .padding()
    }
  }

  var searchField: some View {
    GeometryReader { proxy in
      VStack {
        HStack(spacing: 0) {
          TextField("신조어를 입력하세요", text: $searchText) {
            action(searchText)
          }
            .textFieldStyle(NewlyCoinedTextFieldStyle())
            .anchorPreference(key: ViewSizePreferenceKey.self, value: .bounds) { anchor in
              ViewSize(id: "TextField", anchor: anchor)
            }
          searchButton(seachText: searchText)
            .frame(height: imageSize.height)
        }

        .onPreferenceChange(ViewSizePreferenceKey.self) { value in
          guard let value = value else { return }
          imageSize = proxy[value.anchor].size
        }
        NewlyCoinedSearchRecomendTag(tags: $recomendWords) { selectedTag in
          searchText = selectedTag
        }
      }
    }
  }

  @ViewBuilder func searchButton(seachText: String) -> some View {
    SearchButton {
      action(searchText)
    }
  }

  init(recomendWords: Binding<[String]>, searchText: Binding<String>, action: @escaping (String) -> Void) {
    self._recomendWords = recomendWords
    self._searchText = searchText
    self.action = action
  }
}

struct ViewSize: Equatable, Identifiable {
  let id: String
  let anchor: Anchor<CGRect>
}

struct ViewSizePreferenceKey: PreferenceKey {
  static var defaultValue: ViewSize?
  static func reduce(value: inout Value, nextValue: () -> Value) {
    defaultValue = nextValue()
  }
}

struct NewlyCoinedTextFieldStyle: TextFieldStyle {
  public func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
      .padding()
      .border(.black, width: 2)
  }
}
