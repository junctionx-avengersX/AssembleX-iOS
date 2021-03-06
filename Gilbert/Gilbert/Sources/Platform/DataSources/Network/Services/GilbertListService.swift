//
//  GilbertListService.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import Foundation

import RxSwift

protocol GilbertListServiceType: AnyObject {
  func fetchGilbertList(base: String, destination: String, transportations: String) -> Single<[GilbertListSectionModel]>
}

class GilbertListService: GilbertListServiceType {
  
  fileprivate let networking: Networking

  init(networking: Networking) {
    self.networking = networking
  }
  
  func fetchGilbertList(base: String, destination: String, transportations: String) -> Single<[GilbertListSectionModel]> {
    return self.networking.request(
      .target(GilbertListAPI.fetchGilbertList(base: base, destination: destination, transportations: transportations))
    )
    .map([Gilbert].self)
    .flatMap { gilberts -> Single<[GilbertListSectionModel]> in
      let sectionModel = GilbertListSectionModel(items: gilberts)
      return Single<[GilbertListSectionModel]>.just([sectionModel])
    }
  }
}
