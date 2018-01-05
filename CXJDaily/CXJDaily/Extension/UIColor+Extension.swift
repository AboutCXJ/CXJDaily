//
//  UIColor+Extension.swift
//  CXJDaily
//
//  Created by sfzx on 2017/10/9.
//  Copyright © 2017年 陈鑫杰. All rights reserved.
//

import UIKit


extension UIColor {
    
    
    /// 返回随机颜色
    class var randomColor: UIColor {
        get{
            let red = CGFloat(Double(arc4random()%256)/255.0)
            let greed = CGFloat(Double(arc4random()%256)/255.0)
            let blue = CGFloat(Double(arc4random()%256)/255.0)
            return UIColor(red: red, green: greed, blue: blue, alpha: 1.0)
        }
    }
    
    
    
    /// 16进制转RGB
    ///
    /// - Parameter hex: 16进制
    /// - Returns: RGB颜色
    class func hex2RGB(hex: String, alpha:CGFloat) -> UIColor {
        var newHex = hex.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if newHex.characters.count < 6 {
            return UIColor.clear
        }
        
        //判断前缀
        if newHex.hasPrefix("0x") {
            //            newHex = newHex.substring(from: newHex.index(after: newHex.index(after: newHex.startIndex)))
            newHex.remove(at: newHex.startIndex)
            newHex.remove(at: newHex.startIndex)
        }
        if newHex.hasPrefix("#") {
            //            newHex = newHex.substring(from: newHex.index(after: newHex.startIndex))
            newHex.remove(at: newHex.startIndex)
        }
        
        if newHex.characters.count != 6 {
            return UIColor.clear
        }
        
        
        
        // 从六位数值中找到RGB对应的位数并转换
        
        let rStr = "\(newHex[newHex.startIndex])\(newHex[newHex.index(after: newHex.startIndex)])"
        
        
        let gStart = newHex.index(newHex.startIndex, offsetBy: 2)
        let gEnd = newHex.index(newHex.startIndex, offsetBy: 3)
        let gStr = "\(newHex[gStart])\(newHex[gEnd])"
        
        
        let bStar = newHex.index(newHex.endIndex, offsetBy: -2)
        let bEnd = newHex.index(before: newHex.endIndex)
        let bStr = "\(newHex[bStar])\(newHex[bEnd])"
        
        
        
        var r: UInt32 = 0
        var g: UInt32 = 0
        var b: UInt32 = 0
        
        //16进制字符串转10进制int
        Scanner(string: rStr).scanHexInt32(&r)
        Scanner(string: gStr).scanHexInt32(&g)
        Scanner(string: bStr).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(Float(r) / 255.0), green: CGFloat(Float(g) / 255.0), blue: CGFloat(Float(b) / 255.0), alpha: alpha)
    }
}
