//
//  ButtonExtension.swift
//  HQNews
//
//  Created by MRBean on 16/1/19.
//  Copyright © 2016年 杨斌. All rights reserved.
//

import UIKit

//给UIButton添加一个方法显示网络图片
extension UIButton {
    func setImageWithURL(url: String) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) { () -> Void in
            //首先下载图片
            let data = NSData(contentsOfURL: NSURL(string: url)!)
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //调用button原生的方法,显示下载的图片
                self.setImage(UIImage(data: data!), forState: .Normal)
            })
        }
    }
}