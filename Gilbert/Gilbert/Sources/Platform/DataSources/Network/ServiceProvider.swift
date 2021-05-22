//
//  ServiceProvider.swift
//  Gilbert
//
//  Created by Tom on 2021/05/22.
//

import Foundation

protocol ServicesProviderType: AnyObject {
  var drivingService: DrivingService { get }
  
  var gilbertListService: GilbertListService { get }
  
  var searchAddressService: SearchAddressService { get }
}

final class ServiceProvider: ServicesProviderType {
  lazy var drivingService: DrivingService = DrivingService(networking: Networking())
  
  lazy var gilbertListService = GilbertListService(networking: Networking())
  
  lazy var searchAddressService = SearchAddressService(networking: Networking())
}
