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
    private var navigator: HomeViewNavigator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigator = HomeViewNavigator(homeView: self)
        
        homeViewModel.reload = {
            DispatchQueue.main.async { [weak self] in
                self?.setupViews()
            }
        }
        
        categoriesTableView.register(UINib(nibName: AppConstants.ViewIdentifiers.categoryTableViewCell, bundle: nil), forCellReuseIdentifier: AppConstants.ViewIdentifiers.categoryTableViewCell)
        homeViewModel.fetchDataFromDB()
    }
    
    func setupViews() {
        loadingView.isHidden = true
        categoriesTableView.isHidden = false
        
        categoriesTableView.rowHeight = UITableView.automaticDimension
        setupHeaderView()
        categoriesTableView.reloadData()
    }
    
    func setupHeaderView() {
        categoriesHeaderView = Bundle.main.loadNibNamed(AppConstants.ViewIdentifiers.categoriesHeaderView, owner: self, options: nil)?[0] as? CategoriesHeaderView
        categoriesHeaderView?.frame = CGRect(x: 0, y: 0, width: Int(AppConstants.ViewFrames.Width.categoriesHeader), height: AppConstants.ViewFrames.Height.categoriesHeader)
        categoriesHeaderView?.registerCollectionViewCells()
        categoriesHeaderView?.delegate = self
        categoriesTableView.tableHeaderView = categoriesHeaderView
        categoriesTableView.tableFooterView = UIView()
        categoriesHeaderView?.rankings = homeViewModel.rankings
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.ViewIdentifiers.categoryTableViewCell, for: indexPath) as? CategoryTableViewCell
        cell?.categories = homeViewModel.parentCategories
        cell?.delegate = self
        return cell!
    }
}

extension HomeViewController: CategoryTableViewCellDelegate {
    func didClickOnCategory(category: Category) {
        let categoryDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: AppConstants.ViewIdentifiers.categoryDetailVC) as? CategoryDetailViewController
        categoryDetailVC?.categoryViewModel.category = category
        navigator?.showCategoryDetailView(categoryView: categoryDetailVC!)
    }
}

extension HomeViewController: CategoriesHeaderViewDelegate {
    func didSelectProduct(product: Product) {
        let productDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: AppConstants.ViewIdentifiers.productDetailVC) as? ProductDetailViewController
        productDetailVC?.productDetailViewModel.product = product
        navigator?.showProductDetailView(productDetailView: productDetailVC!)
    }
}
