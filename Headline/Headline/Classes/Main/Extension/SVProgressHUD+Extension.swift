//
//  SVProgressHUD+Extension.swift
//  Headline
//
//  Created by libo on 2018/6/29.
//  Copyright © 2018年 libo. All rights reserved.
//

import SVProgressHUD

extension SVProgressHUD{
    
   static func configuration()  {
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.3))
    }
}
