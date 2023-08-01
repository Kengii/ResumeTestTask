//
//  AppCoordinator.swift
//  ResumeTestTask
//
//  Created by Владимир Данилович on 1.08.23.
//

import UIKit

final class AppCoordinator: Coordinator {
  var rootViewController: UIViewController?
  var parentCoordinator: Coordinator?

  func start() {
    let mainCoordinator = MainCoordinator()
    mainCoordinator.parentCoordinator = self
    mainCoordinator.start()
    rootViewController = mainCoordinator.rootViewController
  }
}
