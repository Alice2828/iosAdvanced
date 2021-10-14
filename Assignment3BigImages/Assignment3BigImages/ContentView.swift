//
//  ContentView.swift
//  Assignment3BigImages
//
//  Created by Lebedeva Alice on 14.10.2021.
//

import SwiftUI

struct ContentView: View {
    let images:[Picture] = [Picture(name: "one", imageString: "https://pbs.twimg.com/profile_images/1014427144192188416/jsstFGsX_400x400.jpg"), Picture(name: "two", imageString: "https://avatars.mds.yandex.net/get-kinopoisk-post-img/1101236/24122c4fd7f3f794461342474d069c59/960"), Picture(name: "three", imageString: "https://pbs.twimg.com/profile_images/1375188191016194049/SZ0Xi6MU_400x400.jpg")]
    
    var body: some View {
        VStack{
            NavigationView {
                List {
                    ForEach(images, id: \.self) { image in
                        ImgRow(image: image)
                    }
                }
                .navigationTitle("Images")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct ImgRow: View {
    var image: Picture
    var imageUrl: String = ""
    init(image: Picture){
        self.image = image
        self.imageUrl = self.image.imageString
    }
    var body: some View {
        NavigationLink(destination: DetailsView(imageUrl: imageUrl)) {
            Text(image.name).multilineTextAlignment(.leading).font(.system(size: 20,  weight: .heavy))
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
