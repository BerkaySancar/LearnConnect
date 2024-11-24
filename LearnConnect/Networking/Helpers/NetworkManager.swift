//
//  NetworkManager.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 23.11.2024.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let decoder = JSONDecoder()
    
    private var isReachable: Bool {
        return Reachability.isNetworkReachable()
    }
    
    private init() {}

    func request<T: Codable>(_ request: URLRequestConvertible, type: T.Type, completion: @escaping (Result<T?, NetworkError>) -> Void) {
        if isReachable {
            URLSession.shared.dataTask(with: request.urlRequest()) { (data, response, error) in
                if error != nil {
                    completion(.failure(.invalidURLRequest))
                }
                
                if let response = response as? HTTPURLResponse,
                   let data = data {
                    switch response.statusCode {
                    case 200...299:
                        let decodedData = try? self.decoder.decode(T.self, from: data)
                        completion(.success(decodedData))
                        #if DEBUG
                        print("------\(response.statusCode)------\(request.urlRequest())------\(response.statusCode)------")
                        #endif
                        return
                    case 401:
                        completion(.failure(NetworkError.unauthorized))
                        #if DEBUG
                        print("------\(response.statusCode)------\(request.urlRequest())------\(response.statusCode)------")
                        #endif
                        return
                    case 429:
                        completion(.failure(.rateLimit))
                        #if DEBUG
                        print("------\(response.statusCode)------\(request.urlRequest())------\(response.statusCode)------")
                        #endif
                    default:
                        completion(.failure(NetworkError.invalidResponse))
                        #if DEBUG
                        print("------\(response.statusCode)------\(request.urlRequest())------\(response.statusCode)------")
                        #endif
                        return
                    }
                }
            }.resume()
        } else {
            completion(.failure(.noConnection))
            return
        }
    }
}
