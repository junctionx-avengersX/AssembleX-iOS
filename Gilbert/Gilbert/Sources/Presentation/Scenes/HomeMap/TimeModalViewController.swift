//
//  TimeModalViewController.swift
//  Gilbert
//
//  Created by Tom on 2021/05/22.
//

import UIKit

class TimeModalViewController: BaseViewController {
  
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
  let menuHeight = UIScreen.main.bounds.height / 2
  
  let titleLabel: UILabel = UILabel().then {
    $0.font = .systemFont(ofSize: 16, weight: .semibold)
    $0.textColor = .black
    $0.text = "이용시간 설정하기"
  }
  
  let checkButton: UIButton = UIButton().then {
    $0.setTitle("현재 시각으로 설정", for: .normal)
    $0.setTitleColor(.black, for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
    $0.setImage(UIImage(named: "icon_check_off"), for: .normal)
    $0.setImage(UIImage(named: "icon_check_on"), for: .selected)
    $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    $0.contentHorizontalAlignment = .left
  }
  
  let stateLabel: UILabel = UILabel().then {
    $0.font = .systemFont(ofSize: 14, weight: .bold)
    $0.textColor = .black
    $0.text = "Today 14:00"
  }
  
  let cancelButton: UIButton = UIButton().then {
    $0.backgroundColor = .init(hex: "#e8ecf2")
    $0.layer.cornerRadius = 4
    $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    $0.setTitle("Cancel", for: .normal)
    $0.setTitleColor(.init(hex: "#6f6f6f"), for: .normal)
  }
  
  let setupButton: UIButton = UIButton().then {
    $0.backgroundColor = .init(hex: "#32d74b")
    $0.layer.cornerRadius = 4
    $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    $0.setTitle("Set up", for: .normal)
    $0.setTitleColor(.white, for: .normal)
  }
  
  let datepicker: UIDatePicker = UIDatePicker().then {
    $0.datePickerMode = .dateAndTime
    $0.preferredDatePickerStyle = .wheels
  }
  
  var currentDate: Date?
  
  var isPresenting = false
  
  var completionHandler: ((Date?)->Void)?
  
  init(with date: Date?) {
    super.init()
    self.currentDate = date
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
    
    self.menuView.addSubview(self.cancelButton)
    self.menuView.addSubview(self.setupButton)
    
    self.menuView.addSubview(self.titleLabel)
    self.menuView.addSubview(self.stateLabel)
    self.menuView.addSubview(self.checkButton)
    
    self.menuView.addSubview(self.datepicker)
    
    menuView.backgroundColor = .white
    
    if let currentDate = self.currentDate {
      self.datepicker.setDate(currentDate, animated: false)
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "h:mm"
      let dateString = dateFormatter.string(from: currentDate)
      self.stateLabel.text = "Today \(dateString)"
    }else{
      self.checkButton.isSelected = true
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "h:mm"
      let dateString = dateFormatter.string(from: Date())
      self.stateLabel.text = "Today \(dateString)"
    }
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TimeModalViewController.handleTap(_:)))
    backdropView.addGestureRecognizer(tapGesture)
    
    self.bind()
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
    
    self.cancelButton.snp.makeConstraints {
      $0.left.equalToSuperview().offset(24)
      $0.height.equalTo(48)
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-16)
    }
    
    self.setupButton.snp.makeConstraints {
      $0.left.equalTo(self.cancelButton.snp.right).offset(16)
      $0.right.equalToSuperview().offset(-24)
      $0.height.equalTo(48)
      $0.width.equalTo(self.cancelButton)
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-16)
    }
    
    self.titleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(16)
    }
    
    self.checkButton.snp.makeConstraints {
      $0.left.equalToSuperview().offset(24)
      $0.top.equalToSuperview().offset(50)
      $0.right.equalTo(self.stateLabel.snp.left).offset(-24)
      $0.height.equalTo(40)
    }
    
    self.stateLabel.snp.makeConstraints {
      $0.centerY.equalTo(self.checkButton)
      $0.right.equalToSuperview().offset(-24)
    }
    
    self.datepicker.snp.makeConstraints {
      $0.left.right.equalToSuperview()
      $0.top.equalTo(self.checkButton.snp.bottom).offset(8)
      $0.bottom.equalTo(self.cancelButton.snp.top).offset(-16)
    }
  }
  
  @objc func handleTap(_ sender: UITapGestureRecognizer) {
    dismiss(animated: true, completion: nil)
  }
  
  fileprivate func bind() {
    self.checkButton.rx.tap.asObservable()
      .bind(onNext: { [weak self] in
        self?.checkButton.isSelected.toggle()
        if self?.checkButton.isSelected ?? false {
          self?.datepicker.setDate(Date(), animated: true)
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "h:mm"
          let dateString = dateFormatter.string(from: Date())
          self?.stateLabel.text = "Today \(dateString)"
        }
      })
      .disposed(by: self.disposeBag)
    
    self.datepicker.rx.value.asObservable()
      .bind(onNext: { [weak self] date in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm"
        let dateString = dateFormatter.string(from: date)
        self?.stateLabel.text = "Today \(dateString)"
        self?.checkButton.isSelected = false
      })
      .disposed(by: self.disposeBag)

    
    self.setupButton.rx.tap.asObservable()
      .bind(onNext: { [weak self] in
        self?.dismiss(animated: true, completion: {
          let date = self?.datepicker.date
          self?.completionHandler?(date)
        })
      })
      .disposed(by: self.disposeBag)
    
    self.cancelButton.rx.tap.asObservable()
      .bind(onNext: { [weak self] in
        self?.dismiss(animated: true, completion: {
          
        })
      })
      .disposed(by: self.disposeBag)
  }
  
}

extension TimeModalViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
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

