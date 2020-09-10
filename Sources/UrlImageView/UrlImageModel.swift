//
//  UrlImageModel.swift
//  
//
//  Created by Kamaal Farah on 10/09/2020.
//

import SwiftUI
import Combine
import KamaalNetworker

final public class UrlImageModel: ObservableObject {

    @Published public var image: UIImage?

    private var imageUrl: URL?

    private var imageCache = ImageCache.getImageCache()

    private var kowalskiAnalysis: Bool
    private let networker: KamaalNetworkable?

    internal init(imageUrl: URL?,
         networker: KamaalNetworkable = KamaalNetworker(),
         kowalskiAnalysis: Bool = false) {
        self.kowalskiAnalysis = kowalskiAnalysis
        self.networker = networker
        self.imageUrl = imageUrl
        self.analyse("\(imageUrl?.absoluteString ?? "") loaded from NSCache")
        let loaded = loadImageFromCache()
        if !loaded {
            loadImage()
        }
    }

    public init(imageUrl: URL?) {
        self.kowalskiAnalysis = false
        self.networker = KamaalNetworker()
        self.imageUrl = imageUrl
        self.analyse("\(imageUrl?.absoluteString ?? "") loaded from NSCache")
        let loaded = loadImageFromCache()
        if !loaded {
            loadImage()
        }
    }

}

private extension UrlImageModel {
    func loadImageFromCache() -> Bool {
        guard let urlString = imageUrl?.absoluteString,
            let cacheImage = imageCache.get(forKey: urlString) else {
                return false
        }
        image = cacheImage
        return true
    }

    func loadImage() {
        guard let urlString = imageUrl?.absoluteString else { return }
        DispatchQueue.global().async {
            self.networker?.loadImage(from: urlString) { [weak self] result in
                switch result {
                case .failure(let failure):
                    self?.analyse("*** Failed to load image of \(urlString) -> \(failure)")
                case .success(let imageData):
                    self?.saveAndSetCachedImage(imageData: imageData, urlString: urlString)
                }
            }
        }
    }

    func saveAndSetCachedImage(imageData: Data, urlString: String) {
        guard let image = UIImage(data: imageData) else { return }
        DispatchQueue.main.async {
            self.imageCache.set(forKey: urlString, image: image)
            self.image = image
        }
    }

    func analyse(_ message: String) {
        if kowalskiAnalysis {
            print(message)
        }
    }
}
