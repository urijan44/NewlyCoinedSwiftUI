//
//  NewlyCoinedSearchView.swift
//  
//
//  Created by hoseung Lee on 2022/05/22.
//

import SwiftUI

struct NewlyCoinedSearchView: View {
  var body: some View {
    ZStack {
      NewlyCoinedSearchField()
      VStack {
        NewlyCoinedSearchDisplay()
          .frame(height: UIScreen.main.bounds.height / 2)
          .padding(.horizontal)
      }
      Spacer()
    }
  }
} 

struct NewlyCoinedSearchView_Previews: PreviewProvider {
  static var previews: some View {
    NewlyCoinedSearchView()
  }
}
