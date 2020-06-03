//
//  LunchViewController.swift
//  Bottle Rocket
//
//  Created by Subhankar Ghosh on 28/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import UIKit

class LunchViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var lunchViewModel: LunchViewModel?
    let cellIdentifier = "restaurantCollectionViewCell"
    
    private lazy var collectionViewFlowLayout: CustomCollectionViewFlowLayout = {
        let layout = CustomCollectionViewFlowLayout(display: .list, containerWidth: view.bounds.width, lineSpace: 0, interItemSpace: 0)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = self.collectionViewFlowLayout
        displayAnimatedActivityIndicatorView()
        setUpNavigationBar()
        lunchViewModel = LunchViewModel()
        getData()
    }
    
    func setUpNavigationBar() {
        navigationItem.title = Strings.ControllerTitle.lunchTyme
        let rightBarItem = UIBarButtonItem(image: UIImage(named: "map-marker"), style: .plain, target: self, action: #selector(mapMarkerButtonTapped))
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureCollectionViewFlowLayout(self.view.bounds.size.width)
    }
    
    func getData() {
        lunchViewModel?.reloadCollection = {
            DispatchQueue.main.async {
                self.hideAnimatedActivityIndicatorView()
                self.collectionView.reloadData()
            }
        }
    }
    
    private func configureCollectionViewFlowLayout(_ width: CGFloat) {
        collectionView.collectionViewLayout = self.collectionViewFlowLayout
        collectionViewFlowLayout.containerWidth = width
        if UIDevice.current.userInterfaceIdiom == .pad {
            collectionViewFlowLayout.display = .grid(columns: 2)
            return
        }
        //iPhone
        collectionViewFlowLayout.display = CollectionDisplay.list
    }
    
    @objc func mapMarkerButtonTapped() {
        if let mapVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: Strings.ViewControllerIdentifier.mapViewController) as? MapViewController {
            mapVC.restaurantDetails = lunchViewModel?.restaurentData
            let backItem = UIBarButtonItem()
            backItem.title = Strings.ControllerTitle.lunchTyme
            navigationItem.backBarButtonItem = backItem
            navigationController?.present(mapVC, animated: true)
        }
    }
}

extension LunchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = lunchViewModel?.restaurentData?.data.count, count > 0 {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? RestaurantCollectionViewCell {
            if let data = lunchViewModel?.restaurentData?.data[indexPath.row] {
                cell.imageCache = lunchViewModel?.imageCache
                cell.configureData(data: data)
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let restaurantDetailVC = mainStoryboard.instantiateViewController(identifier: Strings.ViewControllerIdentifier.restaurantDetailViewController) as? RestaurantDetailViewController, let data = lunchViewModel?.restaurentData?.data[indexPath.row] {
            restaurantDetailVC.restaurantInformation = data
            restaurantDetailVC.allRestaurantsData = lunchViewModel?.restaurentData
            navigationController?.pushViewController(restaurantDetailVC, animated: true)
        }
    }
}


