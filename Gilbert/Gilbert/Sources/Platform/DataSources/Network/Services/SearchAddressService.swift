//
//  SearchAddressService.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import Foundation

import RxSwift

protocol SearchAddressServiceType: AnyObject {
  func searchAddress(query: String) -> Single<Driving>
}

class SearchAddressService: SearchAddressServiceType {
  fileprivate let networking: Networking

  init(networking: Networking) {
    self.networking = networking
  }
  
  func searchAddress(query: String) -> Single<Driving> {
    return self.networking
      .request(.target(SearchAddressAPI.searchAddress(query: query))
      )
      .map(Driving.self)
  }
}
