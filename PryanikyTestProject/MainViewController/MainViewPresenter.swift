//
//  MainViewPresenter.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

class MainViewPresenter {
    
    // MARK: - Private Properties
    weak private var mainViewDelegate: MainViewDelegate?
    
    // MARK: - Public methods
    func setViewDelegate(_ viewDelegate: MainViewDelegate) {
        mainViewDelegate = viewDelegate
    }
}
