//
//  MainViewModel.swift
//  ResumeTestTask
//
//  Created by Владимир Данилович on 1.08.23.
//

import SwiftUI

final class MainViewModel: ViewModel {
  init(coordinator: Coordinator) {
    self.coordinator = coordinator as! MainCoordinator
  }

  private let coordinator: MainCoordinator
}
