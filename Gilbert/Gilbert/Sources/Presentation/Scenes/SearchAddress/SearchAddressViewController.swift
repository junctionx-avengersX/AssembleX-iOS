//
//  SearchAddressViewController.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

class SearchAddressViewController: BaseViewController {
  
  private let startAddressTextField = UITextField().then {
    
    $0.backgroundColor = UIColor(rgb: "#f9f9f9")
    $0.layer.cornerRadius = 5
  }
  
  private let destinationAddressTextField = UITextField().then {
    $0.layer.cornerRadius = 5
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor(rgb: "#32d74b").cgColor
  }
  
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
  
  private let viewModel: SearchAddressViewModel
  
  // MARK: - Con(De)structor
  
  init(viewModel: SearchAddressViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    startAddressTextField.snp.makeConstraints {
      $0.top.equalToSuperview().offset(40)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
      $0.height.equalTo(48)
    }
    
    destinationAddressTextField.snp.makeConstraints {
      $0.top.equalTo(startAddressTextField.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
      $0.height.equalTo(48)
    }
    
    collectionView.snp.makeConstraints {
      $0.top.equalTo(destinationAddressTextField.snp.bottom).offset(10)
      $0.bottom.leading.trailing.equalToSuperview()
    }
  }
  
  private func bindViewModel() {
    
  }
}

// MARK: - SetupUI
extension SearchAddressViewController {
  private func setupUI() {
    view.backgroundColor = .white
    view.addSubviews(
      startAddressTextField,
      destinationAddressTextField,
      collectionView
    )
  }
}


