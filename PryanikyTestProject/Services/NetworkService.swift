//
//  NetworkService.swift
//  PryanikyTestProject
//
//  Created by Рыжков Артем on 28.09.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

protocol NetworkServiceDelegate {
    func makeRequst(_ completion: @escaping(Result<NetworkResponse, Error>) -> Void)
}

class NetworkService: NetworkServiceDelegate {
    
    private enum APIConfiguration {
        static let requestURL = URL(string: "https://pryaniky.com/static/json/sample.json")
    }
    
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .ephemeral)) {
        self.session = session
    }
    
    func makeRequst(_ completion: @escaping(Result<NetworkResponse, Error>) -> Void) {
        guard let requestURL = APIConfiguration.requestURL else { return }
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            do {
                let decodedData = try JSONDecoder().decode(NetworkResponse.self, from: data!)
                completion(.success(decodedData))
            } catch let networkError {
                completion(.failure(networkError))
            }
        }
        dataTask.resume()
    }
}
