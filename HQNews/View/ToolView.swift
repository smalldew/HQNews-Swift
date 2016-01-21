//
//  ToolView.swift
//  HQNews
//
//  Created by MRBean on 16/1/19.
//  Copyright © 2016年 杨斌. All rights reserved.
//

import UIKit

class ToolView: UIView {

    //便利构造器:必需调用指定构造器
    convenience init() {
      self.init()
    }
    //重写父类构造器
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    //
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
