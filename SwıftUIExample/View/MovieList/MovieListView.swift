//
//  MovieListView.swift
//  SwıftUIExample
//
//  Created by Samet Çeviksever on 13.09.2020.
//  Copyright © 2020 Samet Çeviksever. All rights reserved.
//

import SwiftUI

struct MovieListView: View {
  var viewModel: MovieListViewModel = MovieListViewModel()
  @State var movies: [MovieCellModel] = []
  @State var searchText: String = ""
  @Environment(\.viewController) private var controller: UIViewController?
  
  var body: some View {
    VStack(spacing: 10) {
      TextField("Search",
                text: $searchText,
                onCommit: {
                  self.viewModel.load(with: self.searchText)
      })
        .frame(height: 25)
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 0))
        .overlay(Rectangle().stroke(Color.gray, lineWidth: 2))
        .cornerRadius(4)
        .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
      List(self.movies, id: \.id, rowContent: { movie in
        MovieCell(movie: movie)
          .onTapGesture {
            guard let index = self.movies.firstIndex(where: {$0.id == movie.id}) else {
              return
            }
            self.controller?.present(builder: {
              MovieDetailView(movie: self.viewModel.movies[index])
            })
            self.movies[index].isRead = true
        }
      })
    }
    .onReceive(self.viewModel.$movies) { (movies) in
      self.movies = movies.map({MovieCellModel(id: $0.id,
                                               isRead: false,
                                               name: $0.name,
                                               imageUrl: $0.imageUrl,
                                               genre: $0.genre)})
    }
    .navigationBarTitle("Movie", displayMode: .inline)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MovieListView()
  }
}
