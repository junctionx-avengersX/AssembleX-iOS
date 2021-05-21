//
//  DrivingService.swift
//  Gilbert
//
//  Created by Tom on 2021/05/22.
//

import Foundation

import RxSwift

protocol DrivingServiceType: AnyObject {
  func getDriving() -> Single<Driving>
}

class DrivingService: DrivingServiceType {
  fileprivate let networking: Networking

  init(networking: Networking) {
    self.networking = networking
  }
  
  func getDriving() -> Single<Driving> {
    return self.networking.request(.target(DrivingAPI.pathNavigation))
      .map(Driving.self)
  }
}
