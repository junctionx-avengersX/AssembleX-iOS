//
//  SearchAddressViewController.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

class SearchAddressViewController: BaseViewController {
  
  private let startAddressTextField = UITextField()
  
  private let destinationAddressTextField = UITextField()
  
  lazy var collectionView = UICollectionView(
    frame: CGRect.zero,
    collectionViewLayout: UICollectionViewFlowLayout().then({
      $0.scrollDirection = .vertical
    })
  ).then {
    $0.backgroundColor = .white
    $0.showsVerticalScrollIndicator = false
    $0.register(cellType: GilbertInfoCell.self)
    $0.register(
      viewType: GilbertListHeaderView.self,
      positionType: .header
    )
  }
  
  private let viewModel: GilbertListViewModel
  
  // MARK: - Con(De)structor
  
  init(viewModel: GilbertListViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    collectionView.snp.makeConstraints {
      $0.bottom.leading.trailing.top.equalToSuperview()
    }
  }
  
  private func bindViewModel() {
    
  }
}
