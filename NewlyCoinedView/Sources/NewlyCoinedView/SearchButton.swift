//
//  SearchButton.swift
//  
//
//  Created by hoseung Lee on 2022/05/22.
//

import SwiftUI

struct SearchButton: View {

  private var action: () -> Void

  var body: some View {
    Image(systemName: "magnifyingglass")
      .resizable()
      .aspectRatio(nil, contentMode: .fit)
      .padding()
      .background(Color.black)
      .foregroundColor(.white)
      .onTapGesture {
        action()
      }
  }

  init(_ action: @escaping () -> Void) {
    self.action = action
  }
}

struct SearchButton_Previews: PreviewProvider {
  static var previews: some View {
    SearchButton { () }
  }
}
