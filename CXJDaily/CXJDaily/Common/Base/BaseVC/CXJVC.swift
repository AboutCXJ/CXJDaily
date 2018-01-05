//
//  CGBaseVC.swift
//  CivilizationGuards
//
//  Created by sfzx on 2017/8/1.
//  Copyright © 2017年 陈鑫杰. All rights reserved.
//

import UIKit

class CXJVC: CXJBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //默认背景色
        self.view.backgroundColor = CXJConstantColor.getDefaultBackGroundColor()
        
        //默认导航栏颜色
        self.setBarBackgroundColor(backColor: CXJConstantColor.getNaviBarBackGroundColor())
        
        //默认导航栏分割线颜色
        self.setNavBarShadowColor(shadowColor: .clear)
        
    }
    
    
    /// 添加返回按钮事件
    ///
    /// - Parameter selector: 事件（默认返回）
    func addBackButton(selector: Selector?) {
        if selector == nil {
            self.setNavBarLeftBtnSelector(selector: #selector(goBack))
        }else{
            self.setNavBarLeftBtnSelector(selector: selector!)
        }
        self.setBackButtonImage(image: CXJConstantImage.getBackImageNor(), lightImage: CXJConstantImage.getBackImageLight())
    }
    
    //返回按钮图片
    func setBackButtonImage(image: UIImage, lightImage: UIImage) {
        self.setNavBarLeftBtnImage(image: image)
        self.setNavBarLeftBtnLightImage(image: lightImage)
    }
    
    //返回
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
