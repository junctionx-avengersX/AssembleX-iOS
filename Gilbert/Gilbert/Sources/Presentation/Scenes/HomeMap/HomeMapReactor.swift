//
//  HomeMapReactor.swift
//  Gilbert
//
//  Created by Tom on 2021/05/22.
//

import Foundation

import ReactorKit
import RxSwift

final class HomeMapReactor: Reactor {
  enum Action {
    case reservationTime(Date?)
    case findAddressInfo(AddressDetailInfo?)
    case readyForFindRoute(MapPosition, MapPosition)
    case readyForGillbert
  }
  
  enum Mutation {
    case setReservationTime(Date?)
    case setAddressInfo(AddressDetailInfo?)
    case setDriving(Driving)
    case setReadyForGillbert
  }
  
  struct State {
    var reservationTime: Date?
    var addressInfo: AddressDetailInfo?
    var driving: Driving?
    var isReadyForGillbert: Bool = false
  }
  
  let initialState: State
  let provider: ServiceProvider
  
  init(provider: ServiceProvider) {
    defer { _ = self.state }
    self.initialState = State()
    self.provider = provider
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .reservationTime(time):
      return .just(Mutation.setReservationTime(time))
    case let .findAddressInfo(addressInfo):
      return .just(Mutation.setAddressInfo(addressInfo))
    case let .readyForFindRoute(start, goal):
      return self.provider.drivingService.getDriving(start: start, goal: goal)
        .asObservable()
        .map { Mutation.setDriving($0) }
    case .readyForGillbert:
      return .just(Mutation.setReadyForGillbert)
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case let.setReservationTime(time):
      state.reservationTime = time
    case let .setAddressInfo(addressInfo):
      state.addressInfo = addressInfo
    case let .setDriving(driving):
      state.driving = driving
    case .setReadyForGillbert:
      state.isReadyForGillbert = true
    }
    return state
  }
}
