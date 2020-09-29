//
//  MainViewController+UITableView.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 29.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    private enum CellHeights {
        static let textCellHeight: CGFloat = 40
        static let pictureCellHeight: CGFloat = 120
        static let selectorCellModifier: CGFloat = 40
        static let defaultCellHeight: CGFloat = 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dataType = mainViewPresenter.getViewType(for: indexPath.row)
        
        switch dataType {
        case "hz":
            return CellHeights.textCellHeight
        case "picture":
            return CellHeights.pictureCellHeight
        case "selector":
            return CGFloat(mainViewPresenter.getSelectorsCount(for: indexPath.row)) * CellHeights.selectorCellModifier
        default:
            return CellHeights.defaultCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        mainViewPresenter.tableViewElementDidTapped(for: indexPath.row)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewPresenter.getTasksCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataType = mainViewPresenter.getViewType(for: indexPath.row)
        
        switch dataType {
        case "hz":
            return makeTextCell(for: indexPath, tableView: tableView)
        case "picture":
            return makeImageCell(for: indexPath, tableView: tableView)
        case "selector":
            return makeSelectorCell(for: indexPath, tableView: tableView)
        default:
            return UITableViewCell()
        }
    }
    
    private func makeTextCell(for indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            TextTableViewCell.reuseIdentifier, for: indexPath) as! TextTableViewCell
        mainViewPresenter.configureTextCell(cell, for: indexPath.row)
        return cell
    }
    
    private func makeImageCell(for indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            ImageTableViewCell.reuseIdentifier, for: indexPath) as! ImageTableViewCell
        mainViewPresenter.configureImageCell(cell, for: indexPath.row)
        return cell
    }
    
    private func makeSelectorCell(for indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            SelectorTableViewCell.reuseIdentifier, for: indexPath) as! SelectorTableViewCell
        cell.selectionStyle = .none
        cell.setParentViewController(self)
        let selectorData = mainViewPresenter.getSelectorData(for: indexPath.row)
        cell.setSelectorData(selectorData)
        return cell
    }
}


