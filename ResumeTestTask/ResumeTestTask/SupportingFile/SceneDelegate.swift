//
//  SceneDelegate.swift
//  ResumeTestTask
//
//  Created by Владимир Данилович on 1.08.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  var appCoordinator: Coordinator?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene = (scene as? UIWindowScene) else { return }
    self.window = UIWindow(windowScene: windowScene)

    appCoordinator = AppCoordinator()
    appCoordinator?.start()

    if let root = appCoordinator?.rootViewController {
      replaceRoot(viewController: root)
    }
  }
  private func replaceRoot(viewController: UIViewController) {
    window?.rootViewController = viewController
    window?.makeKeyAndVisible()
  }
}
