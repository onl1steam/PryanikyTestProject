//
//  MainViewPresenter.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class MainViewPresenter {
    
    // MARK: - Private Properties
    weak private var mainViewDelegate: MainViewDelegate?
    private var networkService: NetworkServiceDelegate
    
    private var dataTypes: [String] = []
    private var data: [ResponseData] = []
    
    // MARK: - Initializers
    init(networkService: NetworkServiceDelegate = ServiceLayer.shared.networkService) {
        self.networkService = networkService
    }
    
    // MARK: - Public methods
    func setViewDelegate(_ viewDelegate: MainViewDelegate) {
        mainViewDelegate = viewDelegate
    }
    
    func getData() {
        networkService.makeDataRequst { [weak self] response in
            switch response {
            case .success(let requestData):
                self?.data = requestData.data
                self?.dataTypes = requestData.view
                print(requestData.data)
                print(requestData.view)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            self?.mainViewDelegate?.updateTableView()
        }
    }
    
    func getImage(for row: Int) {
        guard let imageURLString = data[1].data.url, let imageURL = URL(string: imageURLString) else { return }
        networkService.makeImageRequest(with: imageURL) { [weak self] response in
            switch response {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                self?.mainViewDelegate?.updateImageView(for: row, with: image)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func getViewType(for row: Int) -> String {
        return dataTypes[row]
    }
    
    func getTasksCount() -> Int {
        return dataTypes.count
    }
    
    func getSelectorsCount(for row: Int) -> Int {
        guard let responseData = getResponseData(for: dataTypes[row]),
            let selectorsCount = responseData.data.variants?.count else { return 0 }
        return selectorsCount
    }
    
    func configureTextCell(_ cell: TextTableViewCell, for row: Int) {
        guard let responseData = getResponseData(for: dataTypes[row]),
            let responseText = responseData.data.text else { return }
        cell.label.text = responseText
    }
    
    func configureImageCell(_ cell: ImageTableViewCell, for row: Int) {
        guard let responseData = getResponseData(for: dataTypes[row]),
            let responseText = responseData.data.text else { return }
        cell.imageLabel.text = responseText
        getImage(for: row)
    }
    
    func getSelectorData(for row: Int) -> ResponseData? {
        let selectorData = getResponseData(for: dataTypes[row])
        return selectorData
    }
    
    private func getResponseData(for dataType: String) -> ResponseData? {
        for responseData in data {
            if responseData.name == dataType {
                return responseData
            }
        }
        return nil
    }
}
