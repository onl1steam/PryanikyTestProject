//
//  SelectorTableViewCell.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class SelectorTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "SelectorTableViewCell"
    
    private var checkedCellIndexPath: IndexPath? = IndexPath(row: 2, section: 0)
    private var selectorData: ResponseData?
    private var parentViewController: ParentViewControllerDelegate?
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTableViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setParentViewController(_ parentViewController: ParentViewControllerDelegate) {
        self.parentViewController = parentViewController
    }
    
    func setSelectorData(_ selectorData: ResponseData?) {
        self.selectorData = selectorData
    }
    
    private func setupTableViewConstraints() {
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

extension SelectorTableViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parentViewController?.selectorButtonTapped(selectedId: indexPath.row)
        
        guard let previousIndexPath = checkedCellIndexPath else { return }
        let previousCell = tableView.cellForRow(at: previousIndexPath) as! SelectorButtonsTableViewCell
        previousCell.selectorImageView.image = UIImage(systemName: "circle")
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! SelectorButtonsTableViewCell
        selectedCell.selectorImageView.image = UIImage(systemName: "checkmark.circle")
        
        tableView.deselectRow(at: indexPath, animated: true)
        checkedCellIndexPath = indexPath
    }
}

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
        cell.selectorLabel.text = variants[indexPath.row].text
        if indexPath.row == selectedId {
            cell.selectorImageView.image = UIImage(systemName: "checkmark.circle")
            checkedCellIndexPath = indexPath
        }
        cell.selectionStyle = .none
        return cell
    }
}
