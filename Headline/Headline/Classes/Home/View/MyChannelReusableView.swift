//
//  MyChannelReusableView.swift
//  Headline
//
//  Created by libo on 2018/9/25.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit

class MyChannelReusableView: UICollectionReusableView,RegisterCellFromNib {
    @IBOutlet weak var subtitleLabel: UIButton!
    @IBOutlet weak var editChannelButton: UIButton!
    
    var channelResuableViewEditButtonClicked: ((_ sender:UIButton) ->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        editChannelButton.layer.borderColor = UIColor.globalRedColor().cgColor
        editChannelButton.layer.borderWidth = 1
        editChannelButton.setTitle("完成", for: .selected)
        NotificationCenter.default.addObserver(self, selector: #selector(longPressTarget), name: NSNotification.Name(rawValue: "longPressTarget"), object: nil)
        
    }
    
    @objc private func longPressTarget() {
        editChannelButton.isSelected = true
        subtitleLabel.setTitle("拖拽可以排序", for: .normal)
    }
    
    @IBAction func editButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        subtitleLabel.setTitle(sender.isSelected ? "拖拽排序":"点击进入o频道", for: .normal)
        channelResuableViewEditButtonClicked?(sender)
    }
    
    /// 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
