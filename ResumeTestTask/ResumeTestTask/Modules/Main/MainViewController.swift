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
  }

  override func viewDidLayoutSubviews() {
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
      userInfoView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
      userInfoView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
      userInfoView.heightAnchor.constraint(equalToConstant: 320)
    ])

    }

    func manageSubviews() {
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      scrollContent.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(scrollView)
      scrollView.addSubview(scrollContent)

      [
        userInfoView
      ].forEach {
        scrollContent.addSubview($0)
      }
    }

    func setupUI() {
      title = "Профиль"
      view.backgroundColor = .white
    }
  }
