//
//  MainViewController.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    private var mainViewPresenter: MainViewPresenter
    
    // MARK: - Initializers
    init(mainViewPresenter: MainViewPresenter = MainViewPresenter()) {
        self.mainViewPresenter = mainViewPresenter
        super.init(nibName: nil, bundle: nil)
        mainViewPresenter.setViewDelegate(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewPresenter.getData()
    }
}

// MARK: - MainViewDelegate
extension MainViewController: MainViewDelegate {
    
}
