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

    private var placeHolderColor: Color

    public init(imageUrl: URL?, imageSize: CGSize, placeHolderColor: Color) {
        self.urlImageModel = UrlImageModel(imageUrl: imageUrl)
        self.imageSize = imageSize
        self.placeHolderColor = placeHolderColor
    }

    public var body: some View {
        ZStack {
            if urlImageModel.image != nil {
                image
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: imageSize.width, height: imageSize.height)
                    .foregroundColor(placeHolderColor)
            }
        }
        .frame(width: imageSize.width, height: imageSize.height)
    }

    public var image: Image {
        if let urlImage = urlImageModel.image {
            return Image(uiImage: urlImage)
        }
        return UrlImageView.defaultImage
    }

    static private var defaultImage = Image(systemName: "photo")
}

#if DEBUG
let debugURL = URL(string: "https://cdn.vox-cdn.com/thumbor/lcFItKgWrkvfGouCKrYRtZU-sIQ=/0x0:3360x2240/1200x800/filters:focal(1412x852:1948x1388)/cdn.vox-cdn.com/uploads/chorus_image/image/55017319/REC_ASA_CODE17-20170530-164855-0159.0.0.jpg")
struct UrlImageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            UrlImageView(imageUrl: debugURL, imageSize: CGSize(width: 30, height: 30), placeHolderColor: .black)
            UrlImageView(imageUrl: debugURL, imageSize: CGSize(width: 30, height: 30), placeHolderColor: .black)
            UrlImageView(imageUrl: debugURL, imageSize: CGSize(width: 30, height: 30), placeHolderColor: .black)
        }
    }
}
#endif
