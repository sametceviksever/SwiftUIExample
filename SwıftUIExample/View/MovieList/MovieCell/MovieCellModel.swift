//
//  MovieCellModel.swift
//  SwıftUIExample
//
//  Created by Samet Çeviksever on 13.09.2020.
//  Copyright © 2020 Samet Çeviksever. All rights reserved.
//

import Foundation

struct MovieCellModel: Identifiable {
  var id: Int
  var isRead: Bool
  var name: String
  var imageUrl: String
  var genre: String
  var loader: ImageLoader
  
  init(id: Int,
       isRead: Bool,
       name: String,
       imageUrl: String,
       genre: String) {
    self.id = id
    self.isRead = isRead
    self.name = name
    self.imageUrl = imageUrl
    self.genre = genre
    
    self.loader = ImageLoader(placeHolder: "PlaceHolder", imageUrl: imageUrl)
  }
}
