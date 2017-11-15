//
//  UIButton(Layout).swift
//  SwiftDemo01
//
//  Created by sunwf on 2017/2/10.
//  Copyright © 2017年 sunwf. All rights reserved.
//

import Foundation
import UIKit


/// 控制图片在UIButton里的位置，默认为QMUIButtonImagePositionLeft

enum QMUIButtonImagePosition {
   case  Top     // imageView在titleLabel上面
   case  Left    // imageView在titleLabel左边
   case  Bottom  // imageView在titleLabel下面
   case  Right   //imageView在titleLabel右边
}


   class QMButton: UIButton {
        
    var imageSpace:Float = 0
    
    var _imagePosition:QMUIButtonImagePosition?

    var imagePosition:QMUIButtonImagePosition? {
        set{
            
            _imagePosition = newValue
            self.setNeedsLayout()
        }
        get{
           return _imagePosition
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.imagePosition = QMUIButtonImagePosition.Top
        self.didInitialized()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Methods
    
    func didInitialized() -> Void{
        
        
        // iOS7以后的button，sizeToFit后默认会自带一个上下的contentInsets，为了保证按钮大小即为内容大小，这里直接去掉，改为一个最小的值。
        // 不能设为0，否则无效；也不能设置为小数点，否则无法像素对齐
        self.contentEdgeInsets = UIEdgeInsetsMake(1, 0, 1, 0);
        
        // 图片默认在按钮左边，与系统UIButton保持一致
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 如果调用 sizeToFit，那么传进来的 size 就是当前按钮的 size，此时的计算不要去限制宽高
        
        var tempSize = size
        
        if __CGSizeEqualToSize(self.bounds.size, tempSize)
        {
            tempSize = CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        }
        
        var resultSize = CGSize.zero
        
        let contentLimitSize = CGSize.init(width: tempSize.width - UIEdgeInsetsGetHorizontalValue(insets: self.contentEdgeInsets), height: size.height - UIEdgeInsetsGetVerticalValue(insets: self.contentEdgeInsets))
        
        
        
        switch self.imagePosition! {
        
        case .Top,.Bottom:
            // 图片和文字上下排版时，宽度以文字或图片的最大宽度为最终宽度
            let imageLimitWidth = contentLimitSize.width - UIEdgeInsetsGetHorizontalValue(insets: self.imageEdgeInsets)
            let imageSize = self.imageView?.sizeThatFits(CGSize.init(width: imageLimitWidth, height: CGFloat.greatestFiniteMagnitude))
            let titleLimitSize = CGSize.init(width: contentLimitSize.width - UIEdgeInsetsGetHorizontalValue(insets: self.titleEdgeInsets), height: contentLimitSize.height - UIEdgeInsetsGetVerticalValue(insets: self.imageEdgeInsets) - (imageSize?.height)! - UIEdgeInsetsGetVerticalValue(insets: self.titleEdgeInsets))
            var titleSize = self.titleLabel?.sizeThatFits(titleLimitSize)
            titleSize?.height = CGFloat(fminf(Float((titleSize?.height)!), Float(titleLimitSize.height)))
            resultSize.width = UIEdgeInsetsGetHorizontalValue(insets: self.contentEdgeInsets)
            resultSize.width = resultSize.width + CGFloat(fmaxf(Float(UIEdgeInsetsGetHorizontalValue(insets: self.imageEdgeInsets) + (imageSize?.width)! ), Float(UIEdgeInsetsGetHorizontalValue(insets: self.imageEdgeInsets) + (titleSize?.width)! )))
            
            
             resultSize.height = UIEdgeInsetsGetVerticalValue(insets: self.contentEdgeInsets) + UIEdgeInsetsGetVerticalValue(insets: self.imageEdgeInsets) + (imageSize?.height)! + UIEdgeInsetsGetVerticalValue(insets: self.titleEdgeInsets) + (titleSize?.height)!
            
            
            break;
        case .Left,.Right:
            
            if self.imagePosition! == .Left && self.titleLabel?.numberOfLines == 1 {
                
                // QMUIButtonImagePositionLeft使用系统默认布局
                
                 resultSize = super.sizeThatFits(tempSize)
            }else
            {
                // 图片和文字水平排版时，高度以文字或图片的最大高度为最终高度
                //                // titleLabel为多行时，系统的sizeThatFits计算结果依然为单行的，所以当QMUIButtonImagePositionLeft并且titleLabel多行的情况下，使用自己计算的结果
                
                let imageLimitHeight = contentLimitSize.height - UIEdgeInsetsGetVerticalValue(insets: self.imageEdgeInsets)
                let imageSize = self.imageView?.sizeThatFits(CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: imageLimitHeight))
                let titleLimitSize = CGSize.init(width: contentLimitSize.width - UIEdgeInsetsGetHorizontalValue(insets: self.titleEdgeInsets) - (imageSize?.width)! - UIEdgeInsetsGetHorizontalValue(insets: self.imageEdgeInsets), height: contentLimitSize.height - UIEdgeInsetsGetVerticalValue(insets: self.titleEdgeInsets))
                
                var titleSize = self.titleLabel?.sizeThatFits(titleLimitSize)
                titleSize?.height = CGFloat(fminf(Float((titleSize?.height)!), Float(titleLimitSize.height)))
                
                resultSize.width = UIEdgeInsetsGetHorizontalValue(insets: self.contentEdgeInsets) + UIEdgeInsetsGetHorizontalValue(insets: self.imageEdgeInsets) + (imageSize?.width)! + UIEdgeInsetsGetHorizontalValue(insets: self.titleEdgeInsets) + (titleSize?.width)!
                
                resultSize.height = UIEdgeInsetsGetVerticalValue(insets: self.contentEdgeInsets)
                resultSize.height = resultSize.height + CGFloat(fmaxf(Float(UIEdgeInsetsGetVerticalValue(insets: self.imageEdgeInsets) + (imageSize?.height)!)  , Float(UIEdgeInsetsGetVerticalValue(insets: self.titleEdgeInsets) + (titleSize?.height)!)))
                
                
            }
            
            break
        
        }
        return resultSize
        
        }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if  self.bounds == CGRect.zero {
            return
        }
        
        if self.imagePosition == QMUIButtonImagePosition.Left {
            
            self.imageView?.frame = CGRect.init(x: (self.imageView?.frame.origin.x)! - CGFloat(imageSpace/2), y: (self.imageView?.frame.origin.y)!, width: (self.imageView?.frame.size.width)!, height: (self.imageView?.frame.size.height)!)
            
            self.titleLabel?.frame = CGRect.init(x: (self.titleLabel?.frame.origin.x)! + CGFloat(imageSpace/2), y: (self.titleLabel?.frame.origin.y)!, width: (self.titleLabel?.frame.size.width)!, height: (self.titleLabel?.frame.size.height)!)
            
            
            
            return
        }
        
        let contentSize = CGSize.init(width: self.bounds.width - UIEdgeInsetsGetHorizontalValue(insets: self.contentEdgeInsets), height: self.bounds.height - UIEdgeInsetsGetVerticalValue(insets: self.contentEdgeInsets))
        
        
        if self.imagePosition == QMUIButtonImagePosition.Top || self.imagePosition == QMUIButtonImagePosition.Bottom {
            
            let  imageLimitWidth = contentSize.width - UIEdgeInsetsGetHorizontalValue(insets: self.imageEdgeInsets)
            let imageSize = self.imageView?.sizeThatFits(CGSize.init(width: imageLimitWidth, height: CGFloat.greatestFiniteMagnitude))
            var imageFrame = CGRect.init(origin: CGPoint.zero, size: imageSize!)
            
            let titleLimitSize = CGSize.init(width: contentSize.width - UIEdgeInsetsGetHorizontalValue(insets: self.titleEdgeInsets), height: contentSize.height - UIEdgeInsetsGetVerticalValue(insets: self.titleEdgeInsets))
            var titleSize = self.titleLabel?.sizeThatFits(titleLimitSize)
            titleSize?.height = CGFloat(fminf(Float((titleSize?.height)!), Float(titleLimitSize.height)))
                
            var titleFrame = CGRect.init(origin: CGPoint.zero, size: titleSize!)
            
            switch self.contentHorizontalAlignment {
            case .left:
                
                imageFrame = CGRectSetX(rect: imageFrame, X: self.contentEdgeInsets.left + self.imageEdgeInsets.left)
                titleFrame = CGRectSetX(rect: titleFrame, X: self.contentEdgeInsets.left + self.titleEdgeInsets.left)
                
                break
                
            case .center:
                
                imageFrame = CGRectSetX(rect: imageFrame, X: self.contentEdgeInsets.left + self.imageEdgeInsets.left + CGFloatGetCenter(parent: imageLimitWidth, child: (imageSize?.width)!))
                
                titleFrame = CGRectSetX(rect: titleFrame, X: self.contentEdgeInsets.left + self.titleEdgeInsets.left + CGFloatGetCenter(parent: titleLimitSize.width, child: (titleSize?.width)!))
                
                break
            case .fill:
                
                imageFrame = CGRectSetX(rect: imageFrame, X: self.contentEdgeInsets.left + self.imageEdgeInsets.left)
                imageFrame = CGRectSetW(rect: imageFrame, W: imageLimitWidth)
                titleFrame = CGRectSetX(rect: titleFrame, X: self.contentEdgeInsets.left + self.titleEdgeInsets.left)
                titleFrame = CGRectSetW(rect: titleFrame, W: titleLimitSize.width)
                
                break
                
            case .right:
                
                imageFrame = CGRectSetX(rect: imageFrame, X: self.bounds.width - self.contentEdgeInsets.right - self.imageEdgeInsets.right - (imageSize?.width)!)
                
                titleFrame = CGRectSetX(rect: titleFrame, X: self.bounds.width - self.contentEdgeInsets.right - self.titleEdgeInsets.right - (titleSize?.width)!)
                

                break;

                
            case .leading:
                break;
            case .trailing:
                break;
            }
            
            
            if self.imagePosition == QMUIButtonImagePosition.Top {
                
                switch self.contentVerticalAlignment {
                case .top:
                    imageFrame = CGRectSetY(rect: imageFrame, Y: self.contentEdgeInsets.top + self.imageEdgeInsets.top)
                    titleFrame = CGRectSetY(rect: titleFrame, Y: imageFrame.maxY + self.imageEdgeInsets.bottom + self.titleEdgeInsets.top)
                    break;
                case .center:
                    let contentHeight = imageFrame.height + UIEdgeInsetsGetVerticalValue(insets: self.imageEdgeInsets) + titleFrame.height + UIEdgeInsetsGetVerticalValue(insets: self.titleEdgeInsets)
                    let minY = CGFloatGetCenter(parent: contentSize.height, child: contentHeight) + self.contentEdgeInsets.top
                    imageFrame = CGRectSetY(rect: imageFrame, Y: minY + self.imageEdgeInsets.top);
                    titleFrame = CGRectSetY(rect: titleFrame, Y: imageFrame.maxY + self.imageEdgeInsets.bottom + self.titleEdgeInsets.top)
                
                break;
                case .bottom:
                    titleFrame = CGRectSetY(rect: titleFrame, Y: self.bounds.height - self.contentEdgeInsets.bottom - self.titleEdgeInsets.bottom - titleFrame.height)
                    imageFrame = CGRectSetY(rect: imageFrame, Y: titleFrame.minY - self.titleEdgeInsets.top - self.imageEdgeInsets.bottom - imageFrame.height)
                    break;
                case .fill:
                    // 图片按自身大小显示，剩余空间由标题占满
                    imageFrame = CGRectSetY(rect: imageFrame, Y: self.contentEdgeInsets.top + self.imageEdgeInsets.top)
                    titleFrame = CGRectSetY(rect: titleFrame, Y: imageFrame.maxY + self.imageEdgeInsets.bottom + self.titleEdgeInsets.top)
                    titleFrame = CGRectSetH(rect: titleFrame, H: self.bounds.height - self.contentEdgeInsets.bottom - self.titleEdgeInsets.bottom - titleFrame.minY)
                    break;
                }

                
                
            }else
            {
                switch (self.contentVerticalAlignment) {
                case .top:
                    titleFrame = CGRectSetY(rect: titleFrame, Y: self.contentEdgeInsets.top + self.titleEdgeInsets.top)
                    imageFrame = CGRectSetY(rect: imageFrame, Y: titleFrame.maxY + self.titleEdgeInsets.bottom + self.imageEdgeInsets.top)
                    break
                case .center:
                    let contentHeight = titleFrame.height + UIEdgeInsetsGetVerticalValue(insets: self.titleEdgeInsets) + imageFrame.height + UIEdgeInsetsGetVerticalValue(insets: self.imageEdgeInsets)
                    let minY = CGFloatGetCenter(parent: contentSize.height, child: contentHeight) + self.contentEdgeInsets.top;
                    titleFrame = CGRectSetY(rect: titleFrame, Y: minY + self.titleEdgeInsets.top)
                    imageFrame = CGRectSetY(rect: imageFrame, Y: titleFrame.maxY + self.titleEdgeInsets.bottom + self.imageEdgeInsets.top)
                
                break
                case .bottom:
                    imageFrame = CGRectSetY(rect: imageFrame, Y: self.bounds.height - self.contentEdgeInsets.bottom - self.imageEdgeInsets.bottom - imageFrame.height)
                    titleFrame = CGRectSetY(rect: titleFrame, Y: imageFrame.minY - self.imageEdgeInsets.top - self.titleEdgeInsets.bottom - titleFrame.height)
                    
                    break
                case .fill:
                    // 图片按自身大小显示，剩余空间由标题占满
                    imageFrame = CGRectSetY(rect: imageFrame, Y: self.bounds.height - self.contentEdgeInsets.bottom - self.imageEdgeInsets.bottom - imageFrame.height)
                    titleFrame = CGRectSetY(rect: titleFrame, Y: self.contentEdgeInsets.top + self.titleEdgeInsets.top)
                    
                    titleFrame = CGRectSetH(rect: titleFrame, H: imageFrame.minY - self.imageEdgeInsets.top - self.titleEdgeInsets.bottom - titleFrame.minY)
                    break
                }

            }
            
            self.imageView?.frame = CGRectFlatted(rect: imageFrame)
            self.titleLabel?.frame = CGRectFlatted(rect: titleFrame)

            
            if  _imagePosition == QMUIButtonImagePosition.Top {
                
                
                self.imageView?.frame = CGRect.init(x: (self.imageView?.frame.origin.x)! , y: (self.imageView?.frame.origin.y)! - CGFloat(imageSpace/2), width: (self.imageView?.frame.size.width)!, height: (self.imageView?.frame.size.height)!)
                
                self.titleLabel?.frame = CGRect.init(x: (self.titleLabel?.frame.origin.x)! , y: (self.titleLabel?.frame.origin.y)! + CGFloat(imageSpace/2), width: (self.titleLabel?.frame.size.width)!, height: (self.titleLabel?.frame.size.height)!)
                
                
                
            }else if _imagePosition == QMUIButtonImagePosition.Bottom
            {
                
                self.imageView?.frame = CGRect.init(x: (self.imageView?.frame.origin.x)! , y: (self.imageView?.frame.origin.y)! + CGFloat(imageSpace/2), width: (self.imageView?.frame.size.width)!, height: (self.imageView?.frame.size.height)!)
                
                self.titleLabel?.frame = CGRect.init(x: (self.titleLabel?.frame.origin.x)! , y: (self.titleLabel?.frame.origin.y)! - CGFloat(imageSpace/2), width: (self.titleLabel?.frame.size.width)!, height: (self.titleLabel?.frame.size.height)!)
                
                
                
            }

            
            
        }
        
        
       else  if self.imagePosition == QMUIButtonImagePosition.Right {
            
            
            let imageLimitHeight = contentSize.height - UIEdgeInsetsGetVerticalValue(insets: self.imageEdgeInsets)
            
            let imageSize = self.imageView?.sizeThatFits(CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: imageLimitHeight))// 假设图片宽度必定完整显示，高度不超过按钮内容
            var imageFrame = CGRect.init(origin: CGPoint.zero, size: imageSize!)
            
            let titleLimitSize =  CGSize.init(width: contentSize.width - UIEdgeInsetsGetHorizontalValue(insets: self.titleEdgeInsets) - imageFrame.width - UIEdgeInsetsGetHorizontalValue(insets: self.imageEdgeInsets) , height: contentSize.height - UIEdgeInsetsGetVerticalValue(insets: self.titleEdgeInsets))
            
            
            var  titleSize = self.titleLabel?.sizeThatFits(titleLimitSize)
            titleSize?.height = CGFloat(fminf(Float((titleSize?.height)!), Float(titleLimitSize.height)))
            var  titleFrame = CGRect.init(origin: CGPoint.zero, size: titleSize!)

            switch self.contentHorizontalAlignment {
            case .left:
                titleFrame = CGRectSetX(rect: titleFrame, X: self.contentEdgeInsets.left + self.titleEdgeInsets.left)
                imageFrame = CGRectSetX(rect: imageFrame, X: titleFrame.maxX + self.titleEdgeInsets.right + self.imageEdgeInsets.left);
                break
            case .center:
                let contentWidth = titleFrame.width + UIEdgeInsetsGetHorizontalValue(insets: self.titleEdgeInsets) + imageFrame.width + UIEdgeInsetsGetHorizontalValue(insets: self.imageEdgeInsets);
                let minX = self.contentEdgeInsets.left + CGFloatGetCenter(parent: contentSize.width, child: contentWidth);
                titleFrame = CGRectSetX(rect: titleFrame, X: minX + self.titleEdgeInsets.left);
                imageFrame = CGRectSetX(rect: imageFrame, X: titleFrame.maxX + self.titleEdgeInsets.right + self.imageEdgeInsets.left);

                titleFrame = CGRectSetX(rect: titleFrame, X: minX + self.titleEdgeInsets.left);
                imageFrame = CGRectSetX(rect: imageFrame, X: titleFrame.maxX + self.titleEdgeInsets.right + self.imageEdgeInsets.left);
                
                
            break
            case .right:
                imageFrame = CGRectSetX(rect: imageFrame, X: self.bounds.width - self.contentEdgeInsets.right - self.imageEdgeInsets.right - imageFrame.width);
                titleFrame = CGRectSetX(rect: titleFrame, X: imageFrame.minX - self.imageEdgeInsets.left - self.titleEdgeInsets.right - titleFrame.width)
                break;
            case .fill:
                // 图片按自身大小显示，剩余空间由标题占满
                imageFrame = CGRectSetX(rect: imageFrame, X: self.bounds.width - self.contentEdgeInsets.right - self.imageEdgeInsets.right - imageFrame.width)
                titleFrame = CGRectSetX(rect: titleFrame, X: self.contentEdgeInsets.left + self.titleEdgeInsets.left)
               
                titleFrame = CGRectSetW(rect: titleFrame,  W: imageFrame.minX - self.imageEdgeInsets.left - self.titleEdgeInsets.right - titleFrame.minX)
                break
            case .leading:
                break;
            case .trailing:
                break;
            }

            
            
            switch (self.contentVerticalAlignment) {
            case .top:
                titleFrame = CGRectSetY(rect: titleFrame, Y: self.contentEdgeInsets.top + self.titleEdgeInsets.top);
                imageFrame = CGRectSetY(rect: imageFrame, Y: self.contentEdgeInsets.top + self.imageEdgeInsets.top);
                break;
            case .center:
                titleFrame = CGRectSetY(rect: titleFrame, Y: self.contentEdgeInsets.top + self.titleEdgeInsets.top + CGFloatGetCenter(parent: contentSize.height, child: titleFrame.height + UIEdgeInsetsGetVerticalValue(insets: self.titleEdgeInsets)));
                imageFrame = CGRectSetY(rect: imageFrame, Y: self.contentEdgeInsets.top + self.imageEdgeInsets.top + CGFloatGetCenter(parent: contentSize.height, child: imageFrame.height + UIEdgeInsetsGetVerticalValue(insets: self.imageEdgeInsets)));
                break;
            case .bottom:
                titleFrame = CGRectSetY(rect: titleFrame, Y: self.bounds.height - self.contentEdgeInsets.bottom - self.titleEdgeInsets.bottom - titleFrame.height);
                imageFrame = CGRectSetY(rect: imageFrame, Y: self.bounds.height - self.contentEdgeInsets.bottom - self.imageEdgeInsets.bottom - imageFrame.height);
                break;
            case .fill:
                titleFrame = CGRectSetY(rect: titleFrame, Y: self.contentEdgeInsets.top + self.titleEdgeInsets.top);
                titleFrame = CGRectSetH(rect: titleFrame, H: self.bounds.height - self.contentEdgeInsets.bottom - self.titleEdgeInsets.bottom - titleFrame.minY);
                imageFrame = CGRectSetY(rect: imageFrame, Y: self.contentEdgeInsets.top + self.imageEdgeInsets.top);
                imageFrame = CGRectSetH(rect: imageFrame, H: self.bounds.height - self.contentEdgeInsets.bottom - self.imageEdgeInsets.bottom - imageFrame.minY);
                break;
            }

            self.imageView?.frame = CGRectFlatted(rect: imageFrame)
            self.titleLabel?.frame = CGRectFlatted(rect: titleFrame)
            
            self.imageView?.frame = CGRect.init(x: (self.imageView?.frame.origin.x)! + CGFloat(imageSpace/2), y: (self.imageView?.frame.origin.y)!, width: (self.imageView?.frame.size.width)!, height: (self.imageView?.frame.size.height)!)
            
            self.titleLabel?.frame = CGRect.init(x: (self.titleLabel?.frame.origin.x)! - CGFloat(imageSpace/2), y: (self.titleLabel?.frame.origin.y)!, width: (self.titleLabel?.frame.size.width)!, height: (self.titleLabel?.frame.size.height)!)

            
        }
        
        
        
        
        
    }
   
    
}
