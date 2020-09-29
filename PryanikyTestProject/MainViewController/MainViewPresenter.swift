//
//  MainViewPresenter.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class MainViewPresenter {
    
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
    
    func fetchData() {
        mainViewDelegate?.toggleActivityIndicator()
        networkService.makeDataRequst { [weak self] response in
            switch response {
            case .success(let requestData):
                self?.data = requestData.data
                self?.dataTypes = requestData.view
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            self?.mainViewDelegate?.toggleActivityIndicator()
            self?.mainViewDelegate?.updateTableView()
        }
    }
    
    func fetchImage(for row: Int) {
        guard let imageURLString = data[1].data.url, let imageURL = URL(string: imageURLString) else { return }
        mainViewDelegate?.toggleActivityIndicator()
        networkService.makeImageRequest(with: imageURL) { [weak self] response in
            switch response {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                self?.mainViewDelegate?.updateImageView(for: row, with: image)
            case .failure(let error):
                print("Error: \(error)")
            }
            self?.mainViewDelegate?.toggleActivityIndicator()
        }
    }
    
    func tableViewElementDidTapped(for row: Int) {
        guard let responseData = getResponseData(for: dataTypes[row]) else { return }
        let dataType = dataTypes[row]
        
        switch dataType {
        case "hz":
            guard let info = responseData.data.text else { return }
            mainViewDelegate?.showAlert(title: "Текстовая ячейка", description: "Сообщение: \(info)")
        case "picture":
            guard let info = responseData.data.text else { return }
            mainViewDelegate?.showAlert(title: "Ячейка с изображением", description: "Сообщение: \(info)")
        default:
            mainViewDelegate?.showAlert(title: "Неизвестная ячейка", description: "Неизвестная ячейка")
        }
    }
    
    func selectorElementDidTapped(selectedId: Int) {
        guard let responseData = getResponseData(for: "selector") else { return }

        guard let info = responseData.data.variants?[selectedId].text else { return }
        mainViewDelegate?.showAlert(title: "Ячейка селектора",
                                    description: "Выбранный вариант: \(info)" + "\n" + "ID варианта: \(selectedId)")
    }
    
    func getViewType(for row: Int) -> String {
        return dataTypes[row]
    }
    
    func getTasksCount() -> Int {
        return dataTypes.count
    }
    
    func getCellText(for row: Int) -> String {
        guard let responseData = getResponseData(for: dataTypes[row]),
            let responseText = responseData.data.text else { return "" }
        return responseText
    }
    
    func setImageCellImage(for row: Int) {
        fetchImage(for: row)
    }
    
    func getSelectorData(for row: Int) -> ResponseData? {
        let selectorData = getResponseData(for: dataTypes[row])
        return selectorData
    }
    
    func getSelectorsCount(for row: Int) -> Int {
        guard let responseData = getResponseData(for: dataTypes[row]),
            let selectorsCount = responseData.data.variants?.count else { return 0 }
        return selectorsCount
    }

    // MARK: Private Methods
    private func getResponseData(for dataType: String) -> ResponseData? {
        for responseData in data {
            if responseData.name == dataType {
                return responseData
            }
        }
        return nil
    }
}
