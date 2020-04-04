//
//  CategoryDetailViewController.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 04/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import UIKit

class CategoryDetailViewController: UIViewController {
    
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var subCategoriesCollectionView: UICollectionView!
    let categoryViewModel = CategoryViewModel()
    
    var selectedParentCategoryIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryViewModel.category?.name ?? ""
        registerCollectionViewCells()
        subCategoriesCollectionView.reloadData()
        productCollectionView.reloadData()
        updateFilterButton()
    }
    
    func registerCollectionViewCells()  {
        subCategoriesCollectionView.register(UINib(nibName: AppConstants.ViewIdentifiers.rankingHeaderCell, bundle: nil), forCellWithReuseIdentifier: AppConstants.ViewIdentifiers.rankingHeaderCell)
        productCollectionView.register(UINib(nibName: AppConstants.ViewIdentifiers.productCell, bundle: nil), forCellWithReuseIdentifier: AppConstants.ViewIdentifiers.productCell)
    }
    
    func updateFilterButton() {
        filterButton.setTitle((categoryViewModel.grandChildCategory?.name ?? "").appending(" ▼"), for: .normal)
    }
    
    @IBAction func didClickOnFilterButton(_ sender: Any) {
        weak var weakSelf = self
        let actionSheet = UIAlertController(title: categoryViewModel.childCategory?.name ?? "", message: "", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        for grandChild in categoryViewModel.grandChildren {
            let action = UIAlertAction(title: grandChild.name ?? "", style: .default) { (action) in
                let selectedCategory = weakSelf?.categoryViewModel.grandChildren.first{ $0.name == action.title}
                weakSelf?.categoryViewModel.grandChildCategory = selectedCategory
                weakSelf?.productCollectionView.reloadData()
                weakSelf?.updateFilterButton()
            }
            actionSheet.addAction(action)
        }
        
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}

extension CategoryDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == subCategoriesCollectionView {
            return categoryViewModel.category?.childCategories?.count ?? 0
        } else {
            return categoryViewModel.grandChildCategory?.products?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == subCategoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.ViewIdentifiers.rankingHeaderCell, for: indexPath) as? RankingHeaderCollectionViewCell
            if let subCategoriesIndex = categoryViewModel.category?.childCategories?.allObjects as? [ChildCategory] {
                if let category = categoryViewModel.getCategory(id: subCategoriesIndex[indexPath.row].id) {
                    cell?.rankingNameLabel.text = category.name ?? ""
                    if indexPath.row == selectedParentCategoryIndex {
                        cell?.rankingNameLabel.font = UIFont(name: "MarkerFelt-Wide", size: 24)
                        cell?.rankingNameLabel.textColor = .black
                    } else {
                        cell?.rankingNameLabel.font = UIFont(name: "MarkerFelt-Thin", size: 22)
                        cell?.rankingNameLabel.textColor = .gray
                    }
                    return cell!
                }
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.ViewIdentifiers.productCell, for: indexPath) as? ProductCollectionViewCell
            
            if let products = categoryViewModel.grandChildCategory?.products?.allObjects as? [Product] {
                cell?.productPlaceholderView.backgroundColor = .random
                cell?.productTitleLabel.text = products[indexPath.row].name ?? ""
                cell?.productSubtitleLabel.text = ""
                return cell!
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == subCategoriesCollectionView {
            selectedParentCategoryIndex = indexPath.row
            categoryViewModel.updateChildren(childIndex: selectedParentCategoryIndex, grandChild: 0)
            updateFilterButton()
            subCategoriesCollectionView.reloadData()
            productCollectionView.reloadData()
            productCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else {
            //TOOD: Open product detail screen
        }
    }
    
}

extension CategoryDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == subCategoriesCollectionView {
            return CGSize(width: AppConstants.ViewFrames.Width.rankingHeader, height: AppConstants.ViewFrames.Height.rankingHeader)
        }
        else {
            return CGSize(width: AppConstants.ViewFrames.Width.categoryProduct, height: AppConstants.ViewFrames.Height.categoryProduct)
        }
    }
}
