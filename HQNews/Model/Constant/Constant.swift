//
//  Constant.swift
//  HQNews
//
//  Created by MRBean on 16/1/19.
//  Copyright © 2016年 杨斌. All rights reserved.
//

//可以用swift中的常量和函数替代OC中的宏定义
import Foundation

let kURL_MainPage = "http://if.wap.xinjunshi.com/ifios/app.php"
//替代OC中常用的代码
func showText(msg: String) {
    let hud = MBProgressHUD()
    hud.labelText = msg
    hud.mode = .Text
    hud.show(true)
}

