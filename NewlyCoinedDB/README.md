# NewlyCoinedDB

신조어 검색이 DB

## Feature
- CSVParser
  - CSVParserInterface
- NewlyCoinedRepository
  - NewlyCoinedRepository

## Example
- CSVParser (closed)
- NewlyCoinedRepository
  ```swift
  let repository: NewlyCoinedRepositoryInterface
  
  repository.fetchCSVStrings() -> Result<[[String]], ParsingError>
  ```


