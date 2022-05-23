//
//  NewlyCoinedSearchDisplay.swift
//  
//
//  Created by hoseung Lee on 2022/05/22.
//

import SwiftUI

struct NewlyCoinedSearchDisplay: View {
  @Binding var meaning: String
  var body: some View {
    VStack(spacing: 0) {
      ZStack(alignment: .leading) {
        Rectangle()
          .stroke(lineWidth: 1)
        HStack {
          Circle()
          Circle()
          Circle()
        }
        .frame(width: 30, alignment: .leading)
        .padding(.horizontal)
      }
      .frame(height: 20)
      ZStack {
        Text(meaning)
          .font(.title2)
          .padding()
        Rectangle()
          .stroke(lineWidth: 1)
          .overlay(
            HStack {
              Spacer()
              VStack {
                Image("apostrophe", bundle: .module)
                  .resizable()
                  .aspectRatio(nil, contentMode: .fit)
                  .frame(width: 40)
                  .rotationEffect(.degrees(180))
                  .padding()
                Spacer()
              }
            }
        )
      }
      Rectangle()
        .frame(height: 20)
    }

  }
}

struct NewlyCoinedSearchDisplay_Previews: PreviewProvider {
  static var previews: some View {
    NewlyCoinedSearchDisplay(meaning: .constant("뿌에에에엥"))
  }
}
