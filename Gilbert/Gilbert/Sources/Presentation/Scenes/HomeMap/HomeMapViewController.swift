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
    $0.zIndex = -10
  }
  let currentMarker: NMFOverlayImage = .init(image: UIImage(named: "image_marker")!)
  
  lazy var arrivalMaker: NMFMarker = NMFMarker().then {
    $0.width = CGFloat(NMF_MARKER_SIZE_AUTO)
    $0.height = CGFloat(NMF_MARKER_SIZE_AUTO)
    $0.iconImage = arrivalImage
  }
  let arrivalImage: NMFOverlayImage = .init(image: .init(named: "image_arrival")!)
  
  lazy var departureMaker: NMFMarker = NMFMarker().then {
    $0.width = CGFloat(NMF_MARKER_SIZE_AUTO)
    $0.height = CGFloat(NMF_MARKER_SIZE_AUTO)
    $0.iconImage = departureImage
  }
  let departureImage: NMFOverlayImage = .init(image: .init(named: "image_departure")!)
  
  lazy var gillbertMaker: NMFMarker = NMFMarker().then {
    $0.width = CGFloat(NMF_MARKER_SIZE_AUTO)
    $0.height = CGFloat(NMF_MARKER_SIZE_AUTO)
    $0.iconImage = gillbertImage
  }
  let gillbertImage: NMFOverlayImage = .init(image: .init(named: "image_pro")!)
  
  // MARK: Properties
  let locationManager: CLLocationManager = .init()
  
  var isOpenedRoute: Bool = false
  var isOpenedCall: Bool = false
  
  var firstPosition: NMGLatLng? {
    didSet {
      if let firstPosition = firstPosition {
        naverMapView.mapView.moveCamera(.init(scrollTo: firstPosition))
      }
    }
  }
  var gillbertPosition: NMGLatLng?
  
  var gilbert: Gilbert?
  
  var arrivalPosition: NMGLatLng?
  
  var polylines: [NMFPolylineOverlay] = .init()
  
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
    naverMapView.showZoomControls = false
    naverMapView.mapView.contentInset = .init(top: 100, left: 60, bottom: 200, right: 60)
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
    
    self.searchButton.rx.tap.asObservable()
      .bind(onNext: {
        let serviceProvider = ServiceProvider()
        let viewModel = SearchAddressViewModel(
          
          provider: serviceProvider, selectedAddressPublishRelay: PublishRelay<AddressDetailInfo?>()
        )
        let searchAddressViewController = SearchAddressViewController(viewModel: viewModel)
        searchAddressViewController.hidesBottomBarWhenPushed = true
        
        viewModel.selectedAddressPublishRelay.asObservable()
          .subscribe(onNext: { [weak self] addressInfo in
            self?.reactor?.action.on(.next(Reactor.Action.findAddressInfo(addressInfo)))
          })
          .disposed(by: self.disposeBag)
        
        self.navigationController?.pushViewController(searchAddressViewController, animated: true)
      })
      .disposed(by: self.disposeBag)
    
    self.rx.viewDidAppear.asObservable()
      .bind(onNext: { [weak self] _ in
        if
          let addressInfo = self?.reactor?.currentState.addressInfo,
          let time = self?.reactor?.currentState.reservationTime,
          let firstPosition = self?.firstPosition,
          let arrivalPosition = self?.arrivalPosition,
          !(self?.isOpenedRoute ?? true)
        {
          let viewController = ReservationModalViewController(time: time, addressInfo: addressInfo)
          viewController.modalPresentationStyle = .custom
          viewController.completionHandler = { [weak self] in
            self?.reactor?.action.on(.next(Reactor.Action.readyForFindRoute(.init(firstPosition.lat, firstPosition.lng), .init(arrivalPosition.lat, arrivalPosition.lng))))
          }
          self?.present(viewController, animated: true, completion: nil)
          self?.isOpenedRoute = true
        }
      })
      .disposed(by: self.disposeBag)
    
    self.rx.viewDidAppear.asObservable()
      .bind(onNext: { [weak self] _ in
        if reactor.currentState.isReadyForCall,
           !(self?.isOpenedCall ?? true)
        {
          self?.arrivalMaker.mapView = nil
          self?.departureMaker.mapView = nil
          self?.polylines.forEach { $0.mapView = nil }
          
          let currentMarker: NMFOverlayImage = .init(image: UIImage(named: "image_me")!)
          self?.marker.iconImage = currentMarker
          
          if let gillbertPosition = self?.gillbertPosition,
             let firstPosition = self?.firstPosition {
            
            self?.gillbertMaker.position = gillbertPosition
            self?.gillbertMaker.mapView = self?.naverMapView.mapView
            
            self?.naverMapView.mapView.moveCamera(.init(fit: .init(southWest: firstPosition, northEast: gillbertPosition)))
          }
          
          let viewController = CallModalViewController()
          viewController.modalPresentationStyle = .custom

          viewController.completionHandler = { [weak self] in
            
            
          }

          self?.present(viewController, animated: true, completion: nil)
          self?.isOpenedCall = true
        }
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
    
    reactor.state.map { $0.addressInfo }
      .asObservable()
      .distinctUntilChanged()
      .bind(onNext: { [weak self] addressInfo in
        if
          let addressInfo = addressInfo,
          let lat = Double(addressInfo.y ?? ""),
          let lng = Double(addressInfo.x ?? "")
        {
          let position: NMGLatLng = .init(lat: lat, lng: lng)
          self?.arrivalPosition = position
          self?.searchButton.isHidden = true
          self?.naverMapView.mapView.moveCamera(.init(scrollTo: position))
          self?.arrivalMaker.position = position
          self?.arrivalMaker.mapView = self?.naverMapView.mapView
        }
      })
      .disposed(by: self.disposeBag)
    
    
    reactor.state.map { $0.driving }
      .filter { $0 != nil }
      .take(1)
      .asObservable()
      .bind(onNext: { [weak self] driving in
        guard
          let self = self,
          let driving = driving,
          let firstPosition = self.firstPosition,
          let arrivalPosition = self.arrivalPosition
        else {
          return
        }
        
        for t in driving.route.trafast {
          var positions: [NMGLatLng] = .init()
          for b in t.path {
            positions.append(.init(lat: b.last ?? 0, lng: b.first ?? 0))
          }
          if let polyline = NMFPolylineOverlay(positions) {
            polyline.joinType = .round
            polyline.capType = .round
            polyline.mapView = self.naverMapView.mapView
            
            self.polylines.append(polyline)
          }
        }
        
        self.naverMapView.mapView.moveCamera(.init(fit: .init(southWest: firstPosition, northEast: arrivalPosition)))
        
        self.departureMaker.position = firstPosition
        self.departureMaker.mapView = self.naverMapView.mapView
        
        let viewController = RouteModalViewController()
        viewController.modalPresentationStyle = .custom
        
        viewController.completionHandler = { [weak self] in
          self?.reactor?.action.on(.next(Reactor.Action.readyForGillbert))
        }
        
        self.present(viewController, animated: true, completion: nil)
      })
      .disposed(by: self.disposeBag)
    
    reactor.state.map { $0.isReadyForGillbert }
      .filter{ $0 }
      .take(1)
      .distinctUntilChanged()
      .asObservable()
      .bind(onNext: { [weak self] isReadyForGillbert in
        guard let self = self else { return }
        if isReadyForGillbert {
          let viewModel = GilbertListViewModel(
            provider: ServiceProvider(),
            gilbertInfoPublishRelay: PublishRelay<Gilbert>()
          )
          let gilbertListViewController = GilbertListViewController(viewModel: viewModel)
          gilbertListViewController.hidesBottomBarWhenPushed = true
          
          viewModel.gilbertInfoPublishRelay.asObservable()
            .subscribe(onNext: { [weak self] gilbert in
              self?.gilbert = gilbert
              self?.reactor?.action.on(.next(Reactor.Action.readyForCall))
            })
            .disposed(by: self.disposeBag)
          
          self.navigationController?.pushViewController(gilbertListViewController, animated: true)
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
        
        self.gillbertPosition = NMGLatLng.init(lat: location.coordinate.latitude + 0.00001, lng: location.coordinate.longitude + 0.00002)
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
