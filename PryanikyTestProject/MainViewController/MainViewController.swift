//
//  MainViewController.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.reuseIdentifier)
        tableView.register(TextTableViewCell.self, forCellReuseIdentifier: TextTableViewCell.reuseIdentifier)
//        mainViewPresenter.getData()
        tableView.tableFooterView = UIView()
    }
}

// MARK: - MainViewDelegate
extension MainViewController: MainViewDelegate {
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 3 {
            return 120
        } else {
            return 40
        }
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Тестовое отображение данных
        if indexPath.row < 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                ImageTableViewCell.reuseIdentifier, for: indexPath) as! ImageTableViewCell
            cell.imageLabel.text = "Hello"
            cell.cellImageView.image = UIImage(named: "cert.png")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                TextTableViewCell.reuseIdentifier, for: indexPath) as! TextTableViewCell
            cell.imageLabel.text = "Hello"
            return cell
        }
    }
}
