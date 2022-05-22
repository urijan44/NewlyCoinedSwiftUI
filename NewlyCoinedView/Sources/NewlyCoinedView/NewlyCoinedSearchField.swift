//
//  NewlyCoinedSearchField.swift
//
//
//  Created by hoseung Lee on 2022/05/22.
//

import SwiftUI

struct NewlyCoinedSearchField: View {

  @State var imageSize: CGSize = .zero
  @State var text = ""

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
          TextField("신조어를 입력하세요", text: .constant("삼귀자"))
            .textFieldStyle(NewlyCoinedTextFieldStyle())
            .anchorPreference(key: ViewSizePreferenceKey.self, value: .bounds) { anchor in
              ViewSize(id: "TextField", anchor: anchor)
            }
          searchButton
            .frame(height: imageSize.height)
        }

        .onPreferenceChange(ViewSizePreferenceKey.self) { value in
          guard let value = value else { return }
          imageSize = proxy[value.anchor].size
        }
        NewlyCoinedSearchRecomendTag(tags: .constant(["윰차", "실매", "만만잘부", "꾸안꾸"])) { keyword in
          print(keyword)
        }
      }
    }
  }

  var searchButton: some View {
    SearchButton {
      text = "search!!"
    }
  }
}

struct NewlyCoinedSearchField_Previews: PreviewProvider {
  static var previews: some View {
    NewlyCoinedSearchField()
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
