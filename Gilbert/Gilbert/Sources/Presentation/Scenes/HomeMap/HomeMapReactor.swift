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
  }
  
  enum Mutation {
    case setReservationTime(Date?)
  }
  
  struct State {
    var reservationTime: Date?
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
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case let.setReservationTime(time):
      state.reservationTime = time
    }
    return state
  }
}
