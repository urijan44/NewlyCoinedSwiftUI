//
//  NewlyCoinedSearchRecomendTag.swift
//  
//
//  Created by hoseung Lee on 2022/05/22.
//

import SwiftUI

struct NewlyCoinedSearchRecomendTag: View {

  @Binding var tags: [String]
  var action: (String) -> ()

  var body: some View {
    HStack(spacing: 6) {
      ForEach(tags, id: \.self) { tag in
        tagView(title: tag)
          .onTapGesture {
            action(tag)
          }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  @ViewBuilder func tagView(title: String) -> some View {
    Text(title)
      .font(.caption)
      .padding(3)
      .background(
        RoundedRectangle(cornerRadius: 6)
          .stroke(lineWidth: 1)
      )
  }

  init(tags: Binding<[String]>, action: @escaping (String) -> ()) {
    self._tags = tags
    self.action = action
  }
}

struct NewlyCoinedSearchRecomendTag_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      NewlyCoinedSearchRecomendTag(tags: .constant(["윰차", "실매", "만만잘부", "꾸안꾸"])) { selected in
        print(selected)
      }
    }

  }
}
