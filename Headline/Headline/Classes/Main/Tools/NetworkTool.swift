//
//  NetworkTool.swift
//  Headline
//
//  Created by libo on 2018/5/28.
//  Copyright © 2018年 libo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkToolProtocol {
    
    
    //首页顶部新闻标题的数据
   static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles:[HomeNewsTitle])->Void)
    
    //点击首页家好按钮 获取频道推荐数据
    static func loadHomeCategoryRecommend(completionHandler:@escaping (_ titles:[HomeNewsTitle])->Void)
}

extension NetworkToolProtocol{
    
    static func loadHomeNewsTitleData(completionHandler:@escaping (_ newsTitles:[HomeNewsTitle])-> Void)  {
        let url = BASE_URL + "/article/category/get_subscribed/v1/?"
        let params = ["device_id":device_id,"iid":iid]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            //网络错误的提示信息
            guard response.result.isSuccess else{ return }
            if let value = response.result.value{
                let json = JSON(value)
                guard json["message"] == "success" else{ return }
                if let dataDict = json["data"].dictionary{
                    if let datas = dataDict["data"]?.arrayObject{
                        var titles = [HomeNewsTitle]()
                        titles.append(HomeNewsTitle.deserialize(from: "{\"category\": \"\", \"name\": \"推荐\"}")!)
                        titles += datas.compactMap({ HomeNewsTitle.deserialize(from: $0 as? Dictionary)
                        })
                        completionHandler(titles)
                    }
                }
                
            }
        }
        
        
    }
    
   static func loadHomeSearchSuggestInfo(_ completionHandler:@escaping (_ searchSeggest:String)->())  {
        let url  = BASE_URL + "/search/suggest/homepage_suggest/?"
        let params = ["device_id":device_id,"iid":iid]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else{ return }
            if let value = response.result.value{
                let json = JSON(value)
                guard json["message"] == "success" else{return}
                
                if let data = json["data"].dictionary{
                    completionHandler(data["homepage_search_suggest"]!.string!)
                }
                
            }
        }
        
        
    }
    
   
    
    //频道推荐数据
    static func loadHomeCategoryRecommend(completionHandler:@escaping (_ titles:[HomeNewsTitle])->Void){
        let url = BASE_URL + "/article/category/get_extra/v1/?"
        let params = ["device_id":device_id,"iid":iid]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {return}
            if let value = response.result.value{
                let json = JSON(value)
                let dataDict = json["data"].dictionary
                if let data = dataDict!["data"]?.arrayObject {
                    completionHandler(data.compactMap({
                        HomeNewsTitle.deserialize(from: ($0 as! [String:Any]))
                    }))
                }
            }
        }
    }
}

struct NetworkTool:NetworkToolProtocol {}



















