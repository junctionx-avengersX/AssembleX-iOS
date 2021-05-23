//
//  GilbertListViewModel.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import RxSwift
import RxCocoa

class GilbertListViewModel {
  
  private let provider: ServiceProvider
  private let disposeBag = DisposeBag()
  
  var gilbertInfoPublishRelay = PublishRelay<Gilbert>()
  
  init(
    provider: ServiceProvider,
    gilbertInfoPublishRelay: PublishRelay<Gilbert>
  ) {
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
