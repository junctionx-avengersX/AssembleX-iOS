//
//  HomeMapViewController.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit
import CoreLocation

import NMapsMap
import RxCocoa

final class HomeMapViewController: BaseViewController {
  
  let naverMapView: NMFNaverMapView = .init()
  
  // MARK: - Properties
  let locationManager: CLLocationManager = .init()
  
  private let viewModel: HomeMapViewModel
  
  // MARK: - Con(De)structor
  
  init(viewModel: HomeMapViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .blue

    initializeNaverMap()
    initializeLocation()
    bindViewModel()
  }
  
  override func setupConstraints() {
    naverMapView.snp.makeConstraints {
      $0.bottom.left.right.top.equalTo(self.view)
    }
  }
  fileprivate func initializeNaverMap() {
    self.naverMapView.showLocationButton = true
    self.naverMapView.mapView.positionMode = .normal
    
    view.addSubview(naverMapView)
  }
  
  fileprivate func initializeLocation() {
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    
    if CLLocationManager.locationServicesEnabled() {
      print("위치 서비스 On 상태")
      locationManager.startUpdatingLocation()
      print(locationManager.location?.coordinate)
    } else {
      print("위치 서비스 Off 상태")
    }
  }
  

  private func bindViewModel() {
    let input = type(of: self.viewModel).Input(destination: viewModel.destinationRelay.asObservable())
    let output = viewModel.transform(input: input)
    
    // TODO: UI 작업
    output
  }
}

extension HomeMapViewController: CLLocationManagerDelegate {
  func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      if let location = locations.first {
        naverMapView.mapView.moveCamera(.init(scrollTo: .init(lat: location.coordinate.latitude, lng: location.coordinate.longitude)))
         
        viewModel.destinationRelay
        
        print("위도: \(location.coordinate.latitude)")
        print("경도: \(location.coordinate.longitude)")
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }
}
