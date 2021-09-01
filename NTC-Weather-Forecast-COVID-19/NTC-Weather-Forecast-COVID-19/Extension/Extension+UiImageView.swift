//
//  Extension+UiImageView.swift
//  NTC-Weather-Forecast-COVID-19
//
//  Created by trần nam on 9/1/21.
//

import Foundation
import UIKit

public extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
    
    func setImage(from url: URL, placeholder: UIImage? = nil) {
        image = placeholder
        ImageCache.shared.image(for: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

class ImageCache {
    
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    func image(for url: URL, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        if let imageInCache = cache.object(forKey: url.absoluteString as NSString) {
            completionHandler(.success(imageInCache))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [unowned self] data, _, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: url.absoluteString as NSString)
            completionHandler(.success(image))
        }
        task.resume()
    }
}
