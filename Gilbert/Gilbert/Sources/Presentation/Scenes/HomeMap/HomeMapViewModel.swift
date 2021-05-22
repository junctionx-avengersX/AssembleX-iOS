//
//  HomeMapViewModel.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import RxSwift
import RxCocoa

class HomeMapViewModel {
  
  let destinationRelay = PublishRelay<(MapPosition, MapPosition)>()
  
  private let useCase: HomeMapUseCase
  
  private let navigator: HomeMapNavigator
  
  private let disposeBag = DisposeBag()
  
  init(
    useCase: HomeMapUseCase,
    navigator: HomeMapNavigator
  ) {
    self.useCase = useCase
    self.navigator = navigator
    self.provider = provider
  }
}

extension HomeMapViewModel: ViewModelType {
  struct Input {
    let destination: Observable<(MapPosition, MapPosition)>
  }
  struct Output {
    let user: Observable<Driving>
  }
  
  func transform(input: Input) -> Output {
    let driving = input.destination.flatMapLatest {
      [weak self] position -> Observable<Driving> in
      guard let this = self else { return Observable.empty() }
      return this.provider.drivingService.getDriving(start: position.0, goal: position.1).asObservable()
    }
    
    return Output(user: driving)
  }
}