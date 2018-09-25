//
//  RefreshHeader.swift
//  Headline
//
//  Created by libo on 2018/6/29.
//  Copyright © 2018年 libo. All rights reserved.
//

import  MJRefresh

class RefreshHeader: MJRefreshGifHeader {

    
     ///初始化
    override func prepare() {
        super.prepare()
        //图片数组
        var images = [UIImage]()
        //遍历
        for index in 0..<16 {
            let image = UIImage(named: "dropdown_loading_0\(index)")
            if let image = image{
                images.append(image)
            }
        }
        //设置空闲状态的图片
        setImages(images, for: .idle)
        //设置刷新状态的图片
        setImages(images, for: .refreshing)
        setTitle("下啦推荐", for: .idle)
        setTitle("松开推荐", for: .pulling)
        setTitle("推荐中", for: .refreshing)
        
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        gifView.contentMode = .center
        gifView.frame = CGRect(x: 0, y: 4, width: mj_w, height: 25)
        stateLabel.font = UIFont.systemFont(ofSize: 12)
        stateLabel.frame = CGRect(x: 0, y: 35, width: mj_w, height: 14)
    }
}

class RefreshAutoGifFooter: MJRefreshAutoGifFooter {
    override func prepare() {
        super.prepare()
        //设置空间的高度
        mj_h = 50
        //图片数组
        var images = [UIImage]()
        //遍历
        for index in 0..<8 {
            let image = UIImage(named: "sendloading_18X18_\(index)")
            if let image = image{
                images.append(image)
            }
        }
        //设置空闲状态的图片
        setImages(images, for: .idle)
        //设置刷新状态的图片
        setImages(images, for: .pulling)
        setTitle("上拉家在数组", for: .idle)
        setTitle("正在努力加载数据", for: .pulling)
        setTitle("正在努力加载", for: .refreshing)
        setTitle("没有更多数据", for: .noMoreData)
    }
    override func placeSubviews() {
        super.placeSubviews()
        gifView.x = 135
        gifView.centerY = stateLabel.sg_centerY
    }
}


















