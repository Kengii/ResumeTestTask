//
//  UserInfoView.swift
//  ResumeTestTask
//
//  Created by Владимир Данилович on 1.08.23.
//

import UIKit

final class UserInfoView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    setupUI()
  }

  // MARK: - SubViews

  private lazy var profileImageView: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.image = UIImage(named: "Photo")
    image.contentMode = .scaleAspectFill
    addSubview(image)
    return image
  }()

  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .boldSystemFont(ofSize: 24)
    label.text = "Данилович Владимир Олегович"
    label.numberOfLines = 2
    addSubview(label)
    return label
  }()

  private lazy var professionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14)
    label.textColor = .darkGray
    label.text = "Junior iOS developer; опыт 4 месяца"
    addSubview(label)
    return label
  }()

  private lazy var locationLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    let pinAttachment = NSAttributedString(attachment: NSTextAttachment(image: UIImage(named: "location_pin") ?? UIImage()))
    let city = "Минск"
    let attributedString = NSMutableAttributedString()
    attributedString.append(pinAttachment)
    attributedString.append(.init(string: city))
    attributedString.addAttributes([
        .foregroundColor: UIColor.darkGray,
        .font: UIFont.systemFont(ofSize: 14),
        .baselineOffset: 10
      ], range: .init(location: 0, length: attributedString.length))
    label.attributedText = attributedString
    addSubview(label)
    return label
  }()
}

private extension UserInfoView {
  func setupConstraints() {
    // profileImageView
    NSLayoutConstraint.activate([
      profileImageView.widthAnchor.constraint(equalToConstant: 120),
      profileImageView.heightAnchor.constraint(equalToConstant: 120),
      profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
      profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
      ])
    // nameLabel
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
      nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
    // professionLabel
    NSLayoutConstraint.activate([
      professionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
      professionLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
    // locationLabel
    NSLayoutConstraint.activate([
      locationLabel.topAnchor.constraint(equalTo: professionLabel.bottomAnchor, constant: 2),
      locationLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }

  func setupUI() {
    backgroundColor = #colorLiteral(red: 0.9529408813, green: 0.9529413581, blue: 0.9615501761, alpha: 1)
    profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    profileImageView.clipsToBounds = true
  }
}
