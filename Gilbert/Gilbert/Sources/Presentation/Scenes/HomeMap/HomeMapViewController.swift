//
//  HomeMapViewController.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit
import NMapsMap

class HomeMapViewController: BaseViewController {
  
  let naverMapView = NMFNaverMapView()
          
  
  // MARK: - Properties
  
  private let viewModel: HomeMapViewModel
  
  // MARK: - Con(De)structor
  
  init(viewModel: HomeMapViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .blue
    
    view.addSubview(naverMapView)
  }
  
  override func setupConstraints() {
    naverMapView.snp.makeConstraints {
      $0.bottom.left.right.top.equalTo(self.view)
    }
  }
}
