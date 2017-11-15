//
//  JumpPageTool.swift
//  SwiftDemo01
//
//  Created by sunwf on 2017/2/8.
//  Copyright © 2017年 sunwf. All rights reserved.
//

import UIKit


class JumpPageTool: NSObject {

    /**
     *  实例对象
     *
     *  @return 实例
     */
    
    private static let instance = JumpPageTool()
    
    class func sharedJumpPageTool() -> JumpPageTool{
        return instance
    }

    func creatParamDictionary(paramString:String,webTitle:String) -> Void  {
    
        let nativeScheme:String = "topjet://"
        let safariScheme:String = "safari://"
        let webScheme:String = "http://"
        
        if paramString.hasPrefix(nativeScheme) {
            // 获得协议后面的路径  SendGoodsViewController?sendGoodsType=100&orderId=100
            let path = paramString.substring(from: nativeScheme.endIndex)
            // 利用?切割路径
            let  subpaths = path.components(separatedBy: "?")
            // 类名 className == SendGoodsViewController
            let className = subpaths.first
            // 参数  sendGoodsType=100&orderId=100
            var  keyValues:NSArray? = NSArray.init()
            if (subpaths.count == 2) {
                keyValues = subpaths.last?.components(separatedBy: "&") as NSArray?
            }
            
            let  jumpParamDictionary = NSMutableDictionary.init()
            let  propertysDic = NSMutableDictionary.init()
            //组成参数字典
            for paramString in keyValues! {
                let keyValue =   (paramString as! String).components(separatedBy: "=")
                propertysDic.setObject(keyValue.last!, forKey: keyValue.first as! NSCopying)
            }
            //组成页面跳转字典
            jumpParamDictionary.setObject(className!, forKey: "class" as NSCopying)
            jumpParamDictionary.setObject(propertysDic, forKey: "property" as NSCopying)
            //跳转界面
            self.pushViewControllerWithParams(params: jumpParamDictionary)

        }else if paramString.hasPrefix(safariScheme)
        {
            
        }else if paramString.hasPrefix(webScheme)
        {
            
        }
        
    }
    
    
    //检测对象是否存在该属性
    func checkIsExistProperty(instance:AnyObject,verifyPropertyName:String) -> Bool {
        
        var count: UInt32 = 0
        //获取类的属性列表,返回属性列表的数组,可选项
        let list = class_copyPropertyList(instance.classForCoder, &count)
        print("属性个数:\(count)")
        //遍历数组
        for i in 0..<Int(count) {
            //根据下标获取属性
            let pty = list?[i]
            //获取属性的名称<C语言字符串>
            //转换过程:Int8 -> Byte -> Char -> C语言字符串
            let cName = property_getName(pty!)
            //转换成String的字符串
            let name = String(utf8String: cName!)
            
            if name == verifyPropertyName {
                return true
            }
            
            print(name!)
        }
        free(list) //释放list
        
        return false;

    }
    
    
    func pushViewControllerWithParams(params:NSDictionary) -> Void {
        
        
       let vc =   self.getViewController(controllerName: "UIViewController", title: "aaaaa")
        
        
       UIApplication.shared.keyWindow?.rootViewController = vc
        
    }
    
    
    private func getViewController(controllerName : String,title : String) -> UIViewController{
        
        // 1.获取命名空间
        guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
            print("命名空间不存在")
            return UIViewController.init()
        }
        // 2.通过命名空间和类名转换成类
        let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + controllerName)
        
        // swift 中通过Class创建一个对象,必须告诉系统Class的类型
        guard let clsType = cls as? UITableViewController.Type else {
            print("无法转换成UITableViewController")
            return UIViewController.init()
        }
        
        // 3.通过Class创建对象
        let childController = clsType.init()
        
        // 设置TabBar和Nav的标题
        childController.title = title
        
        childController.view.backgroundColor = UIColor.blue
        
        return childController
        
    }
    
    
    
    func swiftClassFromString(className: String) -> UIViewController! {
        // get the project name
        if  let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String? {
            //拼接控制器名
            let classStringName = "\(appName).\(className)"
            //将控制名转换为类
            let classType = NSClassFromString(classStringName) as? UITabBarController.Type
            //if let type = classType 
            //{
                let newVC = classType?.init()
                return newVC
            //}
        }
        return nil;
    }

    
    
    func openWebViewController(requestURL:String,webTitle:String) -> Void {
        
    }
    
    func openSafari(requestURLString:String) -> Void {
        
        let redirectURL = NSURL.init(string: requestURLString.replacingOccurrences(of: "safari://", with: "http://")) as! URL

        if UIApplication.shared.canOpenURL(redirectURL) {
           
            UIApplication.shared.openURL(redirectURL)
        }

    }
    
    
}








