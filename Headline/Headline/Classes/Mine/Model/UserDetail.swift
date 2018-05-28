//
//  UserDetail.swift
//  Headline
//
//  Created by libo on 2018/5/28.
//  Copyright © 2018年 libo. All rights reserved.
//

import Foundation
import HandyJSON



///rich_content 中的元素
struct RichContent {
    var uid = ""
    var name = ""
    
    init(_ uid:String,_ name:String) {
        self.uid = uid
        self.name = name
    }
}
