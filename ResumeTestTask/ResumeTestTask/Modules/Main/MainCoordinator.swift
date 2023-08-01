//
//  MainCoordinator.swift
//  ResumeTestTask
//
//  Created by Владимир Данилович on 1.08.23.
//

import UIKit

final class MainCoordinator: Coordinator {
  var rootViewController: UIViewController?
  var parentCoordinator: Coordinator?

  func start() {
    let vm = MainViewModel(coordinator: self)
    let view = MainViewController(viewModel: vm)
    rootViewController = UINavigationController(rootViewController: view)
  }
}
