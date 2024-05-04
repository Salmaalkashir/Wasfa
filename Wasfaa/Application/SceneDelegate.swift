//
//  SceneDelegate.swift
//  Wasfaa
//
//  Created by Salma on 28/04/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = UINavigationController(rootViewController: HomeViewController())
    window.makeKeyAndVisible()
    
    self.window = window
  }
}
