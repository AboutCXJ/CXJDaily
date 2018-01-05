//
//  BaseNC.swift
//  CivilizationGuards
//
//  Created by sfzx on 2017/8/1.
//  Copyright © 2017年 陈鑫杰. All rights reserved.
//

import UIKit

class CXJBaseNC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super .pushViewController(viewController, animated: animated)
    }
}
