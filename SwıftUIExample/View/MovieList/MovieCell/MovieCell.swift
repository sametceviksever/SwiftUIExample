//
//  MovieCell.swift
//  SwıftUIExample
//
//  Created by Samet Çeviksever on 13.09.2020.
//  Copyright © 2020 Samet Çeviksever. All rights reserved.
//

import SwiftUI

struct MovieCell: View {
  var movie: MovieCellModel
  @State var image: UIImage = UIImage()
  
  var body: some View {
    HStack(spacing: 10) {
      Image(uiImage: image)
        .resizable(capInsets: EdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3),
                   resizingMode: Image.ResizingMode.stretch)
        .frame(width: 60, height: 60, alignment: .center)
        .clipShape(Circle())
        .shadow(radius: 2)
        .overlay(Circle().stroke(Color.black, lineWidth: 2))
      VStack(alignment: .leading, spacing: 3) {
        Text(movie.name)
          .bold()
        Text(movie.genre)
          .italic()
      }
      Spacer()
    }
    .background(movie.isRead ? Color.gray : Color.white)
    .onAppear(perform: {
      self.movie.loader.load()
    })
      .onReceive(self.movie.loader.$image) { image in
        self.image = image
    }
  }
}

struct MovieCell_Previews: PreviewProvider {
  static var cell = MovieCellModel(id: 1,
                                   isRead: false,
                                   name: "Harry Potter and the Deathly Hallows, Part 2",
                                   imageUrl: "https://is4-ssl.mzstatic.com/image/thumb/Video124/v4/3f/bd/f5/3fbdf514-219a-6973-f77e-6c42147b6dac/pr_source.lsr/100x100bb.jpg",
                                   genre: "Kids & Family")
  static var previews: some View {
    MovieCell(movie: cell)
    }
}
