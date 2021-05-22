//
//  SearchAddressSectionModel.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import RxSwift
import RxDataSources

struct SearchAddressSectionModel:
  Equatable,
  AnimatableSectionModelType
{
  static func == (
    lhs: SearchAddressSectionModel,
    rhs: SearchAddressSectionModel
  ) -> Bool {
    lhs.identity == rhs.identity
  }
  
  var identity: String { "SearchAddressSection" }
  var items: [AddressDetailInfo]
  
  init(
    items: [AddressDetailInfo]
  ) {
    self.items = items
  }
  
  init(
    original: SearchAddressSectionModel,
    items: [AddressDetailInfo]
  ) {
    self = original
    self.items = items
  }
}
