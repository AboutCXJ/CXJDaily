//
//  CXJIndexCell.swift
//  CXJDaily
//
//  Created by sfzx on 2017/8/22.
//  Copyright © 2017年 陈鑫杰. All rights reserved.
//

import UIKit
//缩略图大小
let thumbnailSize = CGSize.init(width: Double(getWidthScaleWith6s()*100), height: Double(getHeightScaleWith6s()*80))

//间隔
let margin = getWidthScaleWith6s()*5



//MARK: - 模型
class CXJIndexCellModel {
    var images: Array<String>?
    var type: Int?
    var ID: Int?
    var ga_prefix: String?
    var title: String?
}



//MARK: - cell
class CXJIndexCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil) {
            self.selectionStyle = .none
            self.contentView.addSubview(self.titleLB)
            self.contentView.addSubview(self.thumbnail)
            self.contentView.addSubview(self.separatorLine)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.thumbnail.snp.makeConstraints { (make) in
            make.size.equalTo(thumbnailSize)
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(margin)
        }
        
        self.titleLB.snp.makeConstraints { (make) in
            make.top.equalTo(self.thumbnail)
            make.left.equalTo(self.contentView).offset(margin)
            make.right.equalTo(self.thumbnail.snp.left).offset(-margin)
        }
        
        self.separatorLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView)
            make.height.equalTo(0.5)
            make.left.equalTo(self.contentView.snp.left).offset(margin)
            make.right.equalTo(self.contentView.snp.right).offset(-margin)
        }
        
    }
    
    //获取cell高度
    class func getIndexCellHeight() -> CGFloat {
        return getHeightScaleWith6s()*80 + 2*margin
    }
    
    
    //MARK: - 赋值
    var cellModel: CXJIndexCellModel? {
        didSet{
            if let images = self.cellModel?.images {
                self.thumbnail.kf.setImage(with: URL.init(string: images.first!))
            }
            if let title = self.cellModel?.title {
                self.titleLB.text = title
            }
            
        }
    }
    
    
    
    //MARK: - 懒加载
    lazy var titleLB: UILabel = {
        let titleLB = UILabel.init(frame: .zero)
        titleLB.numberOfLines = 0
        titleLB.textColor = CXJConstantColor.getDailyTitleColor_nor()
        titleLB.font = CXJConstantFont.getDailyTitleFont()
        return titleLB
    }()
    
    lazy var thumbnail: UIImageView = {
        let thumbnail = UIImageView.init(frame: .zero)
        return thumbnail
    }()
    
    lazy var separatorLine: UIView = {
        let separatorLine = UIView.init(frame: .zero)
        separatorLine.backgroundColor = CXJConstantColor.getDefaultSeperaterColor()
        return separatorLine
    }()
    
}
