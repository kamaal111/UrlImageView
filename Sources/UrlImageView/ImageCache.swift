//
//  ImageCache.swift
//  
//
//  Created by Kamaal Farah on 10/09/2020.
//

import SwiftUI

class ImageCache {
    private var cache = NSCache<NSString, AnyObject>()

    private static var imageCache = ImageCache()

    #if canImport(UIKit)
    func get(forKey key: String) -> UIImage? {
        cache.object(forKey: NSString(string: key)) as? UIImage
    }
    #else
    func get(forKey key: String) -> NSImage? {
        cache.object(forKey: NSString(string: key)) as? NSImage
    }
    #endif

    func set(forKey key: String, object: AnyObject) {
        self.cache.setObject(object, forKey: NSString(string: key))
    }

    static func getImageCache() -> ImageCache {
        imageCache
    }
}
