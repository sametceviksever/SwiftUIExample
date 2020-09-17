//
//  ViewControllerHolder.swift
//  SwıftUIExample
//
//  Created by Samet Çeviksever on 13.09.2020.
//  Copyright © 2020 Samet Çeviksever. All rights reserved.
//

import UIKit
import SwiftUI

struct ViewControllerHolder {
    weak var value: UIViewController?
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder {
        return ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

extension EnvironmentValues {
    var viewController: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}
