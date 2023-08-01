//
//  MainViewController.swift
//  ResumeTestTask
//
//  Created by Владимир Данилович on 1.08.23.
//

import UIKit
import Combine

final class MainViewController: UIViewController {

  // MARK: Properties
  private var viewModel: MainViewModel!
  private var cancellable = Set<AnyCancellable>()

  // MARK: - Subviews

  private let scrollView = UIScrollView()

  private var scrollContent = UIView()

  private lazy var userInfoView: UserInfoView = {
    let user = UserInfoView()
    user.translatesAutoresizingMaskIntoConstraints = false
    return user
  }()

  private lazy var skillsView: SkillsView = {
    let skill = SkillsView()
    skill.translatesAutoresizingMaskIntoConstraints = false
    skill.onAdd = didTapAdd
    skill.onEdit = viewModel.toggleEditing
    skill.onDelete = viewModel.removeSkill(_:)
    return skill
  }()

  private lazy var descriptionView: DescriptionView = {
    let desc = DescriptionView()
    desc.translatesAutoresizingMaskIntoConstraints = false
    return desc
  }()

  // MARK: - Lifecycle
  init(viewModel: MainViewModel) {
    super.init(nibName: nil, bundle: nil)
    self.viewModel = viewModel
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  deinit {
    cancellable.forEach { $0.cancel() }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupConstraints()
    bind()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupUI()
  }
}

private extension MainViewController {
  func setupConstraints() {
    manageSubviews()

    // scrollView
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
      ])
    // scrollContent
    NSLayoutConstraint.activate([
      scrollContent.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
      scrollContent.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
      scrollContent.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
      scrollContent.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
      scrollContent.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
      scrollContent.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
      ])
    // userInfoView
    NSLayoutConstraint.activate([
      userInfoView.topAnchor.constraint(equalTo: scrollContent.topAnchor),
      userInfoView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
      userInfoView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
      userInfoView.heightAnchor.constraint(equalToConstant: 320)
      ])
    // skillsView
    NSLayoutConstraint.activate([
      skillsView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: 20),
      skillsView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: 16),
      skillsView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -16)
      ])
    NSLayoutConstraint.activate([
      descriptionView.topAnchor.constraint(equalTo: skillsView.bottomAnchor, constant: 24),
      descriptionView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: 16),
      descriptionView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -16),
      descriptionView.bottomAnchor.constraint(equalTo: scrollContent.bottomAnchor, constant: -20)
      ])
  }

  func manageSubviews() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollContent.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(scrollView)
    scrollView.addSubview(scrollContent)
    [
      userInfoView,
      skillsView,
      descriptionView
    ].forEach {
      scrollContent.addSubview($0)
    }
  }

  func setupUI() {
    title = "Профиль"
    view.backgroundColor = .white
  }

  func bind() {
    viewModel.$skillList
      .assign(to: \.skillsList, on: skillsView)
      .store(in: &cancellable)
    viewModel.$isEditing
      .assign(to: \.isEditing, on: skillsView)
      .store(in: &cancellable)
  }
}

// MARK: Action

private extension MainViewController {
  func didTapAdd() {
    presentSkillAlert() { [weak self] newSkill in
      self?.viewModel.addSkill(newSkill)
    }
  }
}
