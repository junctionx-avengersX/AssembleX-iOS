//
//  HomeMapViewController.swift
//  Gilbert
//
//  Created by 황재욱 on 2021/05/22.
//

import UIKit

class HomeMapViewController: UIViewController {
  
  // MARK: - Properties
  
  private let viewModel: HomeMapViewModel
  
  // MARK: - Con(De)structor
  
  init(viewModel: HomeMapViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .blue
  }
}
