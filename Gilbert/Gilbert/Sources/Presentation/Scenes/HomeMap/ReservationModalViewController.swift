//
//  ReservationModalViewController.swift
//  Gilbert
//
//  Created by Tom on 2021/05/23.
//

import UIKit

class ReservationModalViewController: UIViewController {
  
  lazy var backdropView: UIView = {
    let bdView = UIView(frame: self.view.bounds)
    bdView.backgroundColor = .clear
    return bdView
  }()
  
  let pinImageView: UIImageView = UIImageView().then {
    $0.image = .init(named: "icon_pin")
  }
  
  let menuView = UIView()
  let roundView = UIView().then {
    $0.layer.cornerRadius = 8
    $0.backgroundColor = .white
  }
  let menuHeight: CGFloat = 300.0
  var isPresenting = false
  
  init() {
    super.init(nibName: nil, bundle: nil)
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
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ReservationModalViewController.handleTap(_:)))
    backdropView.addGestureRecognizer(tapGesture)
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

