//
//  NewsModel.swift
//  Headline
//
//  Created by libo on 2018/5/28.
//  Copyright © 2018年 libo. All rights reserved.
//

import HandyJSON

enum ImageType:Int,HandyJSONEnum {
    case normal = 1  //一般图片
    case git = 2     // gif 图
}

struct URLList:HandyJSON {
    var url = ""
    
}

struct ThumbImage:HandyJSON{
    var type = ImageType.normal
    var height:CGFloat = 0
    
    var url_list = [URLList]()
    var url:NSString = ""
    
    var urlString:String{
        guard url.hasPrefix(".webp") else {
            return url as String
        }
        return url.replacingCharacters(in: NSRange(location: url.length - 5, length: 5), with: ".png")
    }
    var width:CGFloat = 0
    var uri = ""
    
    
    ///宽高比
    var ratio:CGFloat{
        return width / height
    }
    
    
    
}


























