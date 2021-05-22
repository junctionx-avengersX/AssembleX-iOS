//
//  ServiceProvider.swift
//  Gilbert
//
//  Created by Tom on 2021/05/22.
//

import Foundation

protocol ServicesProviderType: AnyObject {
  var drivingService: DrivingService { get }
}

final class ServiceProvider: ServicesProviderType {
  lazy var drivingService: DrivingService = DrivingService(networking: Networking())
}
