//
//  SearchAddressViewController.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources

class SearchAddressViewController: BaseViewController {
  
  private let startAddressTextField = UITextField().then {
    $0.isUserInteractionEnabled = false
    $0.backgroundColor = UIColor(rgb: "#f9f9f9")
    $0.layer.cornerRadius = 5
    $0.clearButtonMode = .always
  }
  
  private let destinationAddressTextField = LeftImageTextField().then {
    $0.layer.cornerRadius = 5
    $0.layer.borderWidth = 2
    $0.layer.borderColor = UIColor(rgb: "#f9f9f9").cgColor
    $0.clearButtonMode = .always
    $0.leftViewMode = .always
    let leftView: UIView = .init(frame: .init(x: 0, y: 0, width: 42, height: 48))
    let imageView = UIImageView(image: UIImage(named: "green_oval")).then({
      $0.frame = CGRect(x: 20, y: 22, width: 4, height: 4)
    })
    leftView.addSubview(imageView)
    $0.leftView = leftView
  }
  
  private let backbuttonImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.image = UIImage(named: "back_button_img")
  }
  
  private let currentLocationLabel = UILabel().then {
    $0.font = .font(weight: .regular, size: 16)
    $0.textColor = UIColor(rgb: "#030303")
    $0.text = "Current Location"
  }
  
  private let defaultImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.image = UIImage(named: "temp5")
  }
  
  lazy var collectionView = UICollectionView(
    frame: CGRect.zero,
    collectionViewLayout: UICollectionViewFlowLayout().then({
      $0.scrollDirection = .vertical
    })
  ).then {
    $0.backgroundColor = .white
    $0.showsVerticalScrollIndicator = false
    $0.register(cellType: AddressInfoCell.self)
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
    bindUI()
    bindViewModel()
    hideKeyboardWhenTappedAround(cancelsTouchesInView: true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  private func buildDataSource() -> RxCollectionViewSectionedAnimatedDataSource<SearchAddressSectionModel> {
    return RxCollectionViewSectionedAnimatedDataSource<SearchAddressSectionModel> { _, collectionView, indexPath, cellData -> UICollectionViewCell in
      guard let
              cell = collectionView.dequeueReusableCell(
                indexPath: indexPath,
                cell: AddressInfoCell.self
              ) else {
        return UICollectionViewCell()
      }
      cell.backgroundButtonTap
        .bind { [weak self] _ in
          self?.viewModel.selectedAddressPublishRelay.accept(cellData)
          self?.navigationController?.popViewController(animated: true)
      }
      .disposed(by: cell.cellDisposeBag)
      cell.configure(addressInfo: cellData)
      return cell
    } configureSupplementaryView: { sectionModel, collectionView, kind, indexPath -> UICollectionReusableView in
      return UICollectionReusableView()
    }
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
    
    backbuttonImageView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(10)
      $0.width.height.equalTo(24)
      $0.centerY.equalToSuperview()
    }
    
    currentLocationLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(backbuttonImageView.snp.trailing)
        .offset(10)
    }
    
    /*defaultImageView.snp.makeConstraints {
      $0.leading.equalTo(destinationAddressTextField)
      $0.top.equalTo(destinationAddressTextField.snp.bottom).offset(20)
      $0.width.equalTo(130)
      $0.height.equalTo(16)
    }*/
  }
  
  private func bindViewModel() {
    let destinationText = destinationAddressTextField.rx.text
      .distinctUntilChanged()
      .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
      .asObservable()
    
    let input = type(of: self.viewModel).Input(destinationTextFieldQuery: destinationText)
    
    let output = viewModel.transform(input: input)
    
    output.placesInfoReceived
      .bind(to: collectionView.rx.items(dataSource: self.buildDataSource()))
      .disposed(by: disposeBag)
  }
  
  private func bindUI() {
    collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    
    destinationAddressTextField.rx
      .controlEvent(UIControl.Event.editingDidBegin)
      .bind { [weak self] _ in
        self?.destinationAddressTextField.layer.borderColor
          = UIColor(rgb: "#32d74b").cgColor
      }.disposed(by: disposeBag)
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
    
    startAddressTextField.addSubviews(
      backbuttonImageView,
      currentLocationLabel
    )
  }
}

extension SearchAddressViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width, height: 58)
  }
}
