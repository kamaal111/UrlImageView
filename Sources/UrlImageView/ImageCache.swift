//
//  ImageCache.swift
//  
//
//  Created by Kamaal Farah on 10/09/2020.
//

import UIKit

public class ImageCache {

    private var cache = NSCache<NSString, UIImage>()

    private static var imageCache = ImageCache()

    public func get(forKey key: String) -> UIImage? {
        cache.object(forKey: NSString(string: key))
    }

    public func set(forKey key: String, image: UIImage) {
        self.cache.setObject(image, forKey: NSString(string: key))
    }

    public static func getImageCache() -> ImageCache {
        imageCache
    }

}
