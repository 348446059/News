//
//  AddCategoryCell.swift
//  Headline
//
//  Created by libo on 2018/9/25.
//  Copyright © 2018年 libo. All rights reserved.
//

import UIKit

protocol AddCategoryCellDelegate: class {
    
    func deleteCategoryButtonClicked(of cell:AddCategoryCell)
}

class AddCategoryCell: UICollectionViewCell,RegisterCellFromNib {
    weak var delegate: AddCategoryCellDelegate?
    
    @IBOutlet weak var titleButton: UIButton!
    
    @IBOutlet weak var deleteCategoryButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
    }
    
    
    var isEdit = false {
        didSet {
            deleteCategoryButton.isHidden = !isEdit
            if titleButton.titleLabel?.text == "推荐" || titleButton.titleLabel!.text! == "热点" {
                deleteCategoryButton.isHidden = true
            }
        }
    }
    
    @IBAction func deleteCategoryButtonClicked(_ sender: UIButton) {
        delegate?.deleteCategoryButtonClicked(of: self)
    }
}
