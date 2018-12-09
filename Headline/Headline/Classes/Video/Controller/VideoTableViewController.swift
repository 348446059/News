//
//  VideoTableViewController.swift
//  Headline
//
//  Created by libo on 2018/9/25.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit
import SVProgressHUD
import RxSwift
import RxCocoa
import BMPlayer
import NVActivityIndicatorView
import SnapKit


class VideoTableViewController: HomeTableViewController {

   private lazy var disposeBag = DisposeBag()
   //上一次播放的 cell
   private var priorCell: VideoCell?
   /// 视频真实地址
   private var realVideo = RealVideo()
   /// 当前播放时间
   private var currentTime: TimeInterval = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        player.delegate = self
        tableView.rowHeight = screenWidth * 0.67
        tableView.lb_registerCell(cell: VideoCell.self)
    }
    
}


extension VideoTableViewController {
    func addPlayer(on cell:VideoCell)  {
        // 视频播放时隐藏 cell的部分子视图
        cell.hideSubViews()
        NetworkTool.parseVideoRealURL(video_id: cell.video.video_detail_info.video_id) {
            self.realVideo = $0
            cell.bgImageButton.addSubview(self.player)
            self.player.snp.makeConstraints({
                $0.edges.equalTo(cell.bgImageButton)
            })
            // 设置视频播放地址
            self.player.setVideo(resource: BMPlayerResource(url: URL(string: $0.video_list.video_1.mainURL)!))
            self.priorCell = cell
        }
    }
    
    /// 移除播放器
    func removePlayer()  {
        player.pause()
        player.removeFromSuperview()
        priorCell = nil
    }
}


extension VideoTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.lb_dequeueReusableCell(indexPath: indexPath) as VideoCell
        cell.video = news[indexPath.row]
//        cell.avatarButton.rx.tap.subscribe(onNext: {[weak self] in
//            let userDetail = <#value#>
//
//        })
        
        
        return cell
    }
}


extension VideoTableViewController: BMPlayerDelegate {
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        
    }
    
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        
    }
    
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        
    }
    
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        
    }
    
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        
    }
    
    
}
