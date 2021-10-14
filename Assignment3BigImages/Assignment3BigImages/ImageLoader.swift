//
//  ImageLoader.swift
//  Assignment3BigImages
//
//  Created by Lebedeva Alice on 14.10.2021.
//

import Foundation
class ImageLoader: ObservableObject {
    
    @Published var downloadedData: Data?
    
    
    func downloadImage(url: String) {
        guard let imageUrl = URL(string: url) else{
            return
        }
        URLSession.shared.dataTask(with: imageUrl){data,_,error in
            guard let data = data, error == nil else{
                return
            }
            DispatchQueue.main.async {
                self.downloadedData = data
            }
        }.resume()
    }
}
