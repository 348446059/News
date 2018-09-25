//
//  HomeImageCollectionView.swift
//  Headline
//
//  Created by libo on 2018/9/20.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit

class HomeImageCollectionView: UICollectionView,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,NibLoadable {
    
    var images = [ImageList](){
        didSet{
            reloadData()
        }
    }
    
    var didSelect :((_ selectedIndex:Int)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewLayout = DongtaiCollectionViewFlowLayout()
        lb_registerCell(cell: HomeImageCell.self)
        delegate = self
        dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.lb_dequeueReusableCell(indexPath: indexPath) as HomeImageCell
        cell.image = images[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: image3Width, height: image3Width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect?(indexPath.item)
    }
    
}

class DongtaiCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        minimumLineSpacing = 5
        minimumInteritemSpacing = 5
    }
}
