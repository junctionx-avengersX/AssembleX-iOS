//
//  SearchAddressAPI.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import Foundation

import Moya

enum SearchAddressAPI {
  case searchAddress(query: String)
}

extension SearchAddressAPI: TargetType {
  var baseURL: URL {
    GlobalStore.gilbertBaseURL
  }
  
  var path: String {
    switch self {
    case let .searchAddress(query):
      if let queryPercent = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
        return "maps/search/\(queryPercent)"
      } else {
        return "maps/search/"
      }
      
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .searchAddress:
      return .get
    }
  }
  
  var sampleData: Data {
    Data()
  }
  
  var task: Task {
    switch self {
    case let .searchAddress(
        query
    ):
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    return [:]
  }
}
