//
//  URLSession+DataTask.swift
//  WeatherTester
//
//  Created by ohhyung kwon on 21/7/2022.
//

import Foundation

enum SessionTaskError: Error {
  case invalidResponse
  case noData
  case failedRequest
  case invalidData
}


extension URLSession {
    typealias TaskHandler = (Result<Data, SessionTaskError>) -> Void
    
    /// start task immediately
    ///
    /// - Parameters:
    ///     - url: The URL to be retrieved.
    ///     - completion: The completion handler to call when the load request is complete. This handler is executed on the delegate queue.
    ///
    func startDataTask(with url: URL, completion: @escaping TaskHandler){
        dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                print("Failed request: \(error!.localizedDescription)")
                completion(.failure(.failedRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Unable to process response")
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200..<300) ~= response.statusCode else {
                print("Failure response: \(response.statusCode)")
                completion(.failure(.failedRequest))
                return
            }

            guard let data = data else {
                print("No data returned")
                completion(.failure(.noData))
                return
            }

            completion(.success(data))
        }
        .resume()
    }
}
