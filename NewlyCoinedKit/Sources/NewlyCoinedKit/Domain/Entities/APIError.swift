//
//  APIError.swift
//  
//
//  Created by hoseung Lee on 2022/05/22.
//

import Foundation

enum APIError: Error {
  case fetchFailure
}

extension APIError: LocalizedError {
  var errorDescription: String? {
    switch self {
      case .fetchFailure:
        return "신조어를 불러오는 데 실패했습니다"
    }
  }
}

