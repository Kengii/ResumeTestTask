//
//  Coordinator.swift
//  ResumeTestTask
//
//  Created by Владимир Данилович on 1.08.23.
//

import UIKit

protocol Coordinator {
  var parentCoordinator: Coordinator? { get set }
  var rootViewController: UIViewController? { get set }

  func start()
}
