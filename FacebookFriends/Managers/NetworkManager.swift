//
//  NetworkManager.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    func fetch<T: Decodable>(with url: URL?, expiryDate: Date, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = url else {
            FastLogger.log(what: K.ErrorMessage.url, about: .error)
            return
        }
        
        if let data = CacheManager.shared.getCachedData(for: url.absoluteString) {
            do {
                print("\( url.absoluteString) From Cache")
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(ManagerFail.decode))
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data = data else {
                completion(.failure(ManagerFail.data))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(ManagerFail.response))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(ManagerFail.statusCode))
                return
            }
            
            guard error == nil else {
                completion(.failure(ManagerFail.error))
                return
            }
            
            //FastLogger.log(what: K.InfoMessage.api, about: .info)
            
            print("\( url.description) From URL")
            CacheManager.shared.cacheData(data, for: url.absoluteString, expiryDate: expiryDate)

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(ManagerFail.decode))
            }
        }
        task.resume()
    }
}
