//
//  CategoriesHeaderView.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 03/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import UIKit

protocol CategoriesHeaderViewDelegate : class {
    func didSelectProduct(product: Product)
}

class CategoriesHeaderView: UIView {
    
    @IBOutlet weak var rankingHeaderCollectionView: UICollectionView!
    @IBOutlet weak var rankingProductsCollectionView: UICollectionView!
    
    weak var delegate: CategoriesHeaderViewDelegate?
    var rankings: [Ranking]! {
        didSet {
            if rankings.count > 0 {
                rankingHeaderCollectionView.reloadData()
                rankingProductsCollectionView.reloadData()
                
            }
        }
    }
    
    var selectedRankIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func registerCollectionViewCells()  {
        rankingHeaderCollectionView.register(UINib(nibName: AppConstants.ViewIdentifiers.rankingHeaderCell, bundle: nil), forCellWithReuseIdentifier: AppConstants.ViewIdentifiers.rankingHeaderCell)
        rankingProductsCollectionView.register(UINib(nibName: AppConstants.ViewIdentifiers.productCell, bundle: nil), forCellWithReuseIdentifier: AppConstants.ViewIdentifiers.productCell)
    }
    
    func getSubtitleString(index: Int) -> String {
        guard let products = rankings[selectedRankIndex].products?.allObjects as? [Product] else {
            return ""
        }
        
        switch selectedRankIndex {
        case 0:
            return "\(products[index].orders) orders"
        case 1:
            return "\(products[index].shares) shares"
        case 2:
            return "\(products[index].views) views"
        default:
            return ""
        }
    }
}

extension CategoriesHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == rankingHeaderCollectionView ? rankings.count : rankings[selectedRankIndex].products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == rankingHeaderCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.ViewIdentifiers.rankingHeaderCell, for: indexPath) as? RankingHeaderCollectionViewCell else {
                return UICollectionViewCell()
            }
            var rank = ""
            let rankArray = (rankings[indexPath.row].ranking ?? "").capitalized.components(separatedBy: " ")
            rank = rankArray.count > 2 ? ((rankArray.first ?? "").appending(" \(rankArray[1])") ) : (rankings[indexPath.row].ranking ?? "")
            cell.rankingNameLabel.text = rank
            if indexPath.row == selectedRankIndex {
                cell.rankingNameLabel.font = UIFont(name: "MarkerFelt-Wide", size: 24)
                cell.rankingNameLabel.textColor = .black
            } else {
                cell.rankingNameLabel.font = UIFont(name: "MarkerFelt-Thin", size: 22)
                cell.rankingNameLabel.textColor = .gray
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.ViewIdentifiers.productCell, for: indexPath) as? ProductCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let products = rankings[selectedRankIndex].products?.allObjects as? [Product] {
                cell.productPlaceholderView.backgroundColor = .random
                cell.productTitleLabel.text = products[indexPath.row].name ?? ""
                cell.productSubtitleLabel.text = getSubtitleString(index: indexPath.row)
                return cell
            }            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == rankingHeaderCollectionView {
            selectedRankIndex = indexPath.row
            rankingHeaderCollectionView.reloadData()
            rankingProductsCollectionView.reloadData()
            let scrollRect = CGRect(x: 0, y: rankingProductsCollectionView.frame.origin.y, width: rankingProductsCollectionView.frame.width, height: rankingProductsCollectionView.frame.height)
            rankingProductsCollectionView.scrollRectToVisible(scrollRect, animated: true)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else {
            if let products = rankings[selectedRankIndex].products?.allObjects as? [Product] {
                delegate?.didSelectProduct(product: products[indexPath.row])
            }
        }
    }
}


extension CategoriesHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView == rankingHeaderCollectionView ? CGSize(width: AppConstants.ViewFrames.Width.rankingHeader, height: AppConstants.ViewFrames.Height.rankingHeader) : CGSize(width: AppConstants.ViewFrames.Width.product, height: AppConstants.ViewFrames.Height.product)
    }
}
