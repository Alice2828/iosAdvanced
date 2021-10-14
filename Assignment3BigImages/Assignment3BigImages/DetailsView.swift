//
//  DetailsView.swift
//  Assignment3BigImages
//
//  Created by Lebedeva Alice on 14.10.2021.
//

import SwiftUI

struct DetailsView: View {
    var imageUrl: String
    @ObservedObject var imageLoader = ImageLoader()
    
    init(imageUrl: String){
        self.imageUrl = imageUrl
        self.imageLoader.downloadImage(url: self.imageUrl)
    }
    
    var body: some View {
        if let data = self.imageLoader.downloadedData{
            return Image(uiImage: UIImage(data: data)!).resizable()
                .navigationTitle("Info")
                .navigationBarTitleDisplayMode(.inline)
        }
        else{
            return Image("placeholder")
                .navigationTitle("Placeholder")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}
