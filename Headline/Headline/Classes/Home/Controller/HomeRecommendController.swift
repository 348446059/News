//
//  HomeRecommendController.swift
//  Headline
//
//  Created by libo on 2018/6/29.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit

class HomeRecommendController: HomeTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.lb_registerCell(cell: HomeUserCell.self)
        tableView.lb_registerCell(cell: TheyAlsoUseCell.self)
        tableView.lb_registerCell(cell: HomeCell.self)
    }

   
}

extension HomeRecommendController{
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let aNews = news[indexPath.row]
        switch aNews.cell_type {
        case .user:
            return aNews.contentH
        case .relatedConcern:
            return 290 * ratio
        case .none:
            return aNews.cellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aNews = news[indexPath.row]
        switch aNews.cell_type {
        case .user: //用户
            let cell = tableView.lb_dequeueReusableCell(indexPath: indexPath) as HomeUserCell
            cell.aNews = aNews
            return cell
        case .relatedConcern:   //相关关注
            let cell = tableView.lb_dequeueReusableCell(indexPath: indexPath) as TheyAlsoUseCell
            cell.theyUse = aNews.raw_data
            return cell
        case .none:
            let cell = tableView.lb_dequeueReusableCell(indexPath: indexPath) as HomeCell
            cell.aNews = aNews
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var aNews = news[indexPath.row]
//        if indexPath.row == 0 { //默认设置起一个cell调转到图片详情页面
//
//
//        }
        
    }
}
