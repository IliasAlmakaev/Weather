//
//  WeatherInfoViewController.swift
//  Weather
//
//  Created by Ilyas on 13.05.2025.
//

import UIKit
import SDWebImage

protocol WeatherInfoViewInputProtocol: AnyObject {
  func getWeatherInfo(
    forCurrentView currentWeatherInfoViewModel: CurrentWeatherInfoViewViewModel,
    collectionViewRows: [WeatherHourInfoCellViewModel],
    andTableViewRow tableViewRows: [WeatherDayInfoCellViewModel]
  )
}

protocol WeatherInfoViewOutputProtocol {
  func viewDidLoad()
}

class WeatherInfoViewController: UIViewController {
  
  var presenter: WeatherInfoViewOutputProtocol!
  
  private let configuarator: WeatherInfoConfiguratorInputProtocol = WeatherInfoConfigurator()
  
  private lazy var currentWeatherInfoView: CurrentWeatherInfoView = {
    let currentWeatherInfoView = CurrentWeatherInfoView()
    currentWeatherInfoView.translatesAutoresizingMaskIntoConstraints = false
    return currentWeatherInfoView
  }()
  
  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumLineSpacing = 0
    flowLayout.minimumInteritemSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.register(WeatherHourInfoCell.self, forCellWithReuseIdentifier: WeatherHourInfoCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(WeatherDayInfoCell.self, forCellReuseIdentifier: WeatherDayInfoCell.identifier)
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  private var hourRows: [WeatherHourInfoCellViewModel] = []
  private var dayRows: [WeatherDayInfoCellViewModel] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    configuarator.confugure(withView: self)
    setupUI()
    presenter.viewDidLoad()
  }

  private func setupUI() {
    view.backgroundColor = .white
    
    setupRefreshButton()
    setupCurrentWeatherInfoView()
    setupCollectionView()
    setupTableView()
  }
  
  private func setupRefreshButton() {
    let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
    navigationItem.rightBarButtonItem = refreshButton
  }
  
  private func setupCurrentWeatherInfoView() {
    view.addSubview(currentWeatherInfoView)
    NSLayoutConstraint.activate([
      currentWeatherInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      currentWeatherInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      currentWeatherInfoView.heightAnchor.constraint(equalToConstant: 130)
    ])
  }
  
  private func setupCollectionView() {
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: currentWeatherInfoView.bottomAnchor, constant: 40),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      collectionView.heightAnchor.constraint(equalToConstant: 110)
    ])
  }
  
  private func setupTableView() {
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
    ])
  }
  
  @objc private func refreshButtonTapped() {
    
  }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension WeatherInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return hourRows.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cellViewModel = hourRows[indexPath.row]
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellIdentifier, for: indexPath)
    guard let cell = cell as? WeatherHourInfoCell else { return UICollectionViewCell() }
    
    cell.viewModel = cellViewModel
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellViewModel = hourRows[indexPath.row]
    return CGSize(width: cellViewModel.cellHeight, height: cellViewModel.cellHeight)
  }
}

// MARK: - UITableViewDataSource
extension WeatherInfoViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dayRows.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellViewModel = dayRows[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellIdentifier, for: indexPath)
    guard let cell = cell as? WeatherDayInfoCell else { return UITableViewCell() }
    
    cell.viewModel = cellViewModel
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension WeatherInfoViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let cellViewModel = dayRows[indexPath.row]
    return cellViewModel.cellHeight
  }
}

// MARK: - WeatherInfoViewInputProtocol
extension WeatherInfoViewController: WeatherInfoViewInputProtocol {
  func getWeatherInfo(
    forCurrentView currentWeatherInfoViewModel: CurrentWeatherInfoViewViewModel,
    collectionViewRows: [WeatherHourInfoCellViewModel],
    andTableViewRow tableViewRows: [WeatherDayInfoCellViewModel]
  ) {
    currentWeatherInfoView.viewModel = currentWeatherInfoViewModel
    
    self.hourRows = collectionViewRows
    collectionView.reloadData()
    
    self.dayRows = tableViewRows
    tableView.reloadData()
  }

}

