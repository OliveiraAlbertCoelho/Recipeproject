//
//  RecipeFetcher.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 3/30/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import Foundation

class NetworkManager{
    static let manager = NetworkManager()
    func fetchData(urlString: String, completionHandler: @escaping (Result<Data,NetWorkError>) -> ()){
        guard let url = URL(string: urlString) else {
            return completionHandler(.failure(.badURL))
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else{
                return completionHandler(.failure(.noNetwork))
        }
            guard let data = data else {
              return  completionHandler(.failure(.noData))
            }
            guard let response = response as? HTTPURLResponse else {
               return completionHandler(.failure(.badHTTPResponse))
            }
            switch response.statusCode{
            case 404:
                completionHandler(.failure(.notFound))
            case 401, 403:
                completionHandler(.failure(.unauthorized))
            case 200...299:
                completionHandler(.success(data))
            default:
                completionHandler(.failure(.error))
            }
        }.resume()
    }
}
enum NetWorkError: Error {
    case badURL
    case noNetwork
    case noData
    case badHTTPResponse
    case notFound
    case unauthorized
    case error
}
