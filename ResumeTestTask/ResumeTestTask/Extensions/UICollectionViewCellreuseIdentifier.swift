//
//  UICollectionViewCellreuseIdentifier.swift
//  ResumeTestTask
//
//  Created by Владимир Данилович on 1.08.23.
//

import UIKit

extension UICollectionViewCell {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
