//
//  GilbertListViewController.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

import RxDataSources

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
  
  private func buildDataSource() -> RxCollectionViewSectionedAnimatedDataSource<GilbertListSectionModel> {
    return RxCollectionViewSectionedAnimatedDataSource<GilbertListSectionModel> { _, collectionView, indexPath, cellData -> UICollectionViewCell in
      guard let
            cell = collectionView.dequeueReusableCell(
              indexPath: indexPath,
              cell: GilbertInfoCell.self
            ) else {
        return UICollectionViewCell()
      }
      
      return cell
    } configureSupplementaryView: { sectionModel, collectionView, kind, indexPath -> UICollectionReusableView in
      switch kind {
      case UICollectionView.elementKindSectionHeader:
        guard let header = collectionView.dequeueReusableView(
          view: GilbertListHeaderView.self,
          kind: kind,
          indexPath: indexPath
        ) else {
          fatalError("Dequeing reusable view is failed")
        }
        
        return header
      default:
        return UICollectionReusableView()
      }
    }
  }
}

// MARK: - SetupUI
extension GilbertListViewController {
  private func setupUI() {
    view.addSubview(collectionView)
    collectionView.rx.setDelegate(self).disposed(by: disposeBag)
  }
}

extension GilbertListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width, height: 144)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    referenceSizeForHeaderInSection section: Int
  ) -> CGSize {
    return CGSize(
      width: UIScreen.main.bounds.width,
      height: 64
    )
  }
}
