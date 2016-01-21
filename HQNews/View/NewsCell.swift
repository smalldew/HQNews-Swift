//
//  NewsCell.swift
//  HQNews
//
//  Created by MRBean on 16/1/19.
//  Copyright © 2016年 杨斌. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet var imageButton: UIButton!
    @IBOutlet var titleLab: UILabel!
    @IBOutlet var zanButton: UIButton!
    
    //重写extension中的方法
    override func configCell(model: HQNews) {
        titleLab.text = model.titile
        //显示网络图片
        imageButton.setImageWithURL(model.image)
    }
    
    @IBAction func tapImage(sender: UIButton) {
    }
    
    @IBAction func tapZan(sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
