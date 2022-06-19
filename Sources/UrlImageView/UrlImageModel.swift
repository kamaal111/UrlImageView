//
//  UrlImageModel.swift
//
//
//  Created by Kamaal Farah on 10/09/2020.
//

import SwiftUI
import Combine
import XiphiasNet

final class UrlImageModel: ObservableObject {

    #if canImport(UIKit)
    @Published var image: UIImage?
    #else
    @Published var image: NSImage?
    #endif

    private var imageUrl: URL?
    private var imageCache = ImageCache.getImageCache()
    private var kowalskiAnalysis: Bool
    private let networker = XiphiasNet()

    init(imageUrl: URL?, kowalskiAnalysis: Bool = false) {
        self.kowalskiAnalysis = kowalskiAnalysis
        self.imageUrl = imageUrl
        self.analyse("\(imageUrl?.absoluteString ?? "") loaded from NSCache")

        Task {
            let loaded = await loadImageFromCache()
            if !loaded {
                await loadImage()
            }
        }
    }

    convenience init(imageUrl: URL?) {
        self.init(imageUrl: imageUrl, kowalskiAnalysis: false)
    }

}

private extension UrlImageModel {
    func loadImageFromCache() async -> Bool {
        guard let urlString = imageUrl?.absoluteString,
            let cacheImage = await imageCache.get(forKey: urlString) else {
                return false
        }
        await setImage(cacheImage)
        return true
    }

    func loadImage() async {
        guard let imageUrl = imageUrl else { return }

        let imageDataResult = self.networker.loadImage(from: imageUrl)
        switch imageDataResult {
        case .failure(let failure):
            analyse("*** Failed to load image of \(imageUrl.absoluteString) -> \(failure)")
        case .success(let success):
            await saveAndSetCachedImage(imageData: success, urlString: imageUrl.absoluteString)
        }
    }

    func saveAndSetCachedImage(imageData: Data, urlString: String) async {
        #if canImport(UIKit)
        guard let image = UIImage(data: imageData) else { return }
        #else
        guard let image = NSImage(data: imageData) else { return }
        #endif

        async let cacheCompletion: () = imageCache.set(forKey: urlString, object: image)
        async let setImageCompletion: () = setImage(image)

        _ = await [cacheCompletion, setImageCompletion]
    }

    #if canImport(UIKit)
    @MainActor
    func setImage(_ image: UIImage) {
        self.image = image
    }
    #else
    @MainActor
    func setImage(_ image: NSImage) {
        self.image = image
    }
    #endif

    func analyse(_ message: String) {
        if kowalskiAnalysis {
            print(message)
        }
    }
}
