//
//  Networker.swift
//  
//
//  Created by Kamaal Farah on 10/09/2020.
//

import Foundation

internal protocol Networkable {
    func loadImage(from imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void)
}

internal struct Networker: Networkable {
    internal func loadImage(from imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: imageUrl) else {
            completion(.failure(NSError(domain: "url error", code: 400, userInfo: nil)))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard (response as? HTTPURLResponse) != nil else {
                completion(.failure(NSError(domain: "response code error", code: 400, userInfo: nil)))
                return
            }
            guard let dataResponse = data else {
                completion(.failure(NSError(domain: "data error", code: 400, userInfo: nil)))
                return
            }
            completion(.success(dataResponse))
        }
        .resume()
    }
}
