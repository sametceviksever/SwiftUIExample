//
//  UIViewController+SwiftUI.swift
//  SwıftUIExample
//
//  Created by Samet Çeviksever on 13.09.2020.
//  Copyright © 2020 Samet Çeviksever. All rights reserved.
//

import UIKit
import SwiftUI

extension UIViewController {
  func present<Content: View>(style: UIModalPresentationStyle = .fullScreen,
                              transitionStyle: UIModalTransitionStyle = .coverVertical,
                              @ViewBuilder builder: () -> Content) {
    let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
    toPresent.modalPresentationStyle = style
    toPresent.modalTransitionStyle = transitionStyle
    toPresent.view.backgroundColor = .clear
    toPresent.rootView = AnyView(builder().environment(\.viewController, toPresent))
    self.present(toPresent, animated: true, completion: nil)
  }
}

