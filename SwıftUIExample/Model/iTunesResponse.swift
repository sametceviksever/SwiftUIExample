//
//  iTunesResponse.swift
//  SwıftUIExample
//
//  Created by Samet Çeviksever on 13.09.2020.
//  Copyright © 2020 Samet Çeviksever. All rights reserved.
//

import Foundation

struct Movie: Decodable, Identifiable {
  var id: Int
  var imageUrl: String
  var name: String
  var genre: String
  var description: String
  var trailerUrl: String?
  
  private enum CodingKeys: String, CodingKey {
    case imageUrl = "artworkUrl100"
    case name = "trackName"
    case genre = "primaryGenreName"
    case id = "trackId"
    case description = "longDescription"
    case trailerUrl = "previewUrl"
  }
}
