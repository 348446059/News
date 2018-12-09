//
//  HomeViewController.swift
//  Headline
//
//  Created by libo on 2018/6/10.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit
import SGPagingView
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    private var pageTitleView:SGPageTitleView?
    private var pageContentView:SGPageContentView?
    
    private lazy var navigationBar = HomeNavigationView.loadViewFromNib()
    
    private lazy var disposeBag = DisposeBag()

   private lazy var addChannelButton: UIButton = {
        let addChannelButton = UIButton(type: UIButtonType.custom)
    
    addChannelButton.frame = CGRect(x: screenWidth - newsTitleHeight, y: 0, width: newsTitleHeight, height: newsTitleHeight); addChannelButton.theme_setImage("images.add_channel_titlbar_thin_new_16x16_", forState: .normal)
        let separatorView = UIView(frame: CGRect(x: 0, y: newsTitleHeight - 1, width: newsTitleHeight, height: 1))
        
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        addChannelButton.addSubview(separatorView)
        return addChannelButton
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
       clickAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.keyWindow?.theme_backgroundColor = "colors.windowColor"
        navigationController?.navigationBar.barStyle = .black
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }

}


extension HomeViewController{
    
    private func setupUI() {
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        navigationItem.titleView = navigationBar
        view.addSubview(addChannelButton)
        
        //首页顶部新闻标题数据
        NetworkTool.loadHomeNewsTitleData {
            NewsTitleTable().insert($0)
            let configuration = SGPageTitleViewConfigure()
            configuration.titleColor = .black
            configuration.titleSelectedColor = .globalRedColor()
            configuration.indicatorColor = .clear
            //标题名称的数组
            self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: 0, width: screenWidth - newsTitleHeight, height: newsTitleHeight), delegate: self, titleNames: $0.compactMap({$0.name}), configure: configuration)
            self.pageTitleView?.backgroundColor = .clear
            self.view.addSubview(self.pageTitleView!)
            
            //设置子控制器
            _ = $0.compactMap({ (newsTitle) -> () in
                switch newsTitle.category{
                case .video:  //视频
                    let homeTableVC = HomeRecommendController()
                    homeTableVC.setupRefresh(with: newsTitle.category)
                    self.addChildViewController(homeTableVC)
                case .essayJoke: //段子
                    let homeTableVC = HomeRecommendController()
                    homeTableVC.setupRefresh(with: newsTitle.category)
                    self.addChildViewController(homeTableVC)
                case .imagePPMM:  //街拍
                    let homeTableVC = HomeRecommendController()
                    homeTableVC.setupRefresh(with: newsTitle.category)
                    self.addChildViewController(homeTableVC)
                case .imageFunny:  //趣图
                    let homeTableVC = HomeRecommendController()
                    homeTableVC.setupRefresh(with: newsTitle.category)
                    self.addChildViewController(homeTableVC)
                case .photos:  //图片
                    let homeTableVC = HomeRecommendController()
                    homeTableVC.setupRefresh(with: newsTitle.category)
                    self.addChildViewController(homeTableVC)
                case .jinritemai:  //特卖
                    let homeTableVC = HomeRecommendController()
                    homeTableVC.setupRefresh(with: newsTitle.category)
                    self.addChildViewController(homeTableVC)
                    
                    default:
                        let homeTableVC = HomeRecommendController()
                        homeTableVC.setupRefresh(with: newsTitle.category)
                    self.addChildViewController(homeTableVC)
                }
            })
            
            self.pageContentView = SGPageContentView(frame: CGRect(x: 0, y: newsTitleHeight, width: screenWidth, height: self.view.height - newsTitleHeight), parentVC: self, childVCs: self.childViewControllers)
            self.pageContentView!.delegatePageContentView = self
            self.view.addSubview(self.pageContentView!)
            
        }
    }
    
    private func clickAction()  {
        /// 添加频道点击
        addChannelButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
            let homeAddCategory = HomeAddCategoryController.loadStoryboard()
            homeAddCategory.modalSize = (width: .full, height: .custom(size: Float(screenHeight - (isIPhoneX ? 44 : 20))))
            self?.present(homeAddCategory, animated: true, completion: nil)
            
        }).disposed(by: disposeBag)
    }
}

extension HomeViewController:SGPageTitleViewDelegate,SGPageContentViewDelegate{
    /// 联动 pageContent 的方法
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        self.pageContentView?.setPageContentViewCurrentIndex(selectedIndex)
    }
    /// 联动 SGPageTitleView 的方法
    func pageContentView(_ pageContentView: SGPageContentView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView?.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
  
}







































