//
//  HomeMapUseCase.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import Foundation

class HomeMapUseCase {
  
  // MARK: - Properties
  
  let repository: HomeMapRepository
  
  // MARK: - Con(De)structor
  
  init(repository: HomeMapRepository) {
    self.repository = repository
  }
}
