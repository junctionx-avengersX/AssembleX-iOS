//
//  GilbertListService.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import Foundation

import RxSwift

protocol GilbertListServiceType: AnyObject {
  // func fetchGilbertList()
}

class GilbertListService: GilbertListServiceType {
  fileprivate let networking: Networking

  init(networking: Networking) {
    self.networking = networking
  }
  
  func getDriving(start: MapPosition, goal: MapPosition) -> Single<Driving> {
    return self.networking.request(.target(DrivingAPI.pathNavigation(start: start, goal: goal)))
      .map(Driving.self)
  }
}
