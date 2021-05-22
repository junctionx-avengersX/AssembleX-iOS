//
//  HomeMapViewController.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit
import CoreLocation

import NMapsMap
import RxSwift
import RxCocoa
import ReactorKit

final class HomeMapViewController: BaseViewController, View {
  
  // MARK: UI
  let naverMapView: NMFNaverMapView = .init()
  let timeFrameView: UIView = UIView().then {
    $0.backgroundColor = .white
    $0.layer.cornerRadius = 8
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowOpacity = 0.15
    $0.layer.shadowRadius = 24.0
  }
  let timeButton: UIButton = UIButton().then {
    $0.backgroundColor = .white
    $0.layer.cornerRadius = 4
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.init(hex: "#e8ecf2").cgColor
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowOpacity = 0.09
    $0.layer.shadowRadius = 8.0
    
    $0.titleLabel?.font = .systemFont(ofSize: 16)
    $0.setTitle("Times setup", for: .normal)
    $0.setTitleColor(.black, for: .normal)
    $0.setImage(UIImage(named: "icon_timer"), for: .normal)
    $0.tintColor = .init(hex: "#32d74b")
    $0.contentHorizontalAlignment = .leading
    $0.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
    $0.titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 0)
  }
  
  let arrowImageView: UIImageView = UIImageView().then {
    $0.image = UIImage(named: "icon_arrow_down")
    $0.isUserInteractionEnabled = false
  }
  
  let searchButton: UIButton = UIButton().then {
    $0.backgroundColor = .white
    $0.layer.cornerRadius = 4
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowOpacity = 0.15
    $0.layer.shadowRadius = 8.0
    
    $0.titleLabel?.font = .systemFont(ofSize: 16)
    $0.setTitle("Where to go?", for: .normal)
    $0.setTitleColor(.init(hex: "#adb5bd"), for: .normal)
    $0.contentHorizontalAlignment = .leading
    $0.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
  }
  
  let searchImageView: UIImageView = UIImageView().then {
    $0.image = UIImage(named: "icon_search")
    $0.isUserInteractionEnabled = false
  }
  
  lazy var marker: NMFMarker = NMFMarker().then {
    $0.iconImage = currentMarker
    $0.width = CGFloat(NMF_MARKER_SIZE_AUTO)
    $0.height = CGFloat(NMF_MARKER_SIZE_AUTO)
  }
  let currentMarker: NMFOverlayImage = .init(image: UIImage(named: "image_marker")!)
  
  // MARK: Properties
  let locationManager: CLLocationManager = .init()
  
  var firstPosition: NMGLatLng? {
    didSet {
      if let firstPosition = firstPosition {
        naverMapView.mapView.moveCamera(.init(scrollTo: firstPosition))
      }
    }
  }
  
  // MARK: Initializing
  init(reactor: HomeMapReactor) {
    defer { self.reactor = reactor }
    super.init()
  }
  
  required convenience init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initializeNaverMap()
    self.view.addSubview(self.timeFrameView)
    self.view.addSubview(self.timeButton)
    self.timeButton.addSubview(self.arrowImageView)
    
    self.view.addSubview(self.searchButton)
    self.searchButton.addSubview(self.searchImageView)
    
    initializeLocation()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  override func setupConstraints() {
    naverMapView.snp.makeConstraints {
      $0.left.right.top.equalTo(self.view)
      $0.bottom.equalTo(self.timeFrameView.snp.top).offset(8)
    }
    
    self.timeFrameView.snp.makeConstraints {
      $0.left.right.equalTo(self.view)
      $0.bottom.equalTo(self.view).offset(100)
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-80)
    }
    
    self.timeButton.snp.makeConstraints {
      $0.bottom.equalTo(self.view).offset(-16)
      $0.top.left.equalTo(self.timeFrameView).offset(16)
      $0.right.equalTo(self.timeFrameView).offset(-16)
    }
    
    self.arrowImageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.right.equalToSuperview().offset(-16)
    }
    
    self.searchButton.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
      $0.left.equalToSuperview().offset(16)
      $0.right.equalToSuperview().offset(-16)
      $0.height.equalTo(48)
    }
    
    self.searchImageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.right.equalToSuperview().offset(-16)
    }
  }
  
  // MARK: Binding
  func bind(reactor: HomeMapReactor) {
    self.bindView(reactor)
    self.bindState(reactor)
    self.bindAction(reactor)
  }
  
  fileprivate func initializeNaverMap() {
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
}

extension HomeMapViewController {
  // MARK: views (View -> View)
  func bindView(_ reactor: HomeMapReactor) {
    self.timeButton.rx.tap.asObservable()
      .bind(onNext: { [weak self] in
        let date = reactor.currentState.reservationTime
        let viewController = TimeModalViewController(with: date)
        viewController.modalPresentationStyle = .custom
        viewController.completionHandler = { [weak self] date in
          self?.reactor?.action.on(.next(Reactor.Action.reservationTime(date)))
        }
        self?.present(viewController, animated: true, completion: nil)
      })
      .disposed(by: self.disposeBag)
  }
  
  // MARK: actions (View -> Reactor)
  func bindAction(_ reactor: HomeMapReactor) {
    
  }
  
  // MARK: states (Reactor -> View)
  func bindState(_ reactor: HomeMapReactor) {
    reactor.state.map { $0.reservationTime }
      .asObservable()
      .distinctUntilChanged()
      .bind(onNext: { [weak self] reservationTime in
        if let reservationTime = reservationTime {
          let dateFormatter: DateFormatter = .init()
          dateFormatter.dateFormat = "(EEE) hh:mm"
          let dateString = dateFormatter.string(from: reservationTime)
          self?.timeButton.layer.borderColor = UIColor.init(hex: "#32d74b").cgColor
          self?.timeButton.setTitle("Today \(dateString)", for: .normal)
        }else {
          self?.timeButton.layer.borderColor = UIColor.init(hex: "#e8ecf2").cgColor
          self?.timeButton.setTitle("Times setup", for: .normal)
        }
      })
      .disposed(by: self.disposeBag)
  }
}

extension HomeMapViewController: CLLocationManagerDelegate {
  func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      if let location = locations.first {
        let position: NMGLatLng = .init(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
        marker.position = position
        marker.mapView = self.naverMapView.mapView
        if self.firstPosition == nil {
          firstPosition = position
        }
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }
}
