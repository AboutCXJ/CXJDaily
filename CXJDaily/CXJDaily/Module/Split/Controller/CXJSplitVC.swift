//
//  CXJSplitVC.swift
//  CXJDaily
//
//  Created by sfzx on 2017/8/21.
//  Copyright © 2017年 陈鑫杰. All rights reserved.
//

import UIKit

let orgin:CGFloat = 0//初始位置
let maxDistance = getScreenWidth()*0.7//最大偏移
let animateDuration = 0.1//动画时长



class CXJSplitVC: UIViewController {
    
    var distance: CGFloat = orgin//初始位置为0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(panAction))
        self.view.addGestureRecognizer(panGesture)
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //左视图
        self.leftView.snp.makeConstraints { (make) in
            make.height.equalTo(getScreenHeight())
            make.width.equalTo(getScreenWidth()*0.7)
            make.top.equalTo(self.view)
            make.left.equalTo(self.view).offset(-getScreenWidth()*0.7)
        }
        
        //右视图
        self.rightView.snp.makeConstraints { (make) in
            make.top.left.height.width.equalTo(self.view)
        }
    }
    
    
    
    
    //MARK: - handle
    @objc func panAction(panGesture: UIPanGestureRecognizer) {
        let moveX = panGesture.translation(in: self.view).x
        let truedistance = moveX + distance
        if truedistance > 0 && maxDistance > truedistance {
            leftView.transform = CGAffineTransform.init(translationX: truedistance, y: 0)
            rightView.transform = CGAffineTransform.init(translationX: truedistance, y: 0)
        }
        
        if panGesture.state == .ended{
            if truedistance <= maxDistance * 0.5{
                self.showRightView()
            }else{
                self.showLeftView()
            }
        }
        
    }
    
    
    @objc func showRightView() {
        UIView .animate(withDuration: animateDuration, animations: {
            self.leftView.transform = CGAffineTransform.identity
            self.rightView.transform = CGAffineTransform.identity
        }) { (finished) in
            self.distance = 0
            self.rightView.removeGestureRecognizer(self.tapGesture)
        }
    }
    
    func showLeftView() {
        UIView .animate(withDuration: animateDuration, animations: {
            self.leftView.transform = CGAffineTransform.init(translationX: maxDistance, y: 0)
            self.rightView.transform = CGAffineTransform.init(translationX: maxDistance, y: 0)
        }) { (finished) in
            self.distance = maxDistance
            self.rightView.addGestureRecognizer(self.tapGesture)
        }
    }
    
    //MARK: - 懒加载
    lazy var leftView: UIView = {
        let leftView = UIView.init()
        leftView.backgroundColor = .red
        self.view.addSubview(leftView)
//        self.addChildViewController()
        return leftView
    }()
    
    
    lazy var rightView: UIView = {
        let rightVC = CXJIndexVC()
        let rightNC = CXJBaseNC(rootViewController: rightVC)
        let rightView = rightNC.view!
        self.view.addSubview(rightView)
        self.addChildViewController(rightNC)
        return rightView
    }()
    
    lazy var tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(showRightView))
        return tapGesture
    }()
    
}
