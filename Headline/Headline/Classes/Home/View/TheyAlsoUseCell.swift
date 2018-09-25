//
//  TheyAlsoUseCell.swift
//  Headline
//
//  Created by libo on 2018/8/1.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit

class TheyAlsoUseCell: UITableViewCell,RegisterCellFromNib {
    
    @IBOutlet weak var leftBtn: UIButton!
    
    @IBOutlet weak var rightBtn: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var bottomView: UIView!
    
    var userCards = [UserCard]()
    
    
    var theyUse = SmallVideo(){
        didSet {
            leftBtn.titleLabel?.text = theyUse.title
            rightBtn.setTitle(theyUse.show_more, for: .normal)
            userCards = theyUse.user_cards
            collectionView.reloadData()
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        bottomView.theme_backgroundColor = "colors.separatorViewColor"
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(5, 15, 10, 10)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 170 * ratio, height: 215 * ratio)
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    
}

extension TheyAlsoUseCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.lb_dequeueReusableCell(indexPath: indexPath) as TheyUseCollectionCell
        cell.userCard = userCards[indexPath.item]
        return cell
    }
    
    
}
