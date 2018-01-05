//
//  UIConstantColor.swift
//  CivilizationGuards
//
//  Created by sfzx on 2017/8/1.
//  Copyright © 2017年 陈鑫杰. All rights reserved.
//

import UIKit

class CXJConstantColor {
    /// 获取主题色
    class func getThemeColor() -> UIColor {
        return UIColor.hex2RGB(hex: "BBFFFF",alpha: 1.0)
    }
    
    //分割线颜色
    class func getDefaultSeperaterColor() -> UIColor {
        return UIColor.hex2RGB(hex: "DBDBDB", alpha: 1.0)
    }
    
    class var defaultSeperaterColor: UIColor {
        get{
            return UIColor.hex2RGB(hex: "DBDBDB", alpha: 1.0)
        }
    }
    
    
    
    //背景色
    class func getDefaultBackGroundColor() -> UIColor {
        return UIColor.hex2RGB(hex: "f1f1f1", alpha: 1.0)
    }
}


//MARK: - 导航栏
extension CXJConstantColor {
    //获取导航栏背景色
    class func getNaviBarBackGroundColor() -> UIColor {
        return UIColor.hex2RGB(hex: "f1f1f1", alpha: 1.0)
    }
    
    //导航栏按钮默认颜色
    class func getNaviButtonNormalColor() -> UIColor {
        return UIColor.black
    }
    
    //导航栏标题颜色
    class func getNaviBarTitleColor() -> UIColor {
        return UIColor.black
    }
}


//MARK: - 首页
extension CXJConstantColor {
    //日报标题正常颜色
    class  func getDailyTitleColor_nor() -> UIColor {
        return UIColor.black
    }
    
    
    //日报标题已读颜色
    class  func getDailyTitleColor_read() -> UIColor {
        return UIColor.lightGray
    }
    
    
    //首页轮播标题颜色
    class  func getSlideTitleColor() -> UIColor {
        return UIColor.white
    }
}

