//
//  DataManager.swift
//  HQNews
//
//  Created by MRBean on 16/1/19.
//  Copyright © 2016年 杨斌. All rights reserved.
//

import UIKit
//manager的回调类型
typealias SuccessHandler2 = (data:[HQNews]) -> Void
typealias FailedHandler2 = (error:NSError) -> Void


class DataManager: NSObject {
    
    //OC中的+号方法,在swift中是 class修饰
    //static修饰的是类变量,相当于一个变量是属于一个类的
    static var dataManager: DataManager!
    static var onceToken: dispatch_once_t = dispatch_once_t()
    var request: QQRequest = QQRequest()//请求类
    class func shareManager() -> DataManager {
        dispatch_once(&onceToken) { () -> Void in
            dataManager = DataManager()
        }
        return dataManager
    }
//    //swift中单例的简单写法
//    static  let manager2 = DataManager()
//    class func share() -> DataManager {
//        return manager2
//    }
    
    /**
    <#Description#>
    
    - parameter page: <#page description#>
    */
    
    //String(page)把其他类型的page转换为字符串
    func getMainPageNews(page: Int, succ:SuccessHandler2, fail: FailedHandler2) {
        //调用request方法去请求
        request.startGetRequest(kURL_MainPage, param: ["act":"index","page":String(page)], success: { (data) -> Void in
            //把data转换为字典类型
            let dic = data as? [String:AnyObject]
            if(dic == nil) {//返回的数据为nil
                return
            }
            let dd = dic!
            if(dd["item"] == nil) {//
                succ(data: [HQNews]())
                return
            }
            //获取我们所需的数组
            let item = dd["item"]! as! [[String:String]]
            //构建实体,obj是数组中的某个字典
            //构造一个可变数组
            var marr = [HQNews]()
            for obj in item {
                let news = HQNews(data: obj)
                marr.append(news)
            }
            succ(data: marr)//执行成功的回调
            
            }) { (error) -> Void in
            fail(error: error)
        }
    }
    
    
}
