//
//  File.swift
//  
//
//  Created by Kamaal Farah on 10/09/2020.
//

import UIKit

class ImageCache {

    private var cache = NSCache<NSString, UIImage>()

    private static var imageCache = ImageCache()

    func get(forKey key: String) -> UIImage? {
        cache.object(forKey: NSString(string: key))
    }

    func set(forKey key: String, image: UIImage) {
        self.cache.setObject(image, forKey: NSString(string: key))
    }

    static func getImageCache() -> ImageCache {
        imageCache
    }

}
