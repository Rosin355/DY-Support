//
//  AppDelegate.swift
//  Telar
//
//  Created by Romesh Singhabahu on 14/07/22.
//

import Foundation
import UIKit
import FirebaseCore


class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
                   [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
