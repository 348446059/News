//
//  ChannelRecommendCel.swift
//  Headline
//
//  Created by libo on 2018/9/25.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit

class ChannelRecommendCell: UICollectionViewCell,RegisterCellFromNib  {
    @IBOutlet weak var titleButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        titleButton.theme_backgroundColor = "colors.cellBackgroundColor"
        titleButton.theme_setImage("images.add_channel_titlbar_thin_new_16x16_", forState: .normal)
        layer.cornerRadius = 3
        titleButton.layer.shadowColor = UIColor(r: 240, g: 240, b: 240).cgColor
        titleButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        titleButton.layer.shadowOpacity = 1
        titleButton.layer.shadowRadius = 1
        titleButton.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
}
