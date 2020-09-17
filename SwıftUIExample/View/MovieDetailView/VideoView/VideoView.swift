//
//  VideoView.swift
//  SwıftUIExample
//
//  Created by Samet Çeviksever on 13.09.2020.
//  Copyright © 2020 Samet Çeviksever. All rights reserved.
//

import SwiftUI
import AVKit

struct VideoView: View {
  var videoUrl: String
  @State var image: UIImage = UIImage(systemName: "captureVideo") ?? UIImage()
  @Environment(\.viewController) private var viewControllerHolder: UIViewController?
  @State private var loadedImage: UIImage?
  
  init(videoUrl: String) {
    self.videoUrl = videoUrl
  }
  
  var body: some View {
    ZStack(alignment: .center) {
      Image(uiImage: image)
      Button(action: {
        self.showTrailer()
      }, label: {
        Image(systemName: "play")
          .frame(width: 50, height: 50)
          .foregroundColor(.white)
          .overlay(Circle().stroke(Color.white, lineWidth: 2))
      })
    }.onAppear {
      self.takeSnapshot()
    }
    .background(Color.clear)
  }
  
  private func showTrailer() {
    guard let url = URL(string: videoUrl) else {
      return
    }
    let avPlayer = AVPlayer(url: url)
    let avController = AVPlayerViewController()
    avController.player = avPlayer
    viewControllerHolder?.present(avController, animated: true, completion: {
      avPlayer.play()
    })
  }
  
  private func takeSnapshot() {
    guard let vidURL = URL(string: videoUrl) else {
      return
    }
    if let loadedImage = loadedImage {
      self.image = loadedImage
      return
    }
    let asset = AVURLAsset(url: vidURL)
    let generator = AVAssetImageGenerator(asset: asset)
    generator.appliesPreferredTrackTransform = true
    
    let timestamp = CMTime(seconds: 3, preferredTimescale: 60)
    if let imageRef = try? generator.copyCGImage(at: timestamp, actualTime: nil) {
      self.loadedImage = UIImage(cgImage: imageRef)
      self.image = UIImage(cgImage: imageRef)
    }
  }
}

struct VideoView_Previews: PreviewProvider {
  static var previews: some View {
    VideoView(videoUrl: "")
  }
}
