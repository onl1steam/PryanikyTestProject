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
    private var networkService: NetworkServiceDelegate
    
    // MARK: - Initializers
    init(networkService: NetworkServiceDelegate = ServiceLayer.shared.networkService) {
        self.networkService = networkService
    }
    
    // MARK: - Public methods
    func setViewDelegate(_ viewDelegate: MainViewDelegate) {
        mainViewDelegate = viewDelegate
    }
    
    func getData() {
        networkService.makeRequst { response in
            print(response)
        }
    }
}
