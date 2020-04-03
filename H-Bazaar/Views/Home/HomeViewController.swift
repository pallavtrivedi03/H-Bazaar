//
//  HomeViewController.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 02/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    
    private var categoriesHeaderView: CategoriesHeaderView?
    
    private let homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeViewModel.reload = {
            DispatchQueue.main.async { [weak self] in
                self?.loadingView.isHidden = true
                self?.categoriesTableView.isHidden = false
                self?.setupHeaderView()
            }
        }
        
        homeViewModel.fetchDataFromDB()
    }

    func setupHeaderView() {
        categoriesHeaderView = Bundle.main.loadNibNamed(AppConstants.ViewIdentifiers.categoriesHeaderView, owner: self, options: nil)?[0] as? CategoriesHeaderView
        categoriesHeaderView?.frame = CGRect(x: 0, y: 0, width: Int(AppConstants.ViewFrames.Width.categoriesHeader), height: AppConstants.ViewFrames.Height.categoriesHeader)
        categoriesHeaderView?.registerCollectionViewCells()
        categoriesTableView.tableHeaderView = categoriesHeaderView
        categoriesHeaderView?.rankings = homeViewModel.rankings
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
