//
//  NetworkResponse.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

struct NetworkResponse: Codable {
    var data: [ResponseData]
    var view: [String]
}

struct ResponseData: Codable {
    var name: String
    var data: DifferentData
}

struct DifferentData: Codable {
    var url: String?
    var text: String?
    var selectedId: Int?
    var variants: [Variants]?
}

struct Variants: Codable {
    var id: Int
    var text: String
}
