//
//  VideoViewController.swift
//  Headline
//
//  Created by libo on 2018/6/10.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit
import SGPagingView

class VideoViewController: UIViewController {
    /// 标题和内容
    private var pageTitleView: SGPageTitleView?
    private var pageContentView: SGPageContentView?
    
    private lazy var navigationBar = HomeNavigationView.loadViewFromNib()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 设置状态栏属性
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage (named: "navigation_background" + (UserDefaults.standard.bool(forKey: isNight) ? "_night" : "")), for: .default)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

}


extension VideoViewController {
    
    /// 设置 UI
    func setupUI() {
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        /// 设置d自定义导航栏
        navigationItem.titleView = navigationBar
        // 视频顶部新闻标题的数据
        NetworkTool.loadVideoApiCategoies {
            let configuration = SGPageTitleViewConfigure()
            configuration.titleColor = .black
            configuration.titleSelectedColor = UIColor.globalRedColor()
            configuration.indicatorColor = .clear
            // b标题名称的数组
            self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: newsTitleHeight), delegate: self, titleNames: $0.compactMap({ $0.name}), configure: configuration)
            // 设置子控制器
            _ = $0.compactMap({ (newsTitle) -> () in
              //  let videoTableVC = 
            })
        }
    }
}


extension VideoViewController:SGPageTitleViewDelegate,SGPageContentScrollViewDelegate{
    /// 联动 pagecontent 方法
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        self.pageContentView?.setPageContentViewCurrentIndex(selectedIndex)
    }
    
    /// 联动 SGPageTitleView 的方法
    func pageContentScrollView(_ pageContentScrollView: SGPageContentScrollView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView!.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
    
    
}
