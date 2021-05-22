//
//  AddressDetailInfo.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import RxDataSources

struct AddressDetailInfo:
  Decodable,
  Equatable,
  IdentifiableType
{
  static func == (
    lhs: AddressDetailInfo,
    rhs: AddressDetailInfo
  ) -> Bool {
    lhs.identity == rhs.identity
  }
  
  var identity: String { id }
  
  let type: String?
  let id: String
  let title: String?
  let x: Double?
  let y: Double?
  let dist: Double?
  let totalScore: Double?
  let sid: String?
  let ctg: String?
  let cid: String?
  let jibunAddress: String?
  let roadAddress: String?
}

/*
 {
 "type": "place",
 "id": "11686884",
 "title": "서울아산병원",
 "x": "127.1079349",
 "y": "37.5265762",
 "dist": 0.00024022096790207243,
 "totalScore": 372.0712,
 "sid": "11686884",
 "ctg": "종합병원",
 "cid": "223212",
 "jibunAddress": "서울특별시 송파구 풍납2동 388-1",
 "roadAddress": "서울특별시 송파구 올림픽로43길 88 서울아산병원"
 }
 */
