//
//  NetworkService.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

protocol NetworkServiceDelegate {
    func makeDataRequst(_ completion: @escaping(Result<NetworkResponse, Error>) -> Void)
    func makeImageRequest(with url: URL, _ completion: @escaping(Result<Data, Error>) -> Void)
}

final class NetworkService: NetworkServiceDelegate {
    
    private enum APIConfiguration {
        static let requestURL = URL(string: "https://pryaniky.com/static/json/sample.json")
    }
    
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .ephemeral)) {
        self.session = session
    }
    
    func makeDataRequst(_ completion: @escaping(Result<NetworkResponse, Error>) -> Void) {
        guard let requestURL = APIConfiguration.requestURL else { return }
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            if let networkError = error {
                DispatchQueue.main.async {
                    completion(.failure(networkError))
                }
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(NetworkResponse.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch let networkError {
                DispatchQueue.main.async {
                    completion(.failure(networkError))
                }
            }
        }
        dataTask.resume()
    }
    
    func makeImageRequest(with url: URL, _ completion: @escaping(Result<Data, Error>) -> Void) {
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let networkError = error {
                DispatchQueue.main.async {
                    completion(.failure(networkError))
                }
                return
            }
            
            if let requestData = data {
                DispatchQueue.main.async {
                    completion(.success(requestData))
                }
                return
            }
        }
        dataTask.resume()
    }
}
