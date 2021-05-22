//
//  GilbertListAPI.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import Foundation

import Moya

enum TransportationType: String {
  case bus = "[BUS]"
}

enum GilbertListAPI {
  case fetchGilbertList(base: String, destination: String, transportations: String)

}

extension GilbertListAPI: TargetType {
  var baseURL: URL {
    GlobalStore.gilbertBaseURL
  }
  
  var path: String {
    switch self {
    case .fetchGilbertList:
      return "gilberts"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .fetchGilbertList:
      return .get
    }
  }
  
  var sampleData: Data {
    Data()
  }
  
  var task: Task {
    switch self {
    case let .fetchGilbertList(
          base,
          destination,
          transportations
    ):
      return .requestParameters(
        parameters: [
          "base": base,
          "destination": destination,
          "transportations": transportations
        ],
        encoding: URLEncoding.default
      )
    }
  }
  
  var headers: [String : String]? {
    return [:]
  }
}
