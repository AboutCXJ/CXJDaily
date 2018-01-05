//
//  Config.swift
//  CXJDaily
//
//  Created by sfzx on 2017/8/22.
//  Copyright © 2017年 陈鑫杰. All rights reserved.
//

import Foundation

//基本接口
let baseUrl: String = "https://news-at.zhihu.com/api/4/"


/// 拼接完整接口
///
/// - Parameter api: 接口
/// - Returns: 完整接口
func CXJApi(api: String) -> String {
    return "\(baseUrl)\(api)"
}
