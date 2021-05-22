//
//  SearchAddressService.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import Foundation

import RxSwift

protocol SearchAddressServiceType: AnyObject {
  func searchAddress(query: String) -> Single<[SearchAddressSectionModel]>
}

class SearchAddressService: SearchAddressServiceType {
  fileprivate let networking: Networking

  init(networking: Networking) {
    self.networking = networking
  }
  
  func searchAddress(query: String) -> Single<[SearchAddressSectionModel]> {
    return self.networking
      .request(.target(SearchAddressAPI.searchAddress(query: query))
      )
      .map(AddressDetailInfoList.self)
      .flatMap { list -> Single<[SearchAddressSectionModel]> in
        if let items = list.place {
          let sectionModel = SearchAddressSectionModel(items: items)
          return Single<[SearchAddressSectionModel]>.just([sectionModel])
        } else {
          return Single<[SearchAddressSectionModel]>.just([])
        }
      }
  }
}
