//
//  UIAlertController(show).swift
//  SwiftDemo01
//
//  Created by sunwf on 2017/2/7.
//  Copyright © 2017年 sunwf. All rights reserved.
//

import Foundation
import UIKit


extension UIAlertController {
    
    class func  getCurrentVC()->UIViewController {
        
        let result = UIAlertController.activityViewController()
        if result.isKind(of: UIAlertController.classForCoder()) {
            let aVC = UIViewController.init()
            return aVC
        }
        return result
    }
    
    
    class func activityViewController()->UIViewController {
    
       var result = UIViewController.init()

       var  window = UIApplication.shared.keyWindow
        

      if window?.windowLevel != UIWindowLevelNormal
     {
      let  windows = UIApplication.shared.windows
        
       for tmpWin in windows
      {
       if (tmpWin.windowLevel == UIWindowLevelNormal)
       {
        
         window = tmpWin
         break;
       }
      }
     }
    
       let frontView = window?.subviews.first
       if frontView == nil {
       return result
       }
    
       let nextResponder = frontView?.next
    
       if (nextResponder?.isKind(of: UIViewController.classForCoder()))!
      {
            result = nextResponder as! UIViewController
 
      }
      else
      {
            result = (window?.rootViewController)!

      }
    
         if result.isKind(of: UINavigationController.classForCoder()) {
          let  nav =  result as! UINavigationController
    
           return  nav.visibleViewController!
      }else
      {
           return result;
    
      }

    }
    
    func showAlert() -> Void {
        
        UIAlertController.getCurrentVC() .present(self, animated: true) { 
            
        }
    }
  
   
    

}
