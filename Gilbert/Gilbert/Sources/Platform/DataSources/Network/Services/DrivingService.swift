//
//  DrivingService.swift
//  Gilbert
//
//  Created by Tom on 2021/05/22.
//

import Foundation
import CoreLocation

import RxSwift

protocol DrivingServiceType: AnyObject {
  func getDriving(start: MapPosition, goal: MapPosition) -> Single<Driving>
}

class DrivingService: DrivingServiceType {
  fileprivate let networking: Networking

  init(networking: Networking) {
    self.networking = networking
  }
  
  func getDriving(start: MapPosition, goal: MapPosition) -> Single<Driving> {
    return self.networking.request(.target(DrivingAPI.pathNavigation(start: start, goal: goal)))
      .map(Driving.self)
  }
}
