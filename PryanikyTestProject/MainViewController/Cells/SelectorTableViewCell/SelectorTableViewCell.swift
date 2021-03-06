//
//  SelectorTableViewCell.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class SelectorTableViewCell: UITableViewCell {
    
    // MARK: - Public Properties
    static let reuseIdentifier = "SelectorTableViewCell"
    
    // MARK: - Private Properties
    private var checkedCellIndexPath: IndexPath? = IndexPath(row: 2, section: 0)
    private var selectorData: ResponseData?
    private var parentViewController: ParentViewControllerDelegate?
    
    private let checkedVariantImage = UIImage(systemName: "checkmark.circle")
    private let uncheckedVariantImage = UIImage(systemName: "circle")
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SelectorButtonsTableViewCell.self,
                           forCellReuseIdentifier: SelectorButtonsTableViewCell.reuseIdentifier)
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTableViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UITableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public methods
    func setParentViewController(_ parentViewController: ParentViewControllerDelegate) {
        self.parentViewController = parentViewController
    }
    
    func setSelectorData(_ selectorData: ResponseData?) {
        self.selectorData = selectorData
    }
    
    // MARK: - Private Methods
    private func setupTableViewConstraints() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate
extension SelectorTableViewCell: UITableViewDelegate {
    
    // MARK: - Types
    private enum CellSettings {
        static let height: CGFloat = 40
    }
    
    // MARK: - Public methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellSettings.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parentViewController?.selectorButtonTapped(selectedId: indexPath.row)
        
        guard let previousIndexPath = checkedCellIndexPath else { return }
        let previousCell = tableView.cellForRow(at: previousIndexPath) as! SelectorButtonsTableViewCell
        previousCell.setSelectorImage(uncheckedVariantImage)
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! SelectorButtonsTableViewCell
        selectedCell.setSelectorImage(checkedVariantImage)
        
        tableView.deselectRow(at: indexPath, animated: true)
        checkedCellIndexPath = indexPath
    }
}

// MARK: - UITableViewDataSource
extension SelectorTableViewCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let selectorCount = selectorData?.data.variants?.count else { return 0 }
        return selectorCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let variants = selectorData?.data.variants,
            let selectedId = selectorData?.data.selectedId else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectorButtonsTableViewCell.reuseIdentifier,
                                                 for: indexPath) as! SelectorButtonsTableViewCell
        cell.setSelectorTitle(variants[indexPath.row].text)
        if indexPath.row == selectedId {
            cell.setSelectorImage(checkedVariantImage)
            checkedCellIndexPath = indexPath
        } else {
            cell.setSelectorImage(uncheckedVariantImage)
        }
        cell.selectionStyle = .none
        return cell
    }
}
