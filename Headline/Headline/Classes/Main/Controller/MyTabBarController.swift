//
//  MyTabBarController.swift
//  Headline
//
//  Created by libo on 2018/6/10.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabbar = UITabBar.appearance()
        tabbar.theme_tintColor = "colors.tabbarTintColor"
        tabbar.theme_barTintColor = "colors.cellBackgroundColor"
        
        //添加子控制器
        addChildViewControllers()
        NotificationCenter.default.addObserver(self, selector: #selector(recevieDayOrNightButtonClicked(notification:)), name: NSNotification.Name("dayOrNightButtonClicked"), object: nil)
    }
}

extension MyTabBarController{
    
    //初始化子控制器
    private func setChildViewController(_ childController:UIViewController,title:String,imageName:String){
        
        //设置tabbar 文字和图片
        if UserDefaults.standard.bool(forKey: isNight) {
            setNightChildController(controller: childController, imageName: imageName)
        }else{
            setDayChildController(controller: childController, imageName: imageName)
        }
        childController.title = title
        addChildViewController(MyNavigationController(rootViewController: childController))
    }
    //设置夜间控制器
    func setNightChildController(controller:UIViewController,imageName:String)  {
        
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_night_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_night_32x32_")
    }
    
    
    //设置日间控制器
    func setDayChildController(controller:UIViewController,imageName:String)  {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")
    }
    
    //添加子控制器
    func addChildViewControllers()  {
       setChildViewController(HomeViewController(), title: "首页", imageName: "home")
       setChildViewController(VideoViewController(), title: "西瓜视频", imageName: "video")
       setChildViewController(RedPackageViewController2(), title: "", imageName: "redpackage")
        setChildViewController(WeitoutiaoViewController(), title: "微头条", imageName: "weitoutiao")
        setChildViewController(HuoshanViewController(), title: "小视频", imageName: "huoshan")
    }
    
  @objc  func recevieDayOrNightButtonClicked(notification:Notification) {
        let selected = notification.object as! Bool
        if selected {
            for childController in childViewControllers{
                switch childController.title! {
                  case "首页":
                    setNightChildController(controller: childController, imageName: "home")
                case "西瓜视频":
                    setNightChildController(controller: childController, imageName: "video")
                case "小视频":
                    setNightChildController(controller: childController, imageName: "huoshan")
                case "微头条":
                    setNightChildController(controller: childController, imageName: "weitoutiao")
                case "":
                    setNightChildController(controller: childController, imageName: "redpackage")
                default:
                    break
                }
            }
        }else { // 设置为日间
            for childController in childViewControllers {
                switch childController.title! {
                case "首页":
                    setDayChildController(controller: childController, imageName: "home")
                case "西瓜视频":
                    setDayChildController(controller: childController, imageName: "video")
                case "小视频":
                    setDayChildController(controller: childController, imageName: "huoshan")
                case "微头条":
                    setDayChildController(controller: childController, imageName: "weitoutiao")
                case "":
                    setDayChildController(controller: childController, imageName: "redpackage")
                default:
                    break
                }
            }
        }
    }
}




























