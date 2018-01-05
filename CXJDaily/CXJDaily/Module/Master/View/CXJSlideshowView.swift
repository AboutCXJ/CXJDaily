//
//  SlideshowView.swift
//  CivilizationGuards
//
//  Created by sfzx on 2017/8/7.
//  Copyright © 2017年 陈鑫杰. All rights reserved.
//

import UIKit

let CXJSlideCellID = "CXJSlideCellID"


/// 轮播
class CXJSlideshowView: UIView {
    var timer: Timer!//定时器
    var currentIndex: Int = 0//当前位置
    var timeInterval: Double!//轮播时间间隔
    
    var cube: ((CXJSlideModel) -> Void)?//点击cell的block
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(frame: CGRect, slides: [CXJSlideModel],timeInterval: Double) {
        self.init(frame: frame)
        self.slides = slides
        self.timeInterval = timeInterval
        //处理数据--添加头尾
//        if slides.count > 1 {
            let firstItem = slides.first
            let lastItem = slides.last
            self.slides.insert(lastItem!, at: 0)
            self.slides.append(firstItem!)
//        }
        self.setTimer()
        self.addSubview(self.collectionView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.top.left.equalTo(self)
        }
        
        self.pageCtr.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.left.bottom.width.equalTo(self)
        }
        
        //让collection滚动到第二张
        if self.slides.count > 1 {
            self.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .right, animated: false)
            self.currentIndex = 1
        }else{
            self.currentIndex = 0
        }
    }
    
    //    MARK: - 懒加载
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: self.layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CXJSlideCell.self, forCellWithReuseIdentifier: CXJSlideCellID)
        return collectionView
    }()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    lazy var pageCtr: UIPageControl = {
        let pageCtr = UIPageControl()
        if self.slides.count > 1{
            pageCtr.numberOfPages = self.slides.count - 2
        }else{
            pageCtr.numberOfPages = 1
        }
        pageCtr.isUserInteractionEnabled = false
        pageCtr.pageIndicatorTintColor = UIColor(white: 1.0, alpha: 0.3)
        pageCtr.currentPageIndicatorTintColor = UIColor.white
        self.addSubview(pageCtr)
        return pageCtr
    }()
    
    
    lazy var slides: [CXJSlideModel] = {
        var slides = [CXJSlideModel]()
        return slides
    }()

}


//MARK: - 定时器
extension CXJSlideshowView {
    /// 设置定时器
    func setTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: self.timeInterval, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer, forMode: .commonModes)
    }
    
    /// 定时器事件
    @objc func timeAction() {
        //单张图片不滚动
        if self.slides.count == 1 {
            return
        }
        
        if self.currentIndex == self.slides.count - 2  || self.currentIndex == self.slides.count - 1{
            self.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .left, animated: false)
        }else{
            self.collectionView.scrollToItem(at: IndexPath(row: self.currentIndex + 1, section: 0), at: .right, animated: false)
        }
        
        //FIXME:pageCtr很慢 collection动画的原因
        self.scrollViewDidEndDecelerating(self.collectionView)
    }
    
    /// 关闭定时器
    func closeTimer() {
        self.timer.invalidate()
    }

}

//MARK: - @protocol UICollectionViewDelegate
extension CXJSlideshowView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.currentIndex = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        
        if (self.currentIndex == self.slides.count - 1) {
            self.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .left, animated: false)
            self.pageCtr.currentPage = 0
        }else if (self.currentIndex == 0) {
            self.collectionView.scrollToItem(at: IndexPath(row: self.slides.count - 2, section: 0), at: .right, animated: false)
            self.pageCtr.currentPage = self.slides.count - 2
        }else{
            self.pageCtr.currentPage = self.currentIndex - 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cube = self.cube {
            cube(self.slides[indexPath.row])
        }
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.closeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.setTimer()
    }
}

//MARK: - @protocol UICollectionViewDataSource
extension CXJSlideshowView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.slides.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CXJSlideCellID, for: indexPath) as! CXJSlideCell
        cell.cellModel = (indexPath.row < self.slides.count) ? self.slides[indexPath.row] : nil
        return cell
    }
    
}

//MARK: - @protocol UICollectionViewDelegateFlowLayout
extension CXJSlideshowView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
