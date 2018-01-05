//
//  SlideCell.swift
//  CivilizationGuards
//
//  Created by sfzx on 2017/8/9.
//  Copyright © 2017年 陈鑫杰. All rights reserved.
//

import UIKit

let slideTitleMargin = getScreenWidth()*20


class CXJSlideModel: Codable {
    var image: String? //图片
    var type: Int? //类型
    var ID: Int?//id
    var ga_prefix: String?
    var title: String?//标题
    
    enum CodingKeys:String, CodingKey {
        case image
        case type
        case ID = "id"
        case ga_prefix
        case title
    }
}

class CXJSlideCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        if !self.isEqual(nil) {
            self.addSubview(self.imageView)
            self.addSubview(self.titleLB)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var cellModel: CXJSlideModel! {
        didSet{
            if let imageUrl = self.cellModel.image {
                self.imageView.kf.setImage(with: URL.init(string: imageUrl))
            }
            if let title = self.cellModel.title {
                self.titleLB.text = title
            }
            
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        self.titleLB.snp.makeConstraints { (make) in
            make.left.equalTo(slideTitleMargin)
            make.right.equalTo(self.contentView.snp.right).offset(-slideTitleMargin)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-slideTitleMargin)
        }
        
    }
    
    //    MARK: - 懒加载
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.white
        return imageView
    }()

    
    lazy var titleLB: UILabel = {
        let titleLB = UILabel.init(frame: .zero)
        titleLB.textColor = CXJConstantColor.getSlideTitleColor()
        titleLB.font = CXJConstantFont.getSlideTitleFont()
        return titleLB
    }()
}
