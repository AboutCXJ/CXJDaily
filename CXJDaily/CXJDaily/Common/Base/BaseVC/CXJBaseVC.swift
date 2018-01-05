//
//  BaseVC.swift
//  CivilizationGuards
//
//  Created by sfzx on 2017/8/1.
//  Copyright © 2017年 陈鑫杰. All rights reserved.
//

import UIKit

fileprivate let BUTTON_DEFAULT_MARGIN = 5

class CXJBaseVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard ((self.navigationController?.navigationBar) != nil) else {
            return
        }
        self.setupNavBarContentViewChildView()
    }
    
    //设置自定义导航栏约束
    private  func setupNavBarContentViewChildView() {
        
        self.navigationController?.navigationBar.addSubview(navBarContentView)
        //导航栏
        self.navBarContentView.snp.makeConstraints({ (make) in
            make.height.equalTo(NAV_BAR_HEIGHT_44);
            if let bar = self.navigationController?.navigationBar{
                make.bottom.left.right.equalTo(bar)
            }
        })
        
        //左按钮
        self.navBarLeftBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: NAV_BAR_HEIGHT_44, height: NAV_BAR_HEIGHT_44))
            make.left.equalTo(self.navBarContentView).offset(BUTTON_DEFAULT_MARGIN);
            make.bottom.equalTo(self.navBarContentView);
        }
        
        //右按钮
        self.navBarRightBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: NAV_BAR_HEIGHT_44, height: NAV_BAR_HEIGHT_44))
            make.right.equalTo(self.navBarContentView).offset(-BUTTON_DEFAULT_MARGIN);
            make.bottom.equalTo(self.navBarContentView);
        }
        
        //标题
        self.navBarTitleLb.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.navBarContentView);
            make.height.equalTo(NAV_BAR_HEIGHT_44);
            make.bottom.equalTo(self.navBarContentView);
            make.width.equalTo(200);
        }
    }
    
    
    //MARK: - handle
    
    //设置导航栏分割线颜色
    func setNavBarShadowColor(shadowColor: UIColor) {
        let shadowImage = UIImage.imageWithColor(color: shadowColor)
        self.navigationController?.navigationBar.shadowImage = shadowImage
    }
    
    
    //设置导航栏背景
    func setBarBackgroundColor(backColor: UIColor) {
        let backImage = UIImage.imageWithColor(color: backColor)
        self.navigationController?.navigationBar.setBackgroundImage(backImage, for: .any, barMetrics: .default)
    }
    
    
    //设置标题
    func setNavBarTitle(title: String) {
        self.navBarTitleLb.text = title
    }
    
    //标题颜色
    func setNavBarTitleColor(titleColor: UIColor) {
        self.navBarTitleLb.textColor = titleColor
    }
    
    //左按钮事件
    func setNavBarLeftBtnSelector(selector: Selector) {
        self.navBarLeftBtn.removeTarget(self, action: nil, for: .touchUpInside)
        self.navBarLeftBtn.addTarget(self, action: selector, for: .touchUpInside)
    }
    
    //左按钮图片
    func setNavBarLeftBtnImage(image: UIImage) {
        self.navBarLeftBtn.setImage(image, for: .normal)
    }
    
    //左按钮高亮图片
    func setNavBarLeftBtnLightImage(image: UIImage) {
        self.navBarLeftBtn.setImage(image, for: .highlighted)
    }
    
    //左按钮标题
    func setNavBarLeftBtnTitle(title: String) {
        self.navBarLeftBtn.setTitle(title, for: .normal)
    }
    
    //设置左按钮宽度
    func updateNavBarLeftBtnWidth(width: CGFloat) {
        self.navBarLeftBtn.snp.updateConstraints { (make) in
            make.width.equalTo(width)
        }
    }
    
    
    
    //右按钮事件
    func setNavBarRightBtnSelector(selector: Selector) {
        self.navBarRightBtn.removeTarget(self, action: nil, for: .touchUpInside)
        self.navBarRightBtn.addTarget(self, action: selector, for: .touchUpInside)
    }
    
    //右按钮图片
    func setNavBarRightBtnImage(image: UIImage) {
        self.navBarRightBtn.setImage(image, for: .normal)
    }
    
    //右按钮高亮图片
    func setNavBarRightBtnLightImage(image: UIImage) {
        self.navBarRightBtn.setImage(image, for: .highlighted)
    }
    
    //右按钮标题
    func setNavBarRightBtnTitle(title: String) {
        self.navBarRightBtn.setTitle(title, for: .normal)
    }
    
    //右按钮失效标题
    func setNavBarRightBtnDisableTitle(title: String) {
        self.navBarRightBtn.setTitle(title, for: .disabled)
    }
    
    //设置右按钮宽度
    func updateNavBarRightBtnWidth(width: CGFloat) {
        self.navBarRightBtn.snp.updateConstraints { (make) in
            make.width.equalTo(width)
        }
    }
    
    
    
    //MARK: - 设置状态
    private var _statusBarStyle: UIStatusBarStyle = .default
    var statusBarStyle: UIStatusBarStyle {
        get{
            return _statusBarStyle
        }
        set{
            _statusBarStyle = newValue
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return _statusBarStyle
    }
    
    
    //重写title
    override var title: String?{
        get{
            return self.navBarTitleLb.text
        }
        set{
            self.navBarTitleLb.text = newValue
        }
    }
    
    
    //导航栏
    lazy var navBarContentView: UIView = {
        let navBarContentView = UIView()
        return navBarContentView
    }()
    

    //左按钮
    private lazy var navBarLeftBtn: UIButton = {
        let navBarLeftBtn = UIButton()
        navBarLeftBtn.titleLabel?.font = CXJConstantFont.getFontW6_H17()
        navBarLeftBtn.setTitleColor(CXJConstantColor.getNaviButtonNormalColor(), for: UIControlState.normal)
        self.navBarContentView.addSubview(navBarLeftBtn)
        return navBarLeftBtn
    }()
    
    //右按钮
    private lazy var navBarRightBtn: UIButton = {
        let navBarRightBtn = UIButton()
        navBarRightBtn.titleLabel?.font = CXJConstantFont.getFontW6_H17()
        navBarRightBtn.setTitleColor(CXJConstantColor.getNaviButtonNormalColor(), for: UIControlState.normal)
        self.navBarContentView.addSubview(navBarRightBtn)
        return navBarRightBtn
    }()
    
    //标题
    private lazy var navBarTitleLb: UILabel = {
        let navBarTitleLb = UILabel()
        navBarTitleLb.textAlignment = NSTextAlignment.center
        navBarTitleLb.font = CXJConstantFont.getFontW9_H17()
        navBarTitleLb.textColor = CXJConstantColor.getNaviBarTitleColor()
        self.navBarContentView.addSubview(navBarTitleLb)
        return navBarTitleLb
    }()
}
