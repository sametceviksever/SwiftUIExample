//
//  ImageLoader.swift
//  SwıftUIExample
//
//  Created by Samet Çeviksever on 13.09.2020.
//  Copyright © 2020 Samet Çeviksever. All rights reserved.
//

import Combine
import SwiftUI

final class ImageLoader {
  @Published var image: UIImage
  
  deinit {
    print("------- Loader deinit -------")
    cancelable?.cancel()
  }
  
  private var imageUrl: URL?
  private var cancelable: AnyCancellable?
  
  init(placeHolder: String, imageUrl: String) {
    
    self.image = UIImage(named: placeHolder, in: Bundle(for: Self.self), with: nil)!
    self.imageUrl = URL(string: imageUrl)
    self.cancelable = nil
  }
  
  func load() {
    guard let url = imageUrl else {
      return
    }
    
    self.cancelable = URLSession.shared.dataTaskPublisher(for: url)
      .map({UIImage(data: $0.data)})
      .compactMap({$0})
      .replaceError(with: self.image)
      .assign(to: \.image, on: self)
  }
  
  func cancel() {
    self.cancelable?.cancel()
  }
}
