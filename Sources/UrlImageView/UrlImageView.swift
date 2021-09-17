//
//  UrlImageView.swift
//
//
//  Created by Kamaal Farah on 10/09/2020.
//

import SwiftUI

public struct UrlImageView: View {
    @ObservedObject
    private var urlImageModel: UrlImageModel

    public let imageSize: CGSize
    public let imageColor: Color?
    private let placeHolderColor: Color

    public init(imageUrl: URL?, imageSize: CGSize, placeHolderColor: Color = Color(.systemBackground)) {
        self.urlImageModel = UrlImageModel(imageUrl: imageUrl)
        self.imageSize = imageSize
        self.placeHolderColor = placeHolderColor
        self.imageColor = nil
    }

    public init(imageUrl: URL?, imageSize: CGSize, imageColor: Color) {
        self.urlImageModel = UrlImageModel(imageUrl: imageUrl)
        self.imageSize = imageSize
        self.placeHolderColor = imageColor
        self.imageColor = imageColor
    }

    public var body: some View {
        ZStack {
            if let imageColor = self.imageColor {
                imageWithImageColor(imageColor: imageColor)
            } else {
                if let urlImage = urlImageModel.image {
                    Image(uiImage: urlImage)
                        .resizable()
                        .frame(width: imageSize.width, height: imageSize.height)
                } else {
                    UrlImageView.defaultImage
                        .resizable()
                        .frame(width: imageSize.width, height: imageSize.height)
                        .foregroundColor(placeHolderColor)
                }
            }
        }
        .frame(width: imageSize.width, height: imageSize.height)
    }

    private func imageWithImageColor(imageColor: Color) -> some View {
        let imageToReturn: Image
        if let urlImage = urlImageModel.image {
            imageToReturn =  Image(uiImage: urlImage)
        } else {
            imageToReturn = UrlImageView.defaultImage
        }
        return imageToReturn
            .resizable()
            .renderingMode(.template)
            .frame(width: imageSize.width, height: imageSize.height)
            .foregroundColor(imageColor)
    }

    static private var defaultImage = Image(systemName: "photo")
}

#if DEBUG
let debugURL = URL(string: "https://cdn.vox-cdn.com/thumbor/lcFItKgWrkvfGouCKrYRtZU-sIQ=/0x0:3360x2240/1200x800/filters:focal(1412x852:1948x1388)/cdn.vox-cdn.com/uploads/chorus_image/image/55017319/REC_ASA_CODE17-20170530-164855-0159.0.0.jpg")
struct UrlImageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            UrlImageView(imageUrl: debugURL, imageSize: CGSize(width: 30, height: 30), imageColor: .red)
            UrlImageView(imageUrl: debugURL, imageSize: CGSize(width: 30, height: 30), placeHolderColor: .black)
            UrlImageView(imageUrl: debugURL, imageSize: CGSize(width: 30, height: 30), placeHolderColor: .black)
        }
    }
}
#endif
