//
//  HomeNewsTitle.swift
//  Headline
//
//  Created by libo on 2018/5/28.
//  Copyright © 2018年 libo. All rights reserved.
//

import Foundation
import HandyJSON

struct SettingModel: HandyJSON {
    
    var subtitle: String = ""
    var title: String = ""
    var rightTitle: String = ""
    var isHiddenSubtitle: Bool = false
    var isHiddenRightTitle: Bool = false
    var isHiddenSwitch: Bool = false
    var isHiddenRightArraw: Bool = false
}
