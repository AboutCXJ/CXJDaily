//
//  Func.swift
//  CivilizationGuards
//
//  Created by sfzx on 2017/8/1.
//  Copyright © 2017年 陈鑫杰. All rights reserved.
//

import UIKit


/// 获取屏幕宽度
func getScreenWidth() -> CGFloat {
    return UIScreen.main.bounds.size.width
}

/// 获取屏幕高度
func getScreenHeight() -> CGFloat {
    return UIScreen.main.bounds.size.height
}

/// 获取6s屏幕宽度
func get6sWidth() -> CGFloat {
    return 375
}

/// 获取6s屏幕宽度
func get6sHeight() -> CGFloat {
    return 667
}

/// 获取当前屏幕和6s的宽度比例
func getWidthScaleWith6s() -> CGFloat {
    return getScreenWidth() / get6sWidth()
}

/// 获取当前屏幕和6s的宽度比例
func getHeightScaleWith6s() -> CGFloat {
    return getScreenHeight() / get6sHeight()
}
