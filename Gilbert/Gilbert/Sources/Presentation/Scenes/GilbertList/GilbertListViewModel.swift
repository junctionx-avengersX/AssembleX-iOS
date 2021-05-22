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
  private var gilbertInfoPublishRelay = PublishRelay<Gilbert>()
  
  init(
    navigator: GilbertListNavigator,
    provider: ServiceProvider,
    gilbertInfoPublishRelay: PublishRelay<Gilbert>
  ) {
    self.navigator = navigator
    self.provider = provider
    self.gilbertInfoPublishRelay = gilbertInfoPublishRelay
  }
}

extension GilbertListViewModel {
  struct Input {
    let initialTrigger: Observable<Void>
  }
  
  struct Output {
    let receivedGilbertList: Observable<[GilbertListSectionModel]>
  }
  
  func transform(input: Input) -> Output {
    let receivedGilbertList = input.initialTrigger.flatMapLatest { [weak self] _ -> Observable<[GilbertListSectionModel]> in
      guard let this = self else { return Observable.empty() }
      return this.provider.gilbertListService.fetchGilbertList(base: "ddd", destination: "dddd", transportations: TransportationType.bus.rawValue)
        .asObservable()
    }
    
    return Output(receivedGilbertList: receivedGilbertList)
  }
}
