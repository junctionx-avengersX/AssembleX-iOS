//
//  SearchAddressViewModel.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import RxCocoa
import RxSwift

class SearchAddressViewModel {
  
  private let provider: ServiceProvider
  
  var selectedAddressPublishRelay: PublishRelay<AddressDetailInfo>
  
  var textInputPublishRelay = PublishRelay<String?>()
  
  init(
    provider: ServiceProvider,
    selectedAddressPublishRelay: PublishRelay<AddressDetailInfo>
  ) {
    self.provider = provider
    self.selectedAddressPublishRelay = selectedAddressPublishRelay
  }
}

extension SearchAddressViewModel {
  
  struct Input {
    let destinationTextFieldQuery: Observable<String?>
  }
  
  struct Output {
    let placesInfoReceived: Observable<[SearchAddressSectionModel]>
  }
  
  func transform(input: Input) -> Output {
    
    let placesReceived = input.destinationTextFieldQuery.flatMapLatest { [weak self] query -> Observable<[SearchAddressSectionModel]> in
      guard let this = self, let query = query else { return Observable.empty() }
      
      return this.provider.searchAddressService.searchAddress(query: query)
        .asObservable()
    }
    
    return Output(placesInfoReceived: placesReceived)
  }
}
