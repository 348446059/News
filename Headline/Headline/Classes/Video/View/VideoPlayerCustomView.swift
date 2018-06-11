//
//  VideoPlayerCustomView.swift
//  Headline
//
//  Created by libo on 2018/6/11.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit
import BMPlayer
import SnapKit

class VideoPlayerCustomView: BMPlayerControlView {
    override func customizeUIComponents() {
        BMPlayerConf.topBarShowInCase = .none
    }

}
