//
//  AppDelegate.swift
//  IDDog
//
//  Created by Marcos Lacerda on 24/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  private var applicationCoordinator: ApplicationCoordinator?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Initialize window
    initWindow()
    
    // Check if app re-instaled to clear keychain stored data
    clearKeychainIfNecessary()
    
    // Initialize main coordinator
    initCoordinator()
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {}

  func applicationDidEnterBackground(_ application: UIApplication) {}

  func applicationWillEnterForeground(_ application: UIApplication) {}

  func applicationDidBecomeActive(_ application: UIApplication) {}

  func applicationWillTerminate(_ application: UIApplication) {}

  // MARK: - Private methods
  
  fileprivate func clearKeychainIfNecessary() {
    if UserDefaults.read(key: "hasRunBefore") == nil {
      ApplicationSession.clearSession()
      UserDefaults.write(value: true, in: "hasRunBefore")
    }
  }
  
  fileprivate func initWindow() {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.backgroundColor = .white

    self.window = window
  }
  
  fileprivate func initCoordinator() {
    guard let window = self.window else {
      fatalError("Window not initialize")
    }

    let applicationCoordinator = ApplicationCoordinator(window: window)

    self.applicationCoordinator = applicationCoordinator

    applicationCoordinator.start()
  }

}
