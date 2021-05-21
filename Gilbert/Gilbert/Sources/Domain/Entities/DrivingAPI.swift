//
//  DrivingAPI.swift
//  Gilbert
//
//  Created by Tom on 2021/05/22.
//

import Foundation

import Moya

enum DrivingAPI {
  case pathNavigation

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
    case .pathNavigation:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    return [:]
  }
}
