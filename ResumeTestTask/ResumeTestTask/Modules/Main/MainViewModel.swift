//
//  MainViewModel.swift
//  ResumeTestTask
//
//  Created by Владимир Данилович on 1.08.23.
//

import SwiftUI
import Combine

final class MainViewModel: ViewModel {
  init(coordinator: Coordinator) {
    self.coordinator = coordinator as! MainCoordinator
  }

  private let coordinator: MainCoordinator

  @Published private(set) var skillList: [String] = ["MVVM", "Combine"]
  @Published private(set) var isEditing: Bool = false

  func addSkill(_ skill: String) {
    guard !skillList.contains(skill) else { return }
    if let plusIndex = skillList.firstIndex(of: "+") {
      skillList.insert(skill, at: plusIndex)
    } else {
      skillList.append(skill)
    }
  }

  func removeSkill(_ skill: String) {
    guard skillList.contains(skill),
      let index = skillList.firstIndex(of: skill)
      else { return }

    skillList.remove(at: index)
  }

  func toggleEditing() {
    isEditing.toggle()
    if isEditing {
      addSkill("+")
    } else if skillList.contains("+") {
      removeSkill("+")
    }
  }
}
