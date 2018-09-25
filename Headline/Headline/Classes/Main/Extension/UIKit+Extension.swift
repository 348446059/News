//
//  UIKit+Extension.swift
//  Headline
//
//  Created by libo on 2018/5/28.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit
import CoreText

protocol StoryboardLoadable {}

extension StoryboardLoadable where Self:UIViewController {
    /// 提供加载方法
   static func loadStoryboard() -> Self {
    return UIStoryboard(name: "\(self).self()", bundle: nil).instantiateViewController(withIdentifier: "\(self)") as! Self
    }
}

protocol NibLoadable {}

extension NibLoadable{
   static func loadViewFromNib() -> Self {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! Self
    }
}

extension UIColor{
    
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat = 1.0) {
        self.init(displayP3Red: r / 255.0, green: g / 255.0, blue: b / 255/0, alpha: alpha)
    }
    
    ///灰色背景
    class func globalBackgroundColor() -> UIColor {
        return UIColor(r: 248, g: 249, b: 247)
    }
    
    
    /// 背景红色
    class func globalRedColor() -> UIColor {
        return UIColor(r: 196, g: 73, b: 67)
    }
    
    /// 字体蓝色
    class func blueFontColor() -> UIColor {
        return UIColor(r: 72, g: 100, b: 149)
    }
    
    /// 背景灰色 132
    class func grayColor132() -> UIColor {
        return UIColor(r: 132, g: 132, b: 132)
    }
    
    /// 背景灰色 232
    class func grayColor232() -> UIColor {
        return UIColor(r: 232, g: 232, b: 232)
    }
    
    /// 夜间字体背景灰色 113
    class func grayColor113() -> UIColor {
        return UIColor(r: 113, g: 113, b: 113)
    }
    
    /// 夜间背景灰色 37
    class func grayColor37() -> UIColor {
        return UIColor(r: 37, g: 37, b: 37)
    }
    
    /// 灰色 210
    class func grayColor210() -> UIColor {
        return UIColor(r: 210, g: 210, b: 210)
    }
}

extension UIView{
    
    var x :CGFloat{
        
        get{ return frame.origin.x}
       
        set(newValue){
            
            frame.origin.x = newValue
        }
    }
    
    var y:CGFloat{
        get {return frame.origin.y}
        set(newValue){
            frame.origin.y = newValue
        }
    }
    
    var height:CGFloat{
        get{ return frame.size.height }
        
        set(newValue){
            frame.size.height = newValue
        }
    }
    
    var width:CGFloat{
        get{ return frame.size.width }
        
        set(newValue){
            frame.size.width = newValue
        }
    }
    
    var size: CGSize{
        get{ return bounds.size }
        
        set(newValue){
            bounds.size = newValue
        }
    }
    
    
    /// centerX
    var centerX: CGFloat {
        get { return center.x }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x            = newValue
            center                  = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get { return center.y }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y            = newValue
            center                  = tempCenter;
        }
    }
}


protocol RegisterCellFromNib {}

extension RegisterCellFromNib{
    static var identifier:String { return "\(self)"}
    
    static var nib:UINib? { return UINib(nibName: "\(self)", bundle: nil)}
}

extension UITableView{
    ///注册cell的方法
    func lb_registerCell<T: UITableViewCell>(cell:T.Type) where T:RegisterCellFromNib {
        if let nib = T.nib {
            register(nib, forCellReuseIdentifier: T.identifier)
        }else{
            register(cell, forCellReuseIdentifier: T.identifier)
        }
    }
    
    ///从缓存池中取出cell
    func lb_dequeueReusableCell<T:UITableViewCell>(indexPath:IndexPath) -> T where T: RegisterCellFromNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}

extension UICollectionView{
    ///注册 cell的方法
    func lb_registerCell<T:UICollectionViewCell>(cell:T.Type) where T:RegisterCellFromNib {
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.identifier)
        }else{
            register(cell, forCellWithReuseIdentifier: T.identifier)
        }
    }
    
    
    ///从缓存池池出队已经存在的 cell
    func lb_dequeueReusableCell<T:UICollectionViewCell>(indexPath:IndexPath) -> T where T:RegisterCellFromNib {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
    ///注册头部
    func lb_registerSupplymentaryHeaderView<T: UICollectionReusableView>(resuableView: T.Type)  where T:RegisterCellFromNib {
        
        if let nib = T.nib {
            register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: T.identifier)
        }else{
            register(resuableView, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: T.identifier)
        }
    }
    
    ///获取可重用的头部
    func lb_dequeueReusableSupplementaryHeaderView<T: UICollectionReusableView>(indexPath:IndexPath) -> T where T:RegisterCellFromNib {
        return dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}

extension UIImageView{
    
    func circleImage()  {
       ///建立上下文
      UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
       ///获取当前上下文
      let ctx = UIGraphicsGetCurrentContext()
      ///添加一个圆，并裁减
        ctx?.addEllipse(in: self.bounds)
        ctx?.clip()
        ///绘制图像
        self.draw(self.bounds)
        ///获取绘制的图像
        let image = UIGraphicsGetImageFromCurrentImageContext()
        ///关闭上下文
        UIGraphicsEndImageContext()
        DispatchQueue.global().async {
            self.image = image
        }
    }
}






















