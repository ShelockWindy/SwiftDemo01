//
//  GloabConst.swift
//  SwiftDemo01
//
//  Created by sunwf on 2017/2/7.
//  Copyright © 2017年 sunwf. All rights reserved.
//

import Foundation
import UIKit
    
let globalCityArr:NSMutableArray? = CityModelMethod.shareInstance().getTheCityArr()
    


/*
 *  代替宏的全局替换函数
 */

func hexColor(str:Int,l:CGFloat = 1) ->UIColor{
    
    //[self.tabBar setTintColor:[UIColor getColor:0x535353]];//用法
    
    return UIColor(red:CGFloat((str & 0xFF0000) >> 16) / 255.0,green: CGFloat((str & 0x00FF00) >> 8) / 255.0,blue: CGFloat(str & 0x0000FF) / 255.0,alpha: CGFloat(l))
    
}


func FixFont(fontSize:CGFloat) -> CGFloat {
    if UIScreen.main.bounds.size.width > 414 {
        return  fontSize*CGFloat(1.1)
    }else
    {
        return fontSize
    }
}




func FixGap(gap:CGFloat) -> CGFloat {
    return gap * UIScreen.main.bounds.size.width/375.0
}


func RGBACOLOR(r:Int,g:Int,b:Int,alpha:CGFloat)->UIColor
{
  return  UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
}


/// 获取UIEdgeInsets在水平方向上的值

func UIEdgeInsetsGetHorizontalValue(insets:UIEdgeInsets) -> CGFloat {

    return insets.left + insets.right
}

/// 获取UIEdgeInsets在垂直方向上的值

func UIEdgeInsetsGetVerticalValue(insets:UIEdgeInsets) -> CGFloat {
    
    return insets.left + insets.right
    
}

/// 将两个UIEdgeInsets合并为一个

func UIEdgeInsetsConcat(insets1:UIEdgeInsets,insets2:UIEdgeInsets)-> UIEdgeInsets {
    var insets = insets1
    insets.top = insets1.top + insets2.top
    insets.left = insets1.left + insets2.left
    insets.bottom = insets1.bottom + insets2.bottom
    insets.right = insets1.right + insets2.right
    
    return insets
}

func UIEdgeInsetsSetTop(insets:UIEdgeInsets,top:CGFloat)->UIEdgeInsets{
    
    var _insets = insets
    
    _insets.top = CGFloat(flatf(floatValue: Float(top)))
    
    return _insets
}

func UIEdgeInsetsSetTop(insets:UIEdgeInsets,left:CGFloat)->UIEdgeInsets{
    
    var _insets = insets
    
    _insets.left = CGFloat(flatf(floatValue: Float(left)))
    
    return _insets
}

func UIEdgeInsetsSetTop(insets:UIEdgeInsets,bottom:CGFloat)->UIEdgeInsets{
    
    var _insets = insets
    
    _insets.bottom = CGFloat(flatf(floatValue: Float(bottom)))
    
    return _insets
}

func UIEdgeInsetsSetTop(insets:UIEdgeInsets,right:CGFloat)->UIEdgeInsets{
    
    var _insets = insets
    
    _insets.right = CGFloat(flatf(floatValue: Float(right)))
    
    return _insets
}


/**
 *  CGRectSet
 */

func CGRectSetX(rect:CGRect,X:CGFloat)-> CGRect{
    var _rect = rect
    _rect.origin.x = CGFloat(flatf(floatValue: Float(X)))
    return _rect
}

func CGRectSetY(rect:CGRect,Y:CGFloat)-> CGRect{
    var _rect = rect
    _rect.origin.y = CGFloat(flatf(floatValue: Float(Y)))
    return _rect
}

func CGRectSetW(rect:CGRect,W:CGFloat)-> CGRect{
    var _rect = rect
    _rect.size.width = CGFloat(flatf(floatValue: Float(W)))
    return _rect
}

func CGRectSetH(rect:CGRect,H:CGFloat)-> CGRect{
    var _rect = rect
    _rect.size.height = CGFloat(flatf(floatValue: Float(H)))
    return _rect
}


func CGRectFlatted(rect:CGRect)-> CGRect{
    
    return CGRect.init(x: CGFloat(flatf(floatValue: Float(rect.origin.x))), y: CGFloat(flatf(floatValue: Float(rect.origin.y))), width: CGFloat(flatf(floatValue: Float(rect.size.width))), height: CGFloat(flatf(floatValue: Float(rect.size.height))))

}

func  CGRectFlatMake(rect:CGRect) -> CGRect {
    
    return CGRect.init(x: CGFloat(flatf(floatValue: Float(rect.origin.x))), y: CGFloat(flatf(floatValue: Float(rect.origin.y))), width: CGFloat(flatf(floatValue: Float(rect.size.width))), height: CGFloat(flatf(floatValue: Float(rect.size.height))))
}


/**
 *  方法-C对象、结构操作
 */

/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */

func  flatfSpecificScale(floatValue:Float,scale:Float)-> Float {
    var _scale = scale
      _scale = _scale == 0 ? Float(UIScreen.main.scale) :_scale
    let flattedValue = ceilf(floatValue * _scale) / _scale
    return flattedValue
    
}

/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flatf() 函数。
 */

func flatf(floatValue:Float)-> Float{
 
    return flatfSpecificScale(floatValue: floatValue, scale: 0)
}


/**
 *  类似flatf()，只不过 flatf 是向上取整，而 floorfInPixel 是向下取整
 */

func floorfInPixel(floatValue:Float)-> Float
{
    
    let  resultValue = (floorf(floatValue  * Float(UIScreen.main.scale)))/Float(UIScreen.main.scale)
    
    return resultValue
}


func betweenf(minimumValue:Float,value:Float,maximumValue:Float) -> Bool{
 
    return minimumValue < value && value < maximumValue
    
}


func betweenOrEqualf(minimumValue:Float,value:Float,maximumValue:Float) -> Bool{
    
    return minimumValue <= value && value <= maximumValue
}


/// 用于居中运算

func  CGFloatGetCenter(parent:CGFloat,child:CGFloat)-> CGFloat
{
    return CGFloat(flatf(floatValue: Float((parent - child) / 2.0)))
}

/// 两个point相加

func  CGPointUnion(point1:CGPoint,point2:CGPoint)-> CGPoint{
    
    return CGPoint.init(x:CGFloat(flatf(floatValue:Float(point1.x + point2.x))) , y: CGFloat(flatf(floatValue: Float(point1.y + point2.y))))
    
}


/// 获取rect的center，包括rect本身的x/y偏移

func CGPointGetCenterWithRect(rect:CGRect) -> CGPoint{
    
    return CGPoint.init(x: CGFloat(flatf(floatValue: Float(rect.midX ))), y: CGFloat(flatf(floatValue: Float(rect.midY))))
}


func CGPointGetCenterWithSize(size:CGSize) -> CGPoint{
    
    return CGPoint.init(x: CGFloat(flatf(floatValue:Float(size.width) / 2.0)), y: CGFloat(flatf(floatValue: Float(size.height) / 2.0)))
}


