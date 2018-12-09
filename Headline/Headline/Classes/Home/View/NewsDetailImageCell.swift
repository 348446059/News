//
//  NewsDetailImageCell.swift
//  Headline
//
//  Created by libo on 2018/9/26.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit

protocol NewsDetailImageCellDelegate:class {
    
    func imageViewLongPressGestureRecognizer()
}

class NewsDetailImageCell: UICollectionViewCell,RegisterCellFromNib {
    weak var delegate:NewsDetailImageCellDelegate?
   
    @IBOutlet weak var abstractLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var abstractLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var index = 0
    var count = 0
    
    var abstract: String = "" {
        didSet {
            let size = CGSize(width: screenWidth - 30, height: CGFloat(MAXFLOAT))
            let abstractHeight = abstract.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 18)], context: nil).size.height
            abstractLabelHeight.constant = abstractHeight + 5
            self.layoutIfNeeded()
            
            let abstractAttributeString = NSAttributedString(string: abstract, attributes: [.font: UIFont.systemFont(ofSize: 17)])
            
            let countAttributeString = NSMutableAttributedString(string: "/\(count) ", attributes: [.font: UIFont.systemFont(ofSize: 13)])
            countAttributeString.append(abstractAttributeString)
            
            let numberAttributeString = NSMutableAttributedString(string: "\(index)", attributes: [.font: UIFont.systemFont(ofSize: 17)])
            numberAttributeString.append(countAttributeString)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let longRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longRecognizerEvent))
        imageView.addGestureRecognizer(longRecognizer)
    }
    
    @objc func longRecognizerEvent()  {
        delegate?.imageViewLongPressGestureRecognizer()
    }
    
}
