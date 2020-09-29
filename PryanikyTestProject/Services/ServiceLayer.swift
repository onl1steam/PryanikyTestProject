//
//  ServiceLayer.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

final class ServiceLayer {
    
    // MARK: - Public Properties
    static let shared = ServiceLayer()
    let networkService: NetworkServiceDelegate = NetworkService()
}
