//
//  HomeImageCell.swift
//  Headline
//
//  Created by libo on 2018/9/20.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit

class HomeImageCell: UICollectionViewCell,RegisterCellFromNib {

    @IBOutlet weak var imageView: UIImageView!
   
    var image = ImageList() {
        didSet {
            imageView.kf.setImage(with: URL(string: image.urlString))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
    }

}
