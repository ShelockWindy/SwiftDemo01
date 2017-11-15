//
//  CityModelMethod.swift
//  SwiftDemo01
//
//  Created by sunwf on 2017/1/18.
//  Copyright © 2017年 sunwf. All rights reserved.
//

import UIKit


/*
 *  城市模型
 */
class CityModel: NSObject {
    
    var cityId:String = "" //城市ID
    var cityName:String = "" //城市名
    var cityFullName:String = "" //城市全名
    var baiduCityId:String = "" //百度城市ID
    var weatherId:String = "" //天气ID
    var flag:String = ""  //flag
    var latitude:String = "" // 纬度
    var longitude:String = "" // 经度
    var cityArr:NSMutableArray =  NSMutableArray.init() //下一级 城市数组
    
    
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


class CityModelMethod: NSObject {
    
    private static let cityModelMethod = CityModelMethod()

    class func shareInstance() -> CityModelMethod {
        return cityModelMethod
    }
    
    
    func jsonToDic() -> NSMutableArray {
        
        let xmlFilePath:String  = Bundle.main.path(forResource: "IOSCityJson", ofType: "txt")!
        do { let myJSON:String =  try String.init(contentsOfFile: xmlFilePath, encoding:String.Encoding.utf8)
         
            let jsonData = myJSON.data(using: String.Encoding.utf8)
            var  arr = NSMutableArray.init()

            if (jsonData != nil) {
                
                do {
                    arr = try JSONSerialization.jsonObject(with: jsonData!, options:JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableArray
                    return arr
                } catch
                  {
                    
                  }
 
                }
                
        } catch {}
        return NSMutableArray.init()
    }
    
    //MARK: getTheCityArr-----------------------------------------------------------------------------------------------
    func  getTheCityArr() -> NSMutableArray {
        let   arr:NSMutableArray =  self.jsonToDic()
        let  arrMu:NSMutableArray = NSMutableArray.init();
        
        for i in arr
        {
            let cityDic:NSMutableDictionary = i as! NSMutableDictionary;
            let model:CityModel = CityModel.init(dict: cityDic)
            model.cityArr = NSMutableArray.init()
            let proArr:NSArray = cityDic.value(forKey: "city") as! NSArray
            
            for j in proArr
            {
                let proDic:NSDictionary = j as! NSDictionary
                let model1  = CityModel.init(dict: proDic)
                model1.cityArr = NSMutableArray.init()
                let thirdArr = proDic.value(forKey: "dist") as! NSArray
                
                for k in thirdArr
                {
                    let thirdDic = k as! NSDictionary
                    let model2 = CityModel.init(dict: thirdDic)
                    model1.cityArr.add(model2)
                    
                }
                
                
                if thirdArr.count <= 0  {
                    let model2 = CityModel.init()
                    model2.flag = model1.flag
                    model2.cityId = model1.cityId
                    model2.cityName = ""
                    model2.cityFullName = model1.cityFullName
                    model2.latitude = model1.latitude
                    model2.longitude = model1.longitude
                    model2.weatherId = model1.weatherId
                    model1.cityArr.add(model2)
                    
                }
                
                model.cityArr.add(model1)
                
                
            }
            
            arrMu.add(model)
            
            
        }
        
        let thirdArr = NSMutableArray.init()
        
        for i in arrMu
        {
            let model = i as! CityModel ;
            let model1 = CityModel.init();
            model1.flag = model.flag
            model1.cityName = "全境"
            model1.cityFullName = model.cityFullName
            model1.longitude = model.longitude
            model1.latitude = model.latitude
            model1.cityArr = NSMutableArray.init()
            model.cityArr.insert(model1, at: 0)
            for j in model.cityArr
            {
                let  model2 = j as! CityModel
                let  model3 = CityModel.init()
                model3.flag = model2.flag
                model3.cityId = model2.cityId
                model3.cityName = "全境"
                model3.weatherId = model2.weatherId
                model3.cityFullName = model2.cityFullName
                model3.latitude = model2.latitude
                model3.longitude = model2.longitude
                model2.cityArr.insert(model3, at: 0)
                
                
            }
            
            thirdArr.add(model)
            
        }
        
        
        return thirdArr;

        
    }

    //MARK: getThePostCityArr-----------------------------------------------------------------------------------------------
    func  getThePostCityArr() -> NSMutableArray {
        let   arr:NSMutableArray =  self.jsonToDic()
        let  arrMu:NSMutableArray = NSMutableArray.init();
        
        for i in arr
        {
            let cityDic:NSMutableDictionary = i as! NSMutableDictionary;
            let model:CityModel = CityModel.init(dict: cityDic)
            model.cityArr = NSMutableArray.init()
            let proArr:NSArray = cityDic.value(forKey: "city") as! NSArray
            
            for j in proArr
            {
                let proDic:NSDictionary = j as! NSDictionary
                let model1  = CityModel.init(dict: proDic)
                model1.cityArr = NSMutableArray.init()
                let thirdArr = proDic.value(forKey: "dist") as! NSArray
                
                for k in thirdArr
                {
                    let thirdDic = k as! NSDictionary
                    let model2 = CityModel.init(dict: thirdDic)
                    model1.cityArr.add(model2)
                    
                }
                
                
                if thirdArr.count <= 0  {
                    let model2 = CityModel.init()
                    model2.flag = model1.flag
                    model2.cityId = model1.cityId
                    model2.cityName = ""
                    model2.cityFullName = model1.cityFullName
                    model2.latitude = model1.latitude
                    model2.longitude = model1.longitude
                    model2.weatherId = model1.weatherId
                    model1.cityArr.add(model2)
                    
                }
                
                model.cityArr.add(model1)
                
                
            }
            
            arrMu.add(model)
            
            
        }
        
        
    
        return arrMu;
        
    }

    
    
}


enum  type {
    case   good
    case   bad
    case   normal
}


class RedView: UIView {
    
    
    var  name:String
    
    init(name:String) {
        self.name = name
       super.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        
//        self.backgroundColor = UIColor.red

    }
    
    
    init(goodType:type) {
        
        self.name = "eeee"
        print(name)
        super.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        self.backgroundColor = UIColor.init(hexColor: "0xcccccc")
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}



