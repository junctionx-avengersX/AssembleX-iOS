//
//  RouteModalViewController.swift
//  Gilbert
//
//  Created by Tom on 2021/05/23.
//

import UIKit

class RouteModalViewController: BaseViewController {
  
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
  let menuHeight: CGFloat = 270
  var isPresenting = false
  
  let stackView: UIStackView = UIStackView().then {
    $0.axis = .vertical
    $0.distribution = .fillEqually
  }
  
  var completionHandler: (()->Void)?
  
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
    
    self.menuView.addSubview(self.stackView)
    let button1 = TransportationView(image: .init(named: "image_bus"), name: "Public transport", subName: "inconvenient to use public transportation", isShowBest: true)
    
    let button2 = TransportationView(image: .init(named: "image_car"), name: "Gillbert Car", subName: "When you need fast and safe travel")
      
    let button3 = TransportationView(image: .init(named: "image_walking"), name: "By walking", subName: "When you need company")
    
    self.stackView.addArrangedSubview(button1)
    self.stackView.addArrangedSubview(button2)
    self.stackView.addArrangedSubview(button3)
    
    menuView.backgroundColor = .white
    
    self.menuView.snp.makeConstraints {
      $0.left.right.bottom.equalToSuperview()
      $0.height.equalTo(self.menuHeight)
    }
    
    self.roundView.snp.makeConstraints {
      $0.left.right.equalToSuperview()
      $0.centerY.equalTo(self.menuView.snp.top)
      $0.height.equalTo(16)
    }
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RouteModalViewController.handleTap(_:)))
    backdropView.addGestureRecognizer(tapGesture)
    
    button1.rx.tap.asObservable()
      .bind(onNext: {
        self.dismiss(animated: true) {
          self.completionHandler?()
        }
      })
      .disposed(by: self.disposeBag)
  }
  
  @objc func handleTap(_ sender: UITapGestureRecognizer) {
    dismiss(animated: true, completion: nil)
  }
  
  override func setupConstraints() {
    self.stackView.snp.makeConstraints {
      $0.left.top.equalToSuperview().offset(24)
      $0.right.bottom.equalToSuperview().offset(-24)
    }
  }
}

extension RouteModalViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
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

