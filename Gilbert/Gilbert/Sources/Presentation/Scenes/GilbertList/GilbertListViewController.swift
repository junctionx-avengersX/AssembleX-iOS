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
  
  private var popUpCardView: UIView?
  
  lazy var collectionView = UICollectionView(
    frame: CGRect.zero,
    collectionViewLayout: UICollectionViewFlowLayout().then({
      $0.scrollDirection = .vertical
    })
  ).then {
    $0.backgroundColor = UIColor(rgb: "#f4f5f7")
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
    
    output
      .receivedGilbertList
      .bind(to: collectionView.rx.items(dataSource: self.buildDataSource()))
      .disposed(by: disposeBag)
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
      cell.configure(gilbertInfo: cellData)
      cell.backgroundButtonTap
        .bind { [weak self] _ in
          self?.setupPopUpCardView(gilbertInfo: cellData)
      }
      .disposed(by: cell.cellDisposeBag)
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
  
  private func setupPopUpCardView(gilbertInfo: Gilbert) {
    guard popUpCardView == nil else { return }
    
    let backgroundView = UIView().then {
      $0.backgroundColor = UIColor(rgb: "#6b6b6b")
    }
    
    let cardView = GilbertDetailInfoCardView().then {
      $0.configure(gilbertInfo: gilbertInfo)
    }
    
    let dismissButton = UIButton().then {
      $0.setImage(UIImage(named: "dismiss_img")?.withTintColor(.white), for: .normal)
    }
    
    popUpCardView = backgroundView
    
    view.addSubview(backgroundView)
    
    backgroundView.addSubviews(
      cardView,
      dismissButton
    )
    
    backgroundView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    cardView.snp.makeConstraints {
      $0.width.equalTo(327)
      $0.height.equalTo(482)
      $0.center.equalToSuperview()
    }
    
    dismissButton.snp.makeConstraints {
      $0.width.height.equalTo(24)
      $0.bottom.equalTo(cardView.snp.top).offset(-10)
      $0.trailing.equalTo(cardView)
    }
    
    dismissButton.rx.tap
      .bind { [weak self] _ in
        self?.popUpCardView?.removeFromSuperview()
        self?.popUpCardView = nil
      }
      .disposed(by: disposeBag)
    
    // TODO:
    cardView.bottomAccompanyButtonTap.bind { [weak self] _ in
      self?.viewModel.gilbertInfoPublishRelay.accept(gilbertInfo)
      self?.popUpCardView?.removeFromSuperview()
      self?.popUpCardView = nil
      // self?.dismiss(animated: true, completion: nil)
    }
    .disposed(by: disposeBag)
  }
}

// MARK: - SetupUI
extension GilbertListViewController {
  private func setupUI() {
    view.addSubview(collectionView)
    collectionView.rx.setDelegate(self)
      .disposed(by: disposeBag)
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
