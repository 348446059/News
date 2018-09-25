//
//  TheyUseCollectionCell.swift
//  Headline
//
//  Created by libo on 2018/9/19.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit
import Kingfisher
import IBAnimatable

class TheyUseCollectionCell: UICollectionViewCell,RegisterCellFromNib {

    @IBOutlet weak var vipImageView: UIImageView!
    
    @IBOutlet weak var avatarImageView: AnimatableImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var concernButton: AnimatableButton!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var loadingImageView: UIImageView!
    
    var userCard = UserCard(){
        didSet{
            avatarImageView.kf.setImage(with: URL(string: userCard.user.info.avatar_url)!)
            nameLabel.text = userCard.user.info.name
            subtitleLabel.text = userCard.recommend_reason
            vipImageView.isHidden = userCard.user.info.user_auth_info.auth_info == ""
        }
    }
    
    private lazy var animation :CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0.0
        animation.toValue = Double.pi * 2
        animation.duration = 1.5
        animation.autoreverses = false
        animation.repeatCount = MAXFLOAT
       return animation
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.theme_borderColor = "colors.lightGray"
        layer.borderWidth = 1
        theme_backgroundColor = "colors.cellBackgroundColor"
        closeButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonTextColor", forState: .normal)
       concernButton.theme_setTitleColor("colors.userDetailConcernButtonSelectedTextColor", forState: .selected)
    }
    
    
    @IBAction func closeAction(_ sender: AnimatableButton) {
        loadingImageView.isHidden = false
        loadingImageView.layer.add(animation, forKey: nil)
        if sender.isSelected { //已经关注 点击则取消关注
            //已关注的用户 取消关注
            
        }
    }
    
    @IBAction func concernBtnClick(_ sender: Any) {
    }
    
}
