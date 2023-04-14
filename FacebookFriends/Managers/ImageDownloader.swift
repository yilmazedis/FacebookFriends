//
//  ImageDownloader.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import UIKit

final class ImageDownloader {
    private var imageDataTask: URLSessionDataTask?

    func downloadPhoto(with url: URL, expiryDate: Date, completion: @escaping ((UIImage?, Bool) -> Void)) {

        if let data =  CacheManager.shared.getCachedData(for: url.description),
            let image = UIImage(data: data) {
            completion(image, true)
            return
        }
        
        imageDataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            self?.imageDataTask = nil

            guard let data = data,
                  //let response = response,
                  let image = UIImage(data: data),
                  error == nil
            else { return }
            
            CacheManager.shared.cacheData(data, for: url.description, expiryDate: expiryDate)

            DispatchQueue.main.async {
                let decodedImage = image.preloadedImage()
                completion(decodedImage, false)
            }
        }
        imageDataTask?.resume()
    }

    func cancel() {
        imageDataTask?.cancel()
    }
}
