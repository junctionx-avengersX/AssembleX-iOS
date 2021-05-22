//
//  UICollectionView+Extension.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import Foundation

import UIKit

extension UICollectionView {
  
  // MARK: - UICollectionReusableViewType
  
  enum UICollectionReusableViewType {
    case header
    case footer
  }
  
  // MARK: - Internal methods
  
  final func register<View: UICollectionReusableView>(
    viewType: View.Type,
    positionType: UICollectionReusableViewType
  ) {
    switch positionType {
    case .header:
      return register(
        View.self,
        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
        withReuseIdentifier: String(describing: viewType)
      )
    case .footer:
      return register(
        View.self,
        forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
        withReuseIdentifier: String(describing: viewType)
      )
    }
  }
  
  final func register<Cell: UICollectionViewCell>(cellType: Cell.Type) {
    register(
      cellType.self,
      forCellWithReuseIdentifier: String(describing: cellType)
    )
  }
  
  final func dequeueReusableCell<Cell: UICollectionViewCell>(
    indexPath: IndexPath,
    cell: Cell.Type
  ) -> Cell? {
    return dequeueReusableCell(
      withReuseIdentifier: String(describing: cell),
      for: indexPath
    ) as? Cell
  }
  
  final func dequeueReusableView<View: UICollectionReusableView>(
    view: View.Type,
    kind: String,
    indexPath: IndexPath
  ) -> View? {
    dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: String(describing: view),
      for: indexPath
    ) as? View
  }
}
