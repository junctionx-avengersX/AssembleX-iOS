//
//  Gilbert.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import RxDataSources

struct Gilbert:
  Decodable,
  Equatable,
  IdentifiableType {
  
  static func == (
    lhs: Gilbert,
    rhs: Gilbert
  ) -> Bool {
    lhs.identity == rhs.identity
  }
  
  var identity: String { id }
  
  let id: String
  let name: String?
  let profileUrl: String?
  let rating: Int?
  let delay: Double?
  let cost: Int?
  let introduction: String?
  let guideCount: Int?
}
