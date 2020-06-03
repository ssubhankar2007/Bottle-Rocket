//
//  APIManager.swift
//  Bottle Rocket
//
//  Created by Subhankar Ghosh on 28/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import Foundation

class APIManager {
    
    private let baseUrl = "https://s3.amazonaws.com/br-codingexams/"
    
    typealias parameters = [String:Any]
    
    enum HTTPMethod: String {
        case get     = "GET"
        case post    = "POST"
        case put     = "PUT"
        case delete  = "DELETE"
    }
    enum RequestError: Error {
        case unknownError
        case connectionError
        case authorizationError([String: Any])
        case invalidRequest
        case notFound
        case invalidResponse
        case serverError
        case serverUnavailable
    }
    
    func requestData(url: URL, method: HTTPMethod, parameters: parameters?, completion: @escaping (Result<Data, RequestError>) -> Void) {
        let header =  ["Content-Type": "application/x-www-form-urlencoded"]
        
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpMethod = method.rawValue
        
        if let parameters = parameters {
            let parameterData = parameters.reduce("") { (result, param) -> String in
                return result + "&\(param.key)=\(param.value as! String)"
            }.data(using: .utf8)
            urlRequest.httpBody = parameterData
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let _ = error {
                completion(.failure(.connectionError))
            } else if let data = data, let responseCode = response as? HTTPURLResponse {
                do {
                    if let responseJson = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        
                        switch responseCode.statusCode {
                        case 200:
                            completion(.success(data))
                        case 400...499:
                            completion(.failure(.authorizationError(responseJson)))
                        case 500...599:
                            completion(.failure(.serverError))
                        default:
                            completion(.failure(.unknownError))
                            break
                        }
                    }
                }
                catch let parseJSONError {
                    completion(.failure(.unknownError))
                    print("error on parsing request to JSON : \(parseJSONError)")
                }
            }
        }.resume()
    }
    
    public func fetchRestaurentsData(completionHandler:@escaping(Result<Data, RequestError>) -> Void)  {
        let urlStr = baseUrl + "restaurants.json"
        guard let url = URL(string: urlStr) else {
            return
        }
        requestData(url: url, method: .get, parameters: nil) { (data) in
            completionHandler(data)
        }
    }
}

