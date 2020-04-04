//
//  CategoryTableViewCell.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 04/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    var categories: [Category]! {
        didSet {
            if categories.count > 0 {
                let rowsCount = (categories.count % 2 == 0) ? (categories.count/2) : (categories.count/2) + 1
                let padding = rowsCount * 12
                collectionViewHeightConstraint.constant = CGFloat(rowsCount * AppConstants.ViewFrames.Height.categoryCell) + CGFloat(padding)
                categoriesCollectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoriesCollectionView.register(UINib(nibName: AppConstants.ViewIdentifiers.categoryCollectionCell, bundle: nil), forCellWithReuseIdentifier: AppConstants.ViewIdentifiers.categoryCollectionCell)
    }
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.ViewIdentifiers.categoryCollectionCell, for: indexPath) as? CategoryCollectionViewCell
        cell?.backgroundColor = .random
        cell?.categoryTitleLabel.text = categories[indexPath.row].name ?? ""
        cell?.layer.cornerRadius = 8
        cell?.clipsToBounds = true
        return cell!
    }
}

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: AppConstants.ViewFrames.Width.categoryCell, height: CGFloat(AppConstants.ViewFrames.Height.categoryCell))
    }
}
