//
//  SkillsItemCell.swift
//  ResumeTestTask
//
//  Created by Владимир Данилович on 1.08.23.
//

import UIKit

final class SkillItemCell: UICollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
    setupUI()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    nameLabel.text = nil
    deleteButton.isHidden = true
  }

  var onDelete: ((String) -> ())?
  var isEditing: Bool = false

  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14)
    return label
  }()

  private lazy var deleteButton: UIButton = {
    let action = UIAction { _ in self.didTapDeleteButton() }
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "xmark"), for: .normal)
    button.tintColor = .black
    return button
  }()

  private lazy var stackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [nameLabel, deleteButton])
    stack.axis = .horizontal
    stack.distribution = .fill
    stack.spacing = 10
    stack.translatesAutoresizingMaskIntoConstraints = false
    addSubview(stack)
    return stack
  }()

  func setup(with skill: String) {
    nameLabel.text = skill
    if skill == "+" {
      return
    }
    if isEditing {
      deleteButton.isHidden = false
      addShakeAnimation()
    } else {
      deleteButton.isHidden = true
      removeShakeAnimation()
    }
  }
}

// MARK: Extensions
private extension SkillItemCell {
  func setupConstraints() {
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
      ])
    NSLayoutConstraint.activate([
      deleteButton.widthAnchor.constraint(equalToConstant: 16),
      deleteButton.heightAnchor.constraint(equalToConstant: 16)
      ])

  }
  func setupUI() {
    backgroundColor = #colorLiteral(red: 0.9529408813, green: 0.9529413581, blue: 0.9615501761, alpha: 1)
    layer.cornerRadius = 12
  }
}


// MARK: Action
private extension SkillItemCell {
  func didTapDeleteButton() {
    guard let skill = nameLabel.text else { return }
    onDelete?(skill)
  }
}
