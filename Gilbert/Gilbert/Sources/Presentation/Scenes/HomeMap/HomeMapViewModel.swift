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
  private let provider: ServiceProvider
  
  private let disposeBag = DisposeBag()
  
  init(
    useCase: HomeMapUseCase,
    navigator: HomeMapNavigator,
    provider: ServiceProvider
  ) {
    self.useCase = useCase
    self.navigator = navigator
  }
}

extension HomeMapViewModel: ViewModelType {
  struct Input {
    let destination: Driver<(MapPosition, MapPosition)>
  }
  struct Output {
    let user: Driver<Driving>
  }
  
  func transform(input: Input) -> Output {
    let driving: Driver<Driving> = input.destination.flatMapLatest { [weak self] (start, goal) in
      return provider.drivingService.getDriving(start: start, goal: goal).asObservable().asDriverOnErrorJustNever()
    }
    return Output(user: driving)
  }
}
