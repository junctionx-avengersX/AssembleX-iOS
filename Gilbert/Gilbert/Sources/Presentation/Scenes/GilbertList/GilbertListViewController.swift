//
//  GilbertListViewController.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

class GilbertListViewController: BaseViewController {
  
  private let viewModel: GilbertListViewModel
  
  // MARK: - Con(De)structor
  
  init(viewModel: GilbertListViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
  
  override func setupConstraints() {
    super.setupConstraints()
    collectionView.snp.makeConstraints {
      $0.bottom.leading.trailing.top.equalToSuperview()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindViewModel()
  }
  
  private func bindViewModel() {
    let viewWillAppear = rx.viewWillAppear.asObservable().map { _ in }
    
    let input = type(of: self.viewModel).Input(initialTrigger: viewWillAppear)
    
    let output = viewModel.transform(input: input)
    
    output.receivedGilbertList.asDriver(onErrorJustReturn: [])
      .drive { list in
      print(list)
    } onCompleted: {
      
    } onDisposed: {
      
    }
  }
}

// MARK: - SetupUI
extension GilbertListViewController {
  private func setupUI() {
    view.addSubview(collectionView)
  }
}
