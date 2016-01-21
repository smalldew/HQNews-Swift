//
//  ViewController.swift
//  HQNews
//
//  Created by MRBean on 16/1/19.
//  Copyright © 2016年 杨斌. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    //使用OC类型的数组
    var marr = NSMutableArray()
//    var marr = [HQNews]()
    var page = 1
    /**
     实现协议方法
     */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        //调用cell的config方法,设置cell样式
        let news = marr[indexPath.row]
        //把对象转换为HQNews
        cell.configCell(news as! HQNews)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加上拉和下拉
        configRefreshControl()
        //给xib创建的cell需要注册id
        tableView.registerNib(UINib(nibName: "NewsCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "cell")
        //设置自动行高
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        //获取数据
        getData()
    }
    
    /**
     配置刷新控件
     */
    func configRefreshControl() {
        
        //添加下拉
        self.tableView.addHeaderWithCallback {[weak self] () -> Void in
            self?.page = 1
            [self? .getData()];
        }
        self.tableView.headerPullToRefreshText = "下拉刷新"
        self.tableView.headerReleaseToRefreshText = "释放立即刷新"
        self.tableView.headerRefreshingText = "正在刷新,请稍后"
        //下拉
        self.tableView.addFooterWithCallback { [weak self]() -> Void in
            self?.page++
            [self? .getData()];
        }
        self.tableView.footerPullToRefreshText = "上拉加载更多"
        self.tableView.footerRefreshingText = "正在加载,请稍后"
        self.tableView.footerReleaseToRefreshText = "释放刷新"
        
    }

    //从网络获取数据
    func getData() {
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        DataManager.shareManager().getMainPageNews(page, succ: {[weak self] (data) -> Void in
            
            if(self?.page == 1) {
                self?.marr.removeAllObjects()
                self?.marr.addObjectsFromArray(data)
                //重新加载数据
                self?.tableView.reloadData()
            } else {//不是第一页
                
                if(data.count>0) {
                    self?.marr.addObjectsFromArray(data)
                    self?.tableView.reloadData()
                }
            }
            
            self?.tableView.headerEndRefreshing()
            self?.tableView.footerEndRefreshing()
            hud.hide(true)
            }) {[weak self] (error) -> Void in
                self?.tableView.headerEndRefreshing()
                self?.tableView.footerEndRefreshing()
                print("错误是\(error)")
                hud.hide(true)
        }
    }

}

