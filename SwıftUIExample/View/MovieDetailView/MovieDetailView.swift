//
//  MovieDetailView.swift
//  SwıftUIExample
//
//  Created by Samet Çeviksever on 13.09.2020.
//  Copyright © 2020 Samet Çeviksever. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
  var movie: Movie
  
  private var loader: ImageLoader
  @State private var image: UIImage = UIImage()
  @Environment(\.viewController) private var controller: UIViewController?
  
  init(movie: Movie) {
    self.movie = movie
    self.loader = ImageLoader(placeHolder: "PlaceHolder", imageUrl: movie.imageUrl)
  }
  
  var body: some View {
    GeometryReader { reader in
      ScrollView(.vertical, showsIndicators: false, content: {
        VStack {
          HStack {
            Spacer()
            Button(action: {
              self.controller?.dismiss(animated: true, completion: nil)
            }, label: {
              Text("Kapat")
                .foregroundColor(.black)
            })
              .padding(.trailing, 10)
          }.frame(height: 30)
          VideoView(videoUrl: self.movie.trailerUrl!)
          HStack(alignment: .top, spacing: 10, content: {
            Image(uiImage: self.image)
            VStack(alignment: .leading, spacing: 5) {
              Text(self.movie.name)
                .bold()
              Text(self.movie.genre)
                .italic()
              Text(self.movie.description)
            }
          })
            .padding([.leading, .trailing], 5)
          Spacer()
        }
        .frame(width: reader.size.width)
      })
    }
    .background(Color.white)
    .onAppear {
      self.loader.load()
    }.onReceive(loader.$image) { (newImage) in
      self.image = newImage
    }
  }
}
