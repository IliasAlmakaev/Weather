//
//  WeatherInfoViewController.swift
//  Weather
//
//  Created by Ilyas on 13.05.2025.
//

import UIKit

protocol WeatherInfoViewInputProtocol: AnyObject {
  
}

protocol WeatherInfoViewOutputProtocol {
  func viewDidLoad()
}

class WeatherInfoViewController: UIViewController {
  
  var presenter: WeatherInfoViewOutputProtocol!
  
  private let configuarator: WeatherInfoConfiguratorInputProtocol = WeatherInfoConfigurator()
  
  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumLineSpacing = 0
    flowLayout.minimumInteritemSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.register(WeatherInfoCell.self, forCellWithReuseIdentifier: WeatherInfoCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    configuarator.confugure(withView: self)
    setupUI()
    presenter.viewDidLoad()
  }

  private func setupUI() {
    view.backgroundColor = .white
    
    setupRefreshButton()
    setupCollectionView()
  }
  
  private func setupRefreshButton() {
    let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
    navigationItem.rightBarButtonItem = refreshButton
  }
  
  private func setupCollectionView() {
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      collectionView.heightAnchor.constraint(equalToConstant: 90)
    ])
  }
  
  @objc private func refreshButtonTapped() {
    
  }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension WeatherInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // TODO: - Add Weather info count
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherInfoCell.identifier, for: indexPath)
    guard let cell = cell as? WeatherInfoCell else { return UICollectionViewCell() }
    
    cell.updateView()
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 90, height: 90)
  }
}

// MARK: - WeatherInfoViewInputProtocol
extension WeatherInfoViewController: WeatherInfoViewInputProtocol {
  
}

