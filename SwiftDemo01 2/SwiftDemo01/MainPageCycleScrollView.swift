//
//  MainPageCycleScrollView.swift
//  SwiftDemo01
//
//  Created by sunwf on 2017/2/9.
//  Copyright © 2017年 sunwf. All rights reserved.
//

import UIKit


/*
 *  模型
 */

class  AdvertisementInfo: NSObject {
    
    let  advertisementID:String? = ""      //广告id
    let  pictureURL:String? = ""          //展示图片URL
    let  redirectURL:String?  = ""     //重定向URL
    let  pictureKey:String?  = ""     //图片Key
    let  webTitle:String? = ""
    
    override init() {
        super.init()
        
    }
    
    init(dict : NSDictionary) {
        
        // 使用KVC字典转模型必须先调用super.init()
        super.init()
        
        // 调用setValuesForKeysWithDictionary
        setValuesForKeys(dict as! [String : Any])
        
    }
    
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}


/*
 *  Cell
 */


class CycleScrolCollectionCell: UICollectionViewCell {
    
    var imageView:UIImageView? = UIImageView.init()
    var info:AdvertisementInfo?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.imageView = UIImageView.init(frame: self.bounds)
        self.addSubview(imageView!)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


protocol MainPageCycleScrollViewDelegate {
    
    func mainPageCycleScrollViewDidSelectCell(ScrollView:MainPageCycleScrollView,index:NSInteger) -> Void
}



class MainPageCycleScrollView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var _imageUrlArray:NSMutableArray?

    var imageUrlArray:NSMutableArray?{
        get{
            return _imageUrlArray
        }
        set{
            if (imageUrlArray?.count)! < 2 {
                _pageControl?.isHidden = true
            }else
            {
                _pageControl?.isHidden = false
            }
            
            _imageUrlArray = newValue
            
            if (_imageUrlArray?.count)! > 0 {
                let  firstUrl =  _imageUrlArray?.firstObject
                let  lastUrl = _imageUrlArray?.lastObject
                
                if firstUrl != nil {
                    _imageUrlArray?.insert(lastUrl ?? "", at: 0)
   
                }
                
                if lastUrl != nil
                {
                    _imageUrlArray?.add(firstUrl ?? "")

                }
                
                _collectionView?.reloadData()
                _pageControl?.numberOfPages = (_imageUrlArray?.count)! - 2
            }
 
        }
    }
    
    var delegate:MainPageCycleScrollViewDelegate?
    var _collectionView:UICollectionView? = nil
    var _layout:UICollectionViewFlowLayout? = nil
    var _pageControl:UIPageControl? = nil
    var _timer:Timer? = nil //定时器
    var _duration:timeval? = nil //间隔
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //设置collectionView
        _layout = UICollectionViewFlowLayout()
        _layout?.minimumLineSpacing = 0 //item间距为0
        _layout?.minimumInteritemSpacing = 0 //行间距为0
        _layout?.itemSize = CGSize.init(width: frame.size.width, height: frame.size.height)
        _layout?.scrollDirection =  .horizontal
        
        
        _collectionView =  UICollectionView(frame: self.bounds, collectionViewLayout: _layout!)
        _collectionView?.delegate = self;
        _collectionView?.dataSource = self;
        _collectionView?.showsVerticalScrollIndicator = false
        _collectionView?.showsHorizontalScrollIndicator = false
        _collectionView?.backgroundColor = UIColor.clear
        _collectionView?.isPagingEnabled = true
        _collectionView?.bounces = false
        _collectionView?.contentOffset = CGPoint.init(x: frame.size.width, y: 0)
        _collectionView?.register(CycleScrolCollectionCell.classForCoder(), forCellWithReuseIdentifier: "CycleImageCollectionViewCell")
        self.addSubview(_collectionView!)
        
        
        //设置 pageControl
        _pageControl = UIPageControl.init(frame: CGRect.init(x: 30, y: self.frame.size.height-11, width: self.frame.size.width-60, height: 0))
        _pageControl?.isUserInteractionEnabled = false
        _pageControl?.pageIndicatorTintColor = RGBACOLOR(r: 153, g: 153, b: 153, alpha: 0.5)
        _pageControl?.currentPage = 1
        self.addSubview(_pageControl!)
      
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: -UICollectionViewDelegate,UICollectionViewDataSource
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
     {
        return (imageUrlArray?.count)!
     }
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
     {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CycleImageCollectionViewCell", for: indexPath) as! CycleScrolCollectionCell
        
        let info = imageUrlArray?.object(at: indexPath.row) as! AdvertisementInfo
        cell.info = info
        
        //MARK: warn!!!
        let data = NSData.init(contentsOf: NSURL.init(string: info.pictureURL!) as! URL)
        cell.imageView?.image = UIImage.init(data: data as! Data)
       
        
        return cell
        
     }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
     {
         return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
     }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.mainPageCycleScrollViewDidSelectCell(ScrollView: self, index: indexPath.row)
        
    }
    
    
    
    func autoScollImageView() -> Void {
        
        let currentPage = (_collectionView?.contentOffset.x)! / self.frame.size.width
        
        if (_collectionView?.contentOffset.x)! >=  CGFloat(self.frame.size.width) * CGFloat((imageUrlArray?.count)! - 2)
        {
           
            _collectionView?.scrollToItem(at:  NSIndexPath.init(item: 0, section: 0) as IndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
        }
       
        
        _collectionView?.scrollToItem(at:  NSIndexPath.init(item: Int(currentPage) + 1, section: 0) as IndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        
    }
    
    
    
    func openTimerToScroll() -> Void {
        
        if (imageUrlArray?.count)! <  2 {
            return
        }
       
        _timer?.invalidate()
        _timer = nil;
        
        
        _timer = Timer.init(timeInterval: 3, target: self, selector: #selector(MainPageCycleScrollView.autoScollImageView), userInfo: nil, repeats: true)
        
        RunLoop.main.add(_timer!, forMode: RunLoopMode.commonModes)
        
    }
    
    func closeTimerToScroll() -> Void {
        _timer?.invalidate()
        _timer = nil;
    }
    
    
    
    //MARK:ScrollViewDeleagte
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x >= scrollView.contentSize.width - self.bounds.size.width
        {
            scrollView.contentOffset = CGPoint.init(x: self.bounds.size.width, y: scrollView.contentOffset.y)
            _pageControl?.currentPage = 0
        
        }else if scrollView.contentOffset.x < self.bounds.size.width {
            
        }else
        {
            _pageControl?.currentPage = Int( scrollView.contentOffset.x / self.bounds.size.width) - 1
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x < self.bounds.size.width {
            
            _collectionView?.scrollToItem(at: NSIndexPath.init(index: (_pageControl?.numberOfPages)!) as IndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
            
        }
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        _timer?.invalidate()
        _timer = nil

    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        self.openTimerToScroll()
    }
    
}


