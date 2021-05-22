//
//  DrivingAPI.swift
//  Gilbert
//
//  Created by Tom on 2021/05/22.
//

import Foundation

import Moya

enum DrivingAPI {
  case pathNavigation(start: MapPosition, goal: MapPosition)

}

extension DrivingAPI: TargetType {
  var baseURL: URL {
    URL(string: "https://naveropenapi.apigw.ntruss.com/map-direction/v1")!
  }
  
  var path: String {
    switch self {
    case .pathNavigation:
      return "/driving"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .pathNavigation:
      return .get
    }
  }
  
  var sampleData: Data {
    Data()
  }
  
  var task: Task {
    switch self {
    case let .pathNavigation(start, goal):
      return .requestParameters(
        parameters: [
          "start": "\(start.latitude),\(start.longitude)",
          "goal": "\(goal.latitude),\(goal.longitude)"
        ],
        encoding: URLEncoding.default
      )
    }
  }
  
  var headers: [String : String]? {
    return [
      "X-NCP-APIGW-API-KEY-ID": "ti0i89hz24",
      "X-NCP-APIGW-API-KEY": "uyh3laKcnwrbMCbrStbKue3SvpYYMarVhqyrSaAN"
    ]
  }
}
