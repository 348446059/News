//
//  MyTheme.swift
//  Headline
//
//  Created by libo on 2018/5/28.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit
import SwiftTheme

enum MyTheme:Int {
    case day = 0
    case night = 1
    
    static var before = MyTheme.day
    static var current = MyTheme.day
    ///选择主题
    static func switchTo(_ theme:MyTheme){
        before = current
        current = theme
        
        switch theme {
        case .day:ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
        case .night:ThemeManager.setTheme(plistName: "night_theme", path: .mainBundle)
        }
    }
    
    ///选择了夜间主题
    static func switchNight(_ isToNight:Bool) {
        switchTo(isToNight ? .night : .day)
    }
    
    ///判断当前是否是夜间主题
   static func isNight() -> Bool {
        return current == .night
    }
}

struct MyThemeStyle {
    ///设置导航栏样式 （日间 夜间）
    static func setupNavigationBArStyle(_ viewController:UIViewController,_ isNight:Bool) {
        if isNight {
            viewController.navigationController?.navigationBar.barStyle = .black
            
        viewController.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "navigation_background_white_night"), for: .default)
            
            viewController.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.grayColor113()]
        }else{
            //设置夜间主题
            viewController.navigationController?.navigationBar.barStyle = .default
            viewController.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "navigation_background_white"), for: .default)
        }
    }
}























