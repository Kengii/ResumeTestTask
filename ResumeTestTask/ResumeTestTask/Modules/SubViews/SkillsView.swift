//
//  SkillsView.swift
//  ResumeTestTask
//
//  Created by Владимир Данилович on 1.08.23.
//

import UIKit

final class SkillsView: UIView {
  private typealias DataSource = UICollectionViewDiffableDataSource<Int, String>

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
    makeDataSource()
    applySnapshot()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  var onEdit: (() -> ())?
  var onAdd: (() -> ())?
  var onDelete: ((String) -> ())?

  var skillsList: [String] = [] {
    didSet {
      makeDataSource()
      applySnapshot()
    }
  }

  var isEditing: Bool = false {
    didSet {
      makeDataSource()
      applySnapshot()
      editButton.setImage(isEditing ? UIImage(named: "done") : UIImage(named: "pencil"), for: .normal)
    }
  }

  private var dataSource: DataSource?

  // MARK: Subviews
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    label.text = "Мои навыки"
    return label
  }()

  private lazy var editButton: UIButton = {
    let action = UIAction { _ in self.didTapEdit() }
    let button = UIButton(type: .system, primaryAction: action)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    button.setImage(UIImage(named: "pencil"), for: .normal)
    button.tintColor = .black
    return button
  }()

  private lazy var editStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [titleLabel, editButton])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .horizontal
    stack.distribution = .fill
    addSubview(stack)
    return stack
  }()

  private lazy var skillsCollectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.estimatedItemSize = .init(width: 120, height: 44)
    flowLayout.minimumInteritemSpacing = 12
    flowLayout.minimumLineSpacing = 12
    let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collection.translatesAutoresizingMaskIntoConstraints = false
    addSubview(collection)
    collection.delegate = self
    collection.register(SkillItemCell.self, forCellWithReuseIdentifier: SkillItemCell
        .reuseIdentifier)

    return collection
  }()
}

// MARK: Extansions
private extension SkillsView {
  func setupConstraints() {
    NSLayoutConstraint.activate([
      editStack.topAnchor.constraint(equalTo: topAnchor),
      editStack.leadingAnchor.constraint(equalTo: leadingAnchor),
      editStack.trailingAnchor.constraint(equalTo: trailingAnchor)
      ])

    NSLayoutConstraint.activate([
      skillsCollectionView.topAnchor.constraint(equalTo: editStack.bottomAnchor, constant: 16),
      skillsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      skillsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      skillsCollectionView.heightAnchor.constraint(equalToConstant: 215)
      ])
  }

  func makeDataSource() {
    dataSource = .init(collectionView: skillsCollectionView) { [weak self] collectionView, indexPath, skill in
      guard let self else { return UICollectionViewCell() }
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SkillItemCell.reuseIdentifier, for: indexPath) as? SkillItemCell
      cell?.onDelete = onDelete
      cell?.isEditing = self.isEditing
      cell?.setup(with: skill)
      return cell
    }
  }

  func applySnapshot() {
    guard let dataSource else { return }
    var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
    snapshot.appendSections([0])
    snapshot.appendItems(skillsList, toSection: 0)
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

private extension SkillsView {
  func didTapEdit() {
    onEdit?()
    if isEditing {
      addShakeAnimation()
    } else {
      removeShakeAnimation()
    }
  }
}

extension SkillsView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard skillsList[indexPath.row] == "+" else { return }
    collectionView.deselectItem(at: indexPath, animated: true)
    onAdd?()
  }
}
