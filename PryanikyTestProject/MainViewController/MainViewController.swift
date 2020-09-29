//
//  MainViewController.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let mainTableView = UITableView()
        return mainTableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - Private Properties
    let mainViewPresenter: MainViewPresenter
    
    // MARK: - Initializers
    init(mainViewPresenter: MainViewPresenter = MainViewPresenter()) {
        self.mainViewPresenter = mainViewPresenter
        super.init(nibName: nil, bundle: nil)
        mainViewPresenter.setViewDelegate(self)
        setupTableView()
        setupTableViewContraints()
        setupActivityIndicatorConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewPresenter.fetchData()
    }
    
    private func setupActivityIndicatorConstraints() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.reuseIdentifier)
        tableView.register(TextTableViewCell.self, forCellReuseIdentifier: TextTableViewCell.reuseIdentifier)
        tableView.register(SelectorTableViewCell.self, forCellReuseIdentifier: SelectorTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTableViewContraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - MainViewDelegate
extension MainViewController: MainViewDelegate {
    
    func toggleActivityIndicator() {
        let isActivated = activityIndicator.isHidden
        if isActivated {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func updateImageView(for row: Int, with image: UIImage) {
        let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! ImageTableViewCell
        cell.cellImageView.image = image
    }
    
    func updateTableView() {
        tableView.reloadData()
    }
    
    func showAlert(title: String, description: String) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.title = title
        alert.message = description
        let confirmAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alert.addAction(confirmAction)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - ParentViewControllerDelegate
extension MainViewController: ParentViewControllerDelegate {
    
    func selectorButtonTapped(selectedId: Int) {
        mainViewPresenter.selectorElementDidTapped(selectedId: selectedId)
    }
}

