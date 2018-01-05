//
//  CXJIndexVC.swift
//  CXJDaily
//
//  Created by sfzx on 2017/8/22.
//  Copyright © 2017年 陈鑫杰. All rights reserved.
//

import UIKit

let CXJIndexCellID = "CXJIndexCellID"


class CXJIndexVC: CXJVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "今日热闻"
        self.setupUI()
    }
    
    func setupUI() {
        self.addBackButton(selector: nil)
        if #available(iOS 11, *){
            self.tableView.contentInsetAdjustmentBehavior = .never
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
//        self.setFullScreen()
        self.setBarBackgroundColor(backColor: .clear)
        
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.top.width.height.equalTo(self.view)
        }
        
        self.slideshowView.snp.makeConstraints { (make) in
            make.height.equalTo(200)
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    
    //MARK: - 懒加载
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.tableHeaderView = self.slideshowView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CXJIndexCell.self, forCellReuseIdentifier: CXJIndexCellID)
        return tableView
    }()
    
    
    lazy var slideshowView: CXJSlideshowView = {
        
        let model1 = CXJSlideModel()
        model1.image = "http://cdn-img.easyicon.net/png/11682/1168269.gif"
        model1.title = "https://www.baidu.com/"
        
        let model2 = CXJSlideModel()
        model2.image = "http://cdn-img.easyicon.net/png/11682/1168271.gif"
        model2.title = "https://www.apple.com/"
        
        let model3 = CXJSlideModel()
        model3.image = "http://cdn-img.easyicon.net/png/11682/1168273.gif"
        model3.title = "http://www.runoob.com/manual/gitbook/swift3/source/_book/chapter1/chapter1.html"
        
        let model4 = CXJSlideModel()
        model4.image = "http://cdn-img.easyicon.net/png/11682/1168275.gif"
        model4.title = "http://swifter.tips/"
        
        let model5 = CXJSlideModel()
        model5.image = "http://cdn-img.easyicon.net/png/11682/1168277.gif"
        model5.title = "http://www.bejson.com/convert/rgbhex/"
        
        let slideshowView = CXJSlideshowView(frame: .zero, slides: [model1,model2,model3,model4,model5], timeInterval: 5.0)
        return slideshowView
    }()
    
    
    
    lazy var datas: [CXJIndexCellModel] = {
        var datas = Array<Any>()
        var i = 0
        while  i < 10 {
            let cellModel = CXJIndexCellModel()
            cellModel.images = ["https://pic3.zhimg.com/v2-5b6c5eafee7eafc4aad79b3a207b0a3a.jpg"]
            cellModel.title = "LIGO 观测到双中子星合并，面对浩瀚宇宙，人类终于耳聪目明了"
            datas.append(cellModel)
            i += 1
        }
        return datas as! [CXJIndexCellModel]
    }()
    
}


//MARK: - @protocol UITableViewDelegate
extension CXJIndexVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return CXJIndexCell.getIndexCellHeight()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.tableView {
            let y = self.tableView.contentOffset.y
            self.setBarBackgroundColor(backColor: UIColor.init(white: 1.0, alpha: y/100))
        }
    }
    
}

//MARK: - @protocol UITableViewDataSource
extension CXJIndexVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CXJIndexCellID, for: indexPath) as! CXJIndexCell
        cell.cellModel = self.datas[indexPath.row]
        
        return cell
    }
}

