//
//  HomeMapViewModel.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import RxSwift
import RxCocoa

class HomeMapViewModel {
  
  private let useCase: HomeMapUseCase
  
  private let navigator: HomeMapNavigator
  
  private let disposeBag = DisposeBag()
  
  init(
    useCase: HomeMapUseCase,
    navigator: HomeMapNavigator
  ) {
    self.useCase = useCase
    self.navigator = navigator
  }
}
