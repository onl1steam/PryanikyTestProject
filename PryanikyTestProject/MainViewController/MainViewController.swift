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
        setupTableView()
        mainViewPresenter.getData()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.reuseIdentifier)
        tableView.register(TextTableViewCell.self, forCellReuseIdentifier: TextTableViewCell.reuseIdentifier)
        tableView.register(SelectorTableViewCell.self, forCellReuseIdentifier: SelectorTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
    }
}

// MARK: - MainViewDelegate
extension MainViewController: MainViewDelegate {
    
    func updateImageView(for row: Int, with image: UIImage) {
        let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! ImageTableViewCell
        cell.cellImageView.image = image
    }
    
    func updateTableView() {
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dataType = mainViewPresenter.getViewType(for: indexPath.row)
        
        switch dataType {
        case "hz":
            return 40
        case "picture":
            return 120
        case "selector":
            let titleSpace = ((mainViewPresenter.getSelectorData(for: indexPath.row)?.data.text) != nil) ? 20: 0
            return CGFloat(mainViewPresenter.getSelectorsCount(for: indexPath.row) * 40 + titleSpace)
        default:
            return 0
        }
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewPresenter.getTasksCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataType = mainViewPresenter.getViewType(for: indexPath.row)
        
        switch dataType {
        case "hz":
            let cell = tableView.dequeueReusableCell(withIdentifier:
                TextTableViewCell.reuseIdentifier, for: indexPath) as! TextTableViewCell
            mainViewPresenter.configureTextCell(cell, for: indexPath.row)
            return cell
        case "picture":
            let cell = tableView.dequeueReusableCell(withIdentifier:
                ImageTableViewCell.reuseIdentifier, for: indexPath) as! ImageTableViewCell
            mainViewPresenter.configureImageCell(cell, for: indexPath.row)
            return cell
        case "selector":
            let cell = tableView.dequeueReusableCell(withIdentifier:
                SelectorTableViewCell.reuseIdentifier, for: indexPath) as! SelectorTableViewCell
            cell.selectionStyle = .none
            let selectorData = mainViewPresenter.getSelectorData(for: indexPath.row)
            cell.setSelectorData(selectorData)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
