//
//  UIViewController + addSkillAlert.swift
//  ResumeTestTask
//
//  Created by Владимир Данилович on 1.08.23.
//

import UIKit

extension UIViewController {
  func presentSkillAlert(completion: @escaping ((String) -> ())) {
    let alert = UIAlertController(
      title: "Добавление навыка",
      message: "Введите название навыка которым вы владеете",
      preferredStyle: .alert
    )
    alert.addTextField { textField in
      textField.placeholder = "Введите название"
    }
    alert.addAction(.init(title: "Отмена", style: .cancel))
    alert.addAction(.init(title: "Добавить", style: .default) { _ in
        if let text = alert.textFields?.first?.text {
          completion(text)
        }
      })
    present(alert, animated: true)
  }
}
