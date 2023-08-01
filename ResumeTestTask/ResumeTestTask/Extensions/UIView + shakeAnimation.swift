//
//  UIView + shakeAnimation.swift
//  ResumeTestTask
//
//  Created by Владимир Данилович on 1.08.23.
//

import UIKit

extension UIView {
  var isShaking: Bool {
    layer.animation(forKey: "shake") != nil
  }

  func addShakeAnimation() {
    let animation = CABasicAnimation(keyPath: "shake")
    animation.duration = 0.07
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 2, y: self.center.y + 2))
    animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 2, y: self.center.y - 2))
    animation.repeatCount = 10000
    self.layer.add(animation, forKey: "shake")
  }
  func removeShakeAnimation() {
    layer.removeAnimation(forKey: "shake")
  }
}
