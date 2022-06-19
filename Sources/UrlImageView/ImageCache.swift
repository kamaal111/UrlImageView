//
//  ImageCache.swift
//  
//
//  Created by Kamaal Farah on 10/09/2020.
//

import SwiftUI

public class ImageCache {
    private var cache = NSCache<NSString, AnyObject>()

    private static var imageCache = ImageCache()

    #if canImport(UIKit)
    public func get(forKey key: String) -> UIImage? {
        cache.object(forKey: NSString(string: key)) as? UIImage
    }
    #else
    public func get(forKey key: String) -> NSImage? {
        cache.object(forKey: NSString(string: key)) as? NSImage
    }
    #endif

    public func set(forKey key: String, object: AnyObject) {
        self.cache.setObject(object, forKey: NSString(string: key))
    }

    public static func getImageCache() -> ImageCache {
        imageCache
    }
}
