//
//  MainViewDelegate.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

protocol MainViewDelegate: NSObjectProtocol {
    func updateTableView()
    func updateImageView(for row: Int, with image: UIImage)
}
