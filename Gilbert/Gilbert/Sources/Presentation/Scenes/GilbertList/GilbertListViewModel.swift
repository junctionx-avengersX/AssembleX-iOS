//
//  GilbertListViewModel.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import RxSwift
import RxCocoa

class GilbertListViewModel {
  
  private let navigator: GilbertListNavigator
  private let provider: ServiceProvider
  private let disposeBag = DisposeBag()
  init(
    navigator: GilbertListNavigator,
    provider: ServiceProvider
  ) {
    self.navigator = navigator
    self.provider = provider
  }
}

extension GilbertListViewModel {
  struct Input {
    
  }
  
  struct Output {
    
  }
  
  func transform(input: Input) -> Output {
    Output()
  }
}
