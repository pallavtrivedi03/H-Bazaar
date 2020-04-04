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
    private var navigator: IHomeViewNavigator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigator = HomeViewNavigator(navigator: self.navigationController)
        
        homeViewModel.reload = {
            DispatchQueue.main.async { [weak self] in
                self?.setupViews()
            }
        }
        
        homeViewModel.error = { (errorType) in
            DispatchQueue.main.async { [weak self] in
                self?.showError(errorType: errorType)
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
    
    func showError(errorType: HBError) {
        
        var errorTitle = ""
        var errorMessage = ""
        
        switch errorType {
        case .parsingFailed:
            errorTitle = "Parsing Failed"
            errorMessage = "Received data in not in the expected format"
        case .retriesExhausted:
            errorTitle = "Data not available"
            errorMessage = "Please try after some time."
        }
        
        let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
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
        navigator?.showCategoryDetailView(category: category)
    }
}

extension HomeViewController: CategoriesHeaderViewDelegate {
    func didSelectProduct(product: Product) {
        navigator?.showProductDetailView(product: product)
    }
}
