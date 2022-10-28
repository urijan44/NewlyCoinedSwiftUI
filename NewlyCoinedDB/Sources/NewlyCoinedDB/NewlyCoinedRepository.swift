//
//  NewlyCoinedRepository.swift
//  
//
//  Created by hoseung Lee on 2022/05/20.
//

import Foundation

public enum ParsingError: Error {
  case invalidBundlePath
  case parsingError
}

public protocol NewlyCoinedRepositoryInterface {
  func fetchCSVStrings() -> Result<[[String]], ParsingError>
}

final public class NewlyCoinedRepository: NewlyCoinedRepositoryInterface {
  //MARK: - Properties
  private let parser: CSVParserInterface
  private let bundlePath: String = {
    guard let mockCSVURL = Bundle.module.path(forResource: "NewlyCoinedWords", ofType: "csv") else {
      fatalError()
    }
    return mockCSVURL
  }()
  //MARK: - Methods
  public init(parser: CSVParserInterface) {
    self.parser = parser
  }

  public func fetchCSVStrings() -> Result<[[String]], ParsingError> {
    do {
      let searchResultPath = try searchBundlePath()
      let parseResult = try parser.parseBundle(searchResultPath)
      return .success(parseResult)
    } catch let error as ParsingError {
      return .failure(error)
    } catch {
      return .failure(.parsingError)
    }
  }

  private func searchBundlePath() throws -> String {
    guard let csvURL = Bundle.module.path(forResource: "NewlyCoinedWord", ofType: "csv") else {
      throw ParsingError.invalidBundlePath
    }
    return csvURL
  }
}
