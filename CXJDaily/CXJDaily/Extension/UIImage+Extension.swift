//
//  UIImage+Extension.swift
//  CXJDaily
//
//  Created by sfzx on 2017/10/9.
//  Copyright © 2017年 陈鑫杰. All rights reserved.
//

import UIKit

extension UIImage {
    
    //ya s
    class func imageWithColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
