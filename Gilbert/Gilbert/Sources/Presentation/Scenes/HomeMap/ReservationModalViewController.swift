//
//  ReservationModalViewController.swift
//  Gilbert
//
//  Created by Tom on 2021/05/23.
//

import UIKit

class ReservationModalViewController: BaseViewController {
  
  lazy var backdropView: UIView = {
    let bdView = UIView(frame: self.view.bounds)
    bdView.backgroundColor = .clear
    return bdView
  }()
  
  let pinImageView: UIImageView = UIImageView().then {
    $0.image = UIImage.init(named: "icon_pin")
  }
  
  let titleLabel: UILabel = UILabel().then {
    $0.font = .systemFont(ofSize: 16, weight: .bold)
    $0.textColor = .black
  }
  
  let subTitleLabel: UILabel = UILabel().then {
    $0.font = .systemFont(ofSize: 12, weight: .regular)
    $0.textColor = .init(hex: "#999999")
  }
  
  let timeButton: UIButton = UIButton().then {
    $0.backgroundColor = .white
    $0.layer.cornerRadius = 4
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.init(hex: "#e8ecf2").cgColor
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowOpacity = 0.09
    $0.layer.shadowRadius = 8.0
    
    $0.titleLabel?.font = .systemFont(ofSize: 16)
    $0.setTitle("Times setup", for: .normal)
    $0.setTitleColor(.black, for: .normal)
    $0.setImage(UIImage(named: "icon_timer"), for: .normal)
    $0.tintColor = .init(hex: "#32d74b")
    $0.contentHorizontalAlignment = .leading
    $0.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
    $0.titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 0)
  }
  
  let findButton: UIButton = UIButton().then {
    $0.layer.cornerRadius = 4
    $0.backgroundColor = .init(hex: "#32d74b")
    $0.setTitle("Set up arrival", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
  }
  
  let menuView = UIView()
  let roundView = UIView().then {
    $0.layer.cornerRadius = 8
    $0.backgroundColor = .white
  }
  let menuHeight: CGFloat = 250.0
  var isPresenting = false
  
  let time: Date
  let addressInfo: AddressDetailInfo
  
  var completionHandler: (() -> Void)?
  
  init(time: Date, addressInfo: AddressDetailInfo) {
    self.time = time
    self.addressInfo = addressInfo
    super.init()
    modalPresentationStyle = .custom
    transitioningDelegate = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .clear
    view.addSubview(backdropView)
    view.addSubview(self.roundView)
    view.addSubview(menuView)
    
    let dateFormatter: DateFormatter = .init()
    dateFormatter.dateFormat = "(EEE) hh:mm"
    let dateString = dateFormatter.string(from: time)
    self.timeButton.layer.borderColor = UIColor.init(hex: "#32d74b").cgColor
    self.timeButton.setTitle("Today \(dateString)", for: .normal)
    
    self.titleLabel.text = "\(addressInfo.title ?? ""), \(addressInfo.ctg ?? "")"
    self.subTitleLabel.text = addressInfo.roadAddress
    
    self.menuView.addSubview(self.pinImageView)
    self.menuView.addSubview(self.titleLabel)
    self.menuView.addSubview(self.subTitleLabel)
    self.menuView.addSubview(self.timeButton)
    self.menuView.addSubview(self.findButton)
    
    menuView.backgroundColor = .white
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ReservationModalViewController.handleTap(_:)))
    backdropView.addGestureRecognizer(tapGesture)
    
    bind()
  }
  
  fileprivate func bind() {
    self.findButton.rx.tap.asObservable()
      .bind(onNext: { [weak self] in
        self?.dismiss(animated: true, completion: {
          self?.completionHandler?()
        })
      })
      .disposed(by: self.disposeBag)
  }
  
  override func setupConstraints() {
    self.menuView.snp.makeConstraints {
      $0.left.right.bottom.equalToSuperview()
      $0.height.equalTo(self.menuHeight)
    }
    
    self.roundView.snp.makeConstraints {
      $0.left.right.equalToSuperview()
      $0.centerY.equalTo(self.menuView.snp.top)
      $0.height.equalTo(16)
    }
    
    self.titleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview().offset(14)
      $0.top.equalToSuperview().offset(16)
    }
    
    self.pinImageView.snp.makeConstraints {
      $0.centerY.equalTo(self.titleLabel)
      $0.right.equalTo(self.titleLabel.snp.left).offset(-4)
    }
    
    self.subTitleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(self.titleLabel.snp.bottom).offset(12)
    }
    
    self.timeButton.snp.makeConstraints {
      $0.left.equalToSuperview().offset(24)
      $0.right.equalToSuperview().offset(-24)
      $0.height.equalTo(48)
      $0.top.equalTo(self.subTitleLabel.snp.bottom).offset(24)
    }
    
    self.findButton.snp.makeConstraints {
      $0.left.equalToSuperview().offset(24)
      $0.right.equalToSuperview().offset(-24)
      $0.height.equalTo(48)
      $0.top.equalTo(self.timeButton.snp.bottom).offset(24)
    }
  }
  
  @objc func handleTap(_ sender: UITapGestureRecognizer) {
    dismiss(animated: true, completion: nil)
  }
}

extension ReservationModalViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 1
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView
    let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
    guard let toVC = toViewController else { return }
    isPresenting = !isPresenting
    
    if isPresenting == true {
      containerView.addSubview(toVC.view)
      
      menuView.frame.origin.y += menuHeight
      roundView.frame.origin.y += menuHeight
      backdropView.alpha = 0
      
      UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {
        self.menuView.frame.origin.y -= self.menuHeight
        self.roundView.frame.origin.y -= self.menuHeight
        self.backdropView.alpha = 1
      }, completion: { (finished) in
        transitionContext.completeTransition(true)
      })
    } else {
      UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {
        self.menuView.frame.origin.y += self.menuHeight
        self.roundView.frame.origin.y += self.menuHeight
        self.backdropView.alpha = 0
      }, completion: { (finished) in
        transitionContext.completeTransition(true)
      })
    }
  }
}

