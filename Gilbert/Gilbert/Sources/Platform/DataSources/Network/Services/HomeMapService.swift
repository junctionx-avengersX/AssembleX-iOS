//
//  HomeMapService.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import Foundation

import Moya

enum HomeMapService {
  case reservation
}

extension HomeMapService: TargetType {
  var baseURL: URL {
    URL(string: "")!
  }
  
  var path: String {
    switch self {
    case .reservation:
      return ""
    }
  }
  
  var method: Moya.Method {
    return .post
  }
  
  var sampleData: Data {
    Data()
  }
  
  var task: Task {
    switch self {
    case .reservation:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    return [:]
  }
}
