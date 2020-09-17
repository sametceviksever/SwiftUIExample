//
//  MovieListViewModel.swift
//  SwıftUIExample
//
//  Created by Samet Çeviksever on 13.09.2020.
//  Copyright © 2020 Samet Çeviksever. All rights reserved.
//

import Combine
import Foundation

private struct iTunesResponse: Decodable {
  var results: [Movie]
}

final class MovieListViewModel {
  @Published var movies: [Movie] = []
  
  private var cancelable: AnyCancellable?
  
  func load(with term: String) {
    let mutTerm = term.replacingOccurrences(of: " ", with: "+")
    guard let url = URL(string: "https://itunes.apple.com/search?media=movie&term=\(mutTerm)") else {
      return
    }
    
    self.cancelable = URLSession.shared.dataTaskPublisher(for: url)
      .compactMap({try? JSONDecoder().decode(iTunesResponse.self, from: $0.data)})
      .replaceError(with: iTunesResponse(results: []))
      .map({$0.results})
      .assign(to: \.movies, on: self)
  }
}
