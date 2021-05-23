//
//  MatchingResultViewController.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

class MatchingResultViewController: BaseViewController {
  
  var viewModel: MatchingResultViewModel
  
  var gilbert: Gilbert?
  
  // MARK: - Con(De)structor
  
  init(viewModel: MatchingResultViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  convenience init(gilbert: Gilbert, viewModel: MatchingResultViewModel) {
    self.init(viewModel: viewModel)
    self.gilbert = gilbert
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private var popUpCardView: UIView?
  
  private let titleLabel = UILabel().then {
    $0.numberOfLines = 0
    $0.textAlignment = .center
    $0.font = .font(weight: .bold, size: 16)
    $0.text = "동행 완료!\n\n길벗과의 동행이 편안하셨나요?"
  }
  
  private let imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.image = UIImage(named: "temp")
  }
  
  private let grayBottomFeeLabel = UIButton().then {
    $0.backgroundColor = UIColor(rgb: "#f4f5f7")
    $0.setImage(UIImage(named: "coin_stack"), for: .normal)
    $0.semanticContentAttribute = .forceLeftToRight
    $0.titleLabel?.font = .font(weight: .regular, size: 10)
  }
  
  private let bottomSendButton = UIButton().then {
    $0.setTitle("Send", for: .normal)
    $0.titleLabel?.font = .font(weight: .bold, size: 14)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = UIColor(rgb: "#32d74b")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindUI()
  }
}

// MARK: - SetupUI
extension MatchingResultViewController {
  private func setupUI() {
    view.backgroundColor = .white
    view.addSubviews(
      titleLabel,
      imageView,
      grayBottomFeeLabel,
      bottomSendButton
    )
    layout()
  }
  
  private func layout() {
    titleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(60)
    }
    
    imageView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(40)
      $0.height.equalTo(320)
      $0.leading.equalToSuperview().offset(40)
      $0.trailing.equalToSuperview().offset(-40)
    }
    
    bottomSendButton.snp.makeConstraints {
      $0.bottom.equalToSuperview().offset(-20)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
      $0.height.equalTo(48)
    }
    
    grayBottomFeeLabel.snp.makeConstraints {
      $0.bottom.equalTo(bottomSendButton.snp.top).offset(-13)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
      $0.height.equalTo(32)
    }
  }
  
  private func bindUI() {
    let gilbert = Gilbert(id: "", name: "Ari Mande", profileUrl: "", rating: 4, delay: 4.5, cost: 2000, introduction: "", guideCount: 4)
    
    bottomSendButton.rx.tap.bind { [weak self] _ in
      
      if let gilbertInfo = self?.gilbert {
        self?.setupPopUpCardView(gilbertInfo: gilbertInfo)
      }
    }
    .disposed(by: disposeBag)
  }
  
  private func setupPopUpCardView(gilbertInfo: Gilbert) {
    guard popUpCardView == nil else { return }
    
    let backgroundView = UIView().then {
      $0.backgroundColor = UIColor(rgb: "#6b6b6b")
    }
    
    let cardView = ResultCardView().then {
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
  }
}
