//
//  HomeAddCategoryController.swift
//  Headline
//
//  Created by libo on 2018/9/25.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit
import IBAnimatable

class HomeAddCategoryController: AnimatableModalViewController,StoryboardLoadable{
    /// 是否编辑
    var isEdit = false {
        didSet {
            collectionView.reloadData()
        }
    }
    // 上部 我的频道
   private var homeTitles = [HomeNewsTitle]()
    // 下部 频道推荐数据
   private var categories = [HomeNewsTitle]()
    
    private lazy var longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressTarget))
    
    @objc private func longPressTarget(longPress:UILongPressGestureRecognizer) {
        NotificationCenter.default.post(name:Notification.Name("longPressTarget"),object:nil)
         // 选中的 点
        let selectedPoint = longPress.location(in: collectionView)
        // 转换成索引
        if let selectedIndexPath = collectionView.indexPathForItem(at: selectedPoint) {
            switch longPress.state {
              case .began:
                if isEdit && selectedIndexPath.section == 0 {
                    collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
                }else {
                    isEdit = true
                    collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
                }
            case .changed:
                // 固定第一、第二不动
                if selectedIndexPath.item <= 1{
                    collectionView.endInteractiveMovement()
                    break
                }
            collectionView.updateInteractiveMovementTargetPosition(longPress.location(in: longPressRecognizer.view))
            case .ended:
                collectionView.endInteractiveMovement()
            default:
                collectionView.cancelInteractiveMovement()
            }
        } else {
            //判断点是否在 collectionView上
            if selectedPoint.x < collectionView.bounds.minX || selectedPoint.x > collectionView.bounds.maxX || selectedPoint.y < collectionView.bounds.minY || selectedPoint.y > collectionView.bounds.maxY {
                collectionView.endInteractiveMovement()
            }
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func closeAddCategoryButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
   @IBOutlet weak var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 从数据库中取出左右数据
        homeTitles = NewsTitleTable().selectAll()
        //布局
        collectionView.collectionViewLayout = AddCategoryFlowLayout()
        //注册cell和头部
        collectionView.lb_registerCell(cell: AddCategoryCell.self)
        collectionView.lb_registerCell(cell: ChannelRecommendCell.self)
        collectionView.lb_registerSupplymentaryHeaderView(resuableView: ChannelRecommendReusableView.self)
        collectionView.lb_registerSupplymentaryHeaderView(resuableView: MyChannelReusableView.self)
        collectionView.allowsMultipleSelection = true
        collectionView.addGestureRecognizer(longPressRecognizer)
    }
}

class AddCategoryFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        itemSize  = CGSize(width: (screenWidth - 50)*0.25, height: 44)
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
    }
}


extension HomeAddCategoryController: AddCategoryCellDelegate {
    //删除按钮点击
    func deleteCategoryButtonClicked(of cell: AddCategoryCell) {
        // 上部删除 下部删除
        let indexPath = collectionView.indexPath(for: cell)
        categories.insert(homeTitles[indexPath!.item], at: 0)
        collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
        homeTitles.remove(at: indexPath!.item)
        collectionView.deleteItems(at: [IndexPath(item: indexPath!.item, section: 0)])
    }
}

extension HomeAddCategoryController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    /// y头部
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let channelReusableView = collectionView.lb_dequeueReusableSupplementaryHeaderView(indexPath: indexPath) as MyChannelReusableView
            // 点击编辑 / 完成
            channelReusableView.channelResuableViewEditButtonClicked = {
                [weak self] (sender) in
                self!.isEdit = sender.isSelected
                if !sender.isSelected { collectionView.endInteractiveMovement() }
            }
            channelReusableView.width = screenWidth - 15.0
            return channelReusableView
            
        }else {
            let channelRecommendReusableView = collectionView.lb_dequeueReusableSupplementaryHeaderView(indexPath: indexPath) as ChannelRecommendReusableView
            channelRecommendReusableView.width = screenWidth - 15.0
            return channelRecommendReusableView
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenWidth, height: 50)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? homeTitles.count : categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.lb_dequeueReusableCell(indexPath: indexPath) as AddCategoryCell
            cell.titleButton.setTitle(homeTitles[indexPath.item].name, for: .normal)
            cell.isEdit = isEdit
            cell.delegate = self
            return cell
        }else {
            let cell = collectionView.lb_dequeueReusableCell(indexPath: indexPath) as ChannelRecommendCell
            cell.titleButton.setTitle(categories[indexPath.item].name, for: .normal)
            return cell
        }
    }
    
    /// 点击了某一个cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 点击上面一组 不做任何操作 点击下面一组 会添加到上面的组里
        guard indexPath.section == 1  else {
            return
        }
        homeTitles.append(categories[indexPath.item])//添加
        collectionView.insertItems(at: [IndexPath(item: homeTitles.count - 1, section: 0)])
        categories.remove(at: indexPath.item)
        collectionView.deleteItems(at: [IndexPath(item: indexPath.item, section: 1)])
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// 移动 cell
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
         // 固定第一、二个不能移动
        if destinationIndexPath.item <= 1 {
            collectionView.endInteractiveMovement()
            collectionView.reloadData()
            return
        }
        
        // 取出需要移动的cell
        let title = homeTitles[sourceIndexPath.item]
        homeTitles.remove(at: sourceIndexPath.item)
        
        //移动 cell
        if isEdit && sourceIndexPath.section == 0 {
            // 说明移动前后都在第一组
            if destinationIndexPath.section == 0 {
                homeTitles.insert(title, at: destinationIndexPath.item)
            } else {
                categories.insert(title, at: destinationIndexPath.item)
            }
        }
    }
    
    /// 每个 cell 之间的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
