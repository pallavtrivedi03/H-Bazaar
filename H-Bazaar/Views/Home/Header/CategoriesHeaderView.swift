//
//  CategoriesHeaderView.swift
//  H-Bazaar
//
//  Created by Pallav Trivedi on 03/04/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import UIKit

class CategoriesHeaderView: UIView {
    
    @IBOutlet weak var rankingHeaderCollectionView: UICollectionView!
    @IBOutlet weak var rankingProductsCollectionView: UICollectionView!
    
    var rankings: [Ranking]! {
        didSet {
            if rankings.count > 0 {
                rankingHeaderCollectionView.reloadData()
                //rankingProductsCollectionView.reloadData()
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
    }
    
}

extension CategoriesHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == rankingHeaderCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.ViewIdentifiers.rankingHeaderCell, for: indexPath) as? RankingHeaderCollectionViewCell
            var rank = ""
            let rankArray = (rankings[indexPath.row].ranking ?? "").capitalized.components(separatedBy: " ")
            rank = rankArray.count > 2 ? ((rankArray.first ?? "").appending(" \(rankArray[1])") ) : (rankings[indexPath.row].ranking ?? "")
            cell?.rankingNameLabel.text = rank
            if indexPath.row == selectedRankIndex {
                cell?.rankingNameLabel.font = UIFont(name: "MarkerFelt-Wide", size: 24)
                cell?.rankingNameLabel.textColor = .black
            } else {
                cell?.rankingNameLabel.font = UIFont(name: "MarkerFelt-Thin", size: 22)
                cell?.rankingNameLabel.textColor = .gray
            }
            return cell!
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRankIndex = indexPath.row
        rankingHeaderCollectionView.reloadData()
        //rankingProductsCollectionView.reloadData()
    }
}


extension CategoriesHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: AppConstants.ViewFrames.Width.rankingHeader, height: AppConstants.ViewFrames.Height.rankingHeader)
    }
}
