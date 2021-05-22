//
//  GilbertListSectionModel.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//


import RxSwift
import RxDataSources

struct GilbertListSectionModel:
  Equatable,
  AnimatableSectionModelType
{
  static func == (
    lhs: GilbertListSectionModel,
    rhs: GilbertListSectionModel
  ) -> Bool {
    lhs.identity == rhs.identity
  }
  
  var identity: String { "GilbertListSection" }
  var items: [Gilbert]
  
  init(
    items: [Gilbert]
  ) {
    self.items = items
  }
  
  init(
    original: GilbertListSectionModel,
    items: [Gilbert]
  ) {
    self = original
    self.items = items
  }
}
