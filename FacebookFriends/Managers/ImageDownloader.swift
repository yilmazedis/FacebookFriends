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
        CacheManager.shared.getCachedData(for: url.description, completion: { [weak self] data in
            if let data = data, let image = UIImage(data: data) {
                completion(image, true)
            } else {
                self?.downloadPhotoHelper(with: url, expiryDate: expiryDate, completion: completion)
            }
        })
    }

    func cancel() {
        imageDataTask?.cancel()
    }
    
    private func downloadPhotoHelper(with url: URL, expiryDate: Date, completion: @escaping ((UIImage?, Bool) -> Void)) {
        imageDataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            self?.imageDataTask = nil

            guard let data = data,
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
}
