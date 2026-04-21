//
//  UIImageView+Loading.swift
//  Mova
//
//  Created by Muhammad Tayyab Nadeem on 21/04/2026.
//
import UIKit

private let cache = NSCache<NSString, UIImage>()

extension UIImageView {

    func loadImage(from urlString: String) {

        self.image = nil

        if let cached = cache.object(forKey: urlString as NSString) {
            self.image = cached
            return
        }

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data,
                  let image = UIImage(data: data) else { return }

            cache.setObject(image, forKey: urlString as NSString)

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
