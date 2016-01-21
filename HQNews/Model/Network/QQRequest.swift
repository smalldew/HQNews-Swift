//
//  QQRequest.swift
//  HQNews
//
//  Created by MRBean on 16/1/19.
//  Copyright © 2016年 杨斌. All rights reserved.
//

import UIKit
/// QQRequest:包装底层网络,避免底层网络变更;给数据管理器使用

 /// Block回调/类型写法
//typealias类型别名
//成功之后的代码块回调类型
//(data: AnyObject) -> Void是闭包类型,
typealias SuccessHandler = (data: AnyObject) -> Void
typealias FailedHandler = (error: NSError) -> Void


class QQRequest: NSObject {
    //感叹号:隐式可选类型,可选类型Optional("123")
    var afManager: AFHTTPSessionManager!
    //1.写构造器,swift的构造器只有一种格式,init;OC中便利构造器和alloc init,在swift中只有init形式
    //重写父类的构造器
    override init() {
        //把所有的属性初始化
        //OC中的alloc init在swift中是: 类名(参数名:)
        //NSURLSessionConfiguration.defaultSessionConfiguration()调用类方法创建对象;也可以 NSURLSessionConfiguration()
        afManager = AFHTTPSessionManager(sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())
        //配置是否自动解析,不自动解析
        afManager.responseSerializer = AFHTTPResponseSerializer()
        //一般来说,重写父类的构造器时,在最后调用
        super.init()
        
    }
    //2.调用AF网络请求
    //-> Void返回值为Void可以省略
    //param:[String:String]?参数可以为nil,param是可选类型
    /**
    调用AFNetworking发起Get请求
    
    - parameter url:     地址
    - parameter param:   参数,可以为nil
    - parameter success: 成功之后的回调
    - parameter failed:  失败之后的回调
    */
    func startGetRequest(url: String, param: [String:String]?,success: SuccessHandler, failed: FailedHandler ) {
        //调用OC的代码,swift自动转换
        afManager.GET(url, parameters: param, progress: nil, success: { (task, res) -> Void in
            //成功之后
            if(res == nil) {//返回数据nil就结束执行后续代码
                return
            }
            
            //JSON解析
            //使用as强制转换类型
            // .AllowFragments,在swift中枚举可以只使用 .变化的的枚举值
            let obj = try? NSJSONSerialization.JSONObjectWithData(res as! NSData, options: .AllowFragments)
            if(obj == nil) {//JSON解析失败
                
            } else { //解析成功,执行成功的回调
                success(data: obj!)//调用成功之后的代码块
            }
            
            
            }) { (task, error) -> Void in
               failed(error: error)//执行失败的回调
        }
    }
}







