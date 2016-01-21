//
//  HQNews.swift
//  HQNews
//
//  Created by MRBean on 16/1/19.
//  Copyright © 2016年 杨斌. All rights reserved.
//

import UIKit

//实体新闻类
class HQNews: NSObject {
    
    //存储属性(相当于OC中的成员变量,可以使用self引用)
    //swift原则:必需保证存储属性都有值
    var _aid: String = ""
    var _title: String = ""
    var typeid: String = ""
    var image: String = ""
    //description是系统的计算属性setter和getter
    var description2: String = ""
    var category: String = ""
    var author: String = ""
    var pubDate: String = ""
    var comments: String = ""
    
    //写一个构造器,从字典来构造实体
    init(data:[String:String]) {
        //从字段中取某个值,该值可能为空,从字典中取的值是可选类型,如果要获取其值需要解析
        _aid         = data["aid"]!
        _title       = data["title"]!
        if(data["typeid"] != nil) {
        typeid       = data["typeid"]!
        }

        image        = data["image"]!
        description2 = data["description"]!
        category     = data["category"]!
        author       = data["author"]!
        pubDate      = data["pubDate"]!
        comments     = data["comments"]!
        
    }
    
    //计算属性:setter和getter相当于OC中@property
    var titile: String {
        set { //setter,赋值用的;传入的参数是newValue
            _title = newValue + "环球"
            
        }
        get {//getter
            return _title
        }
    }
    
    //计算属性,可以没有set,只读的计算属性
    var aid: String {
        get { //只读的计算属性get{}可以省略
            return _aid
        }
    }
    
    //为方便打印我们重写description属性的getter
    //description中的get方法会在print(obj)
    override var description: String {
        return _aid + _title
    }
    
    
}
