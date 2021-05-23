//
//  CallModalViewController.swift
//  Gilbert
//
//  Created by Tom on 2021/05/23.
//

import UIKit

class CallModalViewController: BaseViewController {
  
  lazy var backdropView: UIView = {
    let bdView = UIView(frame: self.view.bounds)
    bdView.backgroundColor = .clear
    return bdView
  }()
  
  let menuView = UIView()
  let roundView = UIView().then {
    $0.layer.cornerRadius = 8
    $0.backgroundColor = .white
  }
  let menuHeight: CGFloat = 250.0
  var isPresenting = false
  
  let subTitleLabel: UILabel = UILabel().then {
    $0.text = "Calling Buddy within 5 minutes…"
    $0.font = .systemFont(ofSize: 12, weight: .regular)
    $0.textColor = .init(hex: "#999999")
  }
  
  let titleLabel: UILabel = UILabel().then {
    $0.text = "Ari is expected to arrive in 3 minutes."
    $0.font = .systemFont(ofSize: 18, weight: .bold)
    $0.textColor = .black
  }
  
  let startLabel: UILabel = UILabel().then {
    $0.text = "Ori homeplus"
    $0.font = .systemFont(ofSize: 14, weight: .regular)
    $0.textColor = .black
  }
  
  let endLabel: UILabel = UILabel().then {
    $0.text = "Bundang SNUniv. Hospital"
    $0.font = .systemFont(ofSize: 14, weight: .regular)
    $0.textColor = .black
  }
  
  let findButton: UIButton = UIButton().then {
    $0.layer.cornerRadius = 4
    $0.backgroundColor = .init(hex: "#f5f6f7")
    $0.setTitle("Cancle call buddy", for: .normal)
    $0.setTitleColor(.black, for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
  }
  
  let imageView: UIImageView = UIImageView().then {
    $0.image = UIImage(named: "image_flow")
  }
  
  var completionHandler: (() -> Void)?
  
  override init() {
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
    
    self.menuView.addSubview(self.subTitleLabel)
    self.menuView.addSubview(self.titleLabel)
    
    self.menuView.addSubview(self.startLabel)
    self.menuView.addSubview(self.endLabel)
    self.menuView.addSubview(self.imageView)
    self.menuView.addSubview(self.findButton)
    
    menuView.backgroundColor = .white
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CallModalViewController.handleTap(_:)))
    backdropView.addGestureRecognizer(tapGesture)
    
    bind()
  }
  
  fileprivate func bind() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.dismiss(animated: true) {
        self.completionHandler?()
      }
    }
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
    
    self.subTitleLabel.snp.makeConstraints {
      $0.left.equalToSuperview().offset(24)
      $0.right.equalToSuperview().offset(-24)
      $0.top.equalToSuperview().offset(16)
    }
    
    self.titleLabel.snp.makeConstraints {
      $0.top.equalTo(self.subTitleLabel.snp.bottom).offset(16)
      $0.left.equalToSuperview().offset(24)
      $0.right.equalToSuperview().offset(-24)
    }
    
    self.imageView.snp.makeConstraints {
      $0.top.equalTo(self.titleLabel.snp.bottom).offset(24)
      $0.left.equalToSuperview().offset(24)
    }
    
    self.startLabel.snp.makeConstraints {
      $0.top.equalTo(self.imageView)
      $0.left.equalTo(self.imageView.snp.right)
    }
    
    self.endLabel.snp.makeConstraints {
      $0.bottom.equalTo(self.imageView)
      $0.left.equalTo(self.imageView.snp.right)
    }
    
    self.findButton.snp.makeConstraints {
      $0.left.equalToSuperview().offset(24)
      $0.right.equalToSuperview().offset(-24)
      $0.height.equalTo(48)
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-16)
    }
  }
  
  @objc func handleTap(_ sender: UITapGestureRecognizer) {
    dismiss(animated: true, completion: nil)
  }
}

extension CallModalViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
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

