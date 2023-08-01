//
//  DescriptionView.swift
//  ResumeTestTask
//
//  Created by Владимир Данилович on 1.08.23.
//

import UIKit

final class DescriptionView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  //MARK: Subviews

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 16, weight: .medium)
    label.text = "О себе"
    return label
  }()

  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14)
    label.text = "Интересуюсь IOS разработкой, так как восхищен техникой Apple, которой постоянно пользуюсь. В данный момент получаю новые знания по это теме с помощью онлайн курса от SwiftBook, по материалам YouTube IOS Academy. Прошел срочную службу в ВС РБ. Женат, увлекаюсь спортивной рыбалкой."
    label.numberOfLines = 0
    return label
  }()

  private lazy var stackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
    stack.translatesAutoresizingMaskIntoConstraints = false
    addSubview(stack)
    stack.axis = .vertical
    stack.alignment = .leading
    stack.spacing = 8
    return stack
  }()
}

private extension DescriptionView {
  func setupConstraints() {
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])
  }
}
