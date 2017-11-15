//
//  UserLocationManager.swift
//  SwiftDemo01
//
//  Created by sunwf on 2017/2/6.
//  Copyright © 2017年 sunwf. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentLocation: NSObject,NSCoding{
    
    var latitude_WGS84: Float?//纬度
    var longitude_WGS84: Float?//经度
    var latitude_Baidu:Float?//百度纬度
    var longitude_Baidu:Float?//百度经度
    var address:String = ""//此位置的地址名称
    var citycode:String = ""//百度的城市代码
    var timestamp:NSDate? //最后一次获取位置的时间
    var cityname:String = "" //百度的城市名称
    var provincename:String = ""//省名称
    var districtname:String = ""//地区名称
    var locationCityCode:String = ""//城市ID
    var locationArrearId:String = ""//中国天气网ID
    
    //解归档
    
    override init()
    {
        super.init()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init()
        
        self.latitude_WGS84 = aDecoder.decodeFloat(forKey: "latitude_WGS84")
        self.longitude_WGS84 = aDecoder.decodeFloat(forKey: "longitude_WGS84")
        self.latitude_Baidu = aDecoder.decodeFloat(forKey: "latitude_Baidu")
        self.longitude_Baidu = aDecoder.decodeFloat(forKey: "longitude_Baidu")
        self.address = aDecoder.decodeObject(forKey: "address") as! String
        self.citycode = aDecoder.decodeObject(forKey: "citycode") as! String
        self.timestamp = aDecoder.decodeObject(forKey: "timestamp") as? NSDate
        self.cityname = aDecoder.decodeObject(forKey: "cityname") as! String
        self.provincename = aDecoder.decodeObject(forKey: "provincename") as! String
        self.districtname = aDecoder.decodeObject(forKey: "districtname") as! String
        self.locationCityCode = aDecoder.decodeObject(forKey: "locationCityCode") as! String
        self.locationArrearId = aDecoder.decodeObject(forKey: "locationArrearId") as! String
        
    }
    
   //归档
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(latitude_WGS84, forKey: "latitude_WGS84")
        aCoder.encode(longitude_WGS84, forKey: "longitude_WGS84")
        aCoder.encode(latitude_Baidu, forKey: "latitude_Baidu")
        aCoder.encode(longitude_Baidu, forKey: "longitude_Baidu")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(citycode, forKey: "citycode")
        aCoder.encode(timestamp, forKey: "timestamp")
        aCoder.encode(cityname, forKey: "cityname")
        aCoder.encode(provincename, forKey: "provincename")
        aCoder.encode(districtname, forKey: "districtname")
        aCoder.encode(locationCityCode, forKey: "locationCityCode")
        aCoder.encode(locationArrearId, forKey: "locationArrearId")
        
    }
    
    
    
}


//---------------------------------------------------------------------------------------------------------------------------

typealias FinshLocationHandle = (_ currentLocation:CurrentLocation) -> Void
typealias LocationCallBack = (_ currentLocation:CurrentLocation, _ errorMsg:String) -> Void



class UserLocationManager: NSObject,CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager?
    var currentLocation:CurrentLocation? = CurrentLocation.init()
    var finishHandle:FinshLocationHandle?//用于上传位置
    var successHandle:FinshLocationHandle?//用于成功定位
    var locationCallBack:LocationCallBack?
    var taskIdentifier:UIBackgroundTaskIdentifier?
    
    private var  lastUpdateDate:NSDate? //上次位置变化时间
    
    
    
    private static var locationManager = UserLocationManager()

    class func shareInstance() -> UserLocationManager {
        return  locationManager
    }
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager.init()
        self.locationManager?.delegate = self
        self.currentLocation? = CurrentLocation.init()
        
    }
    
    class func geocoderOfBaiduMapWithCLLocationCoordinate(Coordinate:CLLocationCoordinate2D,returnBlock:((_ detailAddress:String)->Void)) {
        
        var la:Double? = Double.init()
        var lo:Double? = Double.init()
        
       WGS84_to_Baidu09(Coordinate.latitude, Coordinate.longitude, &la!, &lo!)
        
        
    }
    
    
    func geocoderOfBaidu(latitude_WGS:Double,longitude_WGS:Double,returnBlock:@escaping (_ locationDic:NSDictionary)->Void ) {
    
        let strSecrectKey:String = "MvZqz8rIDxvAis3GgPccQvuBqHX8g0T5"
        let strQueryParams1:String = String.init(format: "/geocoder/v2/?ak=hbv2S0xvY3YgD2BKSYfMDLkr&coordtype=wgs84ll&location=%f,%f&output=json&pois=0", latitude_WGS,longitude_WGS)
        
        let strQueryParams2:String = self.encodeURL(string: String.init(format: "%@%@", strQueryParams1,strSecrectKey))
        let strUrl:String = String.init(format: "https://api.map.baidu.com%@&sn=%@", strQueryParams1,self.md5String(str: strQueryParams2))
        
        print("用于地址逆编码请求的URL：%@",strUrl)
        
        let request:NSMutableURLRequest = NSMutableURLRequest.init(url: NSURL.init(string: strUrl) as! URL)
        request.timeoutInterval = 15
        request.httpMethod = "GET"
        let queue:OperationQueue = OperationQueue.init()
        
        
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: queue) { ( response , data , error) in
            
            if error == nil
            {
                //回到主线程
                let mainQueue = DispatchQueue.main
                mainQueue.async {
                   
                    let resultDic:NSMutableDictionary =  try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
                    
                    print(resultDic)
                    
                    let status = (resultDic.object(forKey: "status") as? NSNumber )?.stringValue
                    
                    if status != "0"
                    {
                        returnBlock(NSDictionary.init())
                    }else
                    {
                        returnBlock(resultDic.object(forKey: "result") as! NSDictionary)
                    }
                    
                    
                }
                
                
            }
        }
        
        
        
    }
    
    
    func startGetCurrentLocationWithLocationCallBack(locationCallBack:@escaping LocationCallBack) -> Void {
        
        self.locationManager = CLLocationManager.init()
        self.locationCallBack = locationCallBack
        self.locationManager?.pausesLocationUpdatesAutomatically = false
        self.locationManager?.delegate = self
        
        self.locationManager?.distanceFilter  = 1000
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager?.stopUpdatingLocation()
        self.locationManager?.startUpdatingLocation()
     

        
    }
    
   //MARK: CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation:CLLocation = locations.last!
        
        // If it's a relatively recent event, turn off updates to save power
        let  eventDate = newLocation.timestamp as NSDate
        let nowRecent =  eventDate.timeIntervalSince1970
        let  lastRecent =  lastUpdateDate?.timeIntervalSince1970
        let needUpdateLoaction:Bool?

        if lastUpdateDate == nil
        {
            needUpdateLoaction = true
        }else
        {
            needUpdateLoaction = (nowRecent - lastRecent! ) > 180.0 //默认3分钟之内的位置可以不用上传
        }
        
        let location = CurrentLocation.init()
        lastUpdateDate = newLocation.timestamp as NSDate?
        
        if newLocation.coordinate.latitude == 0 || newLocation.coordinate.longitude == 0
        {
            return

        }
        
        location.latitude_WGS84 =  Float(newLocation.coordinate.latitude)
        location.longitude_WGS84 = Float(newLocation.coordinate.longitude)
    
        location.timestamp = eventDate
        var la:Double? = Double.init()
        var lo:Double? = Double.init()
        
        WGS84_to_Baidu09(newLocation.coordinate.latitude , newLocation.coordinate.longitude, &la!, &lo!)

        location.latitude_Baidu = Float(la!)
        location.longitude_Baidu = Float(lo!)
        
        
        self.geocoderOfBaidu(latitude_WGS: newLocation.coordinate.latitude, longitude_WGS: newLocation.coordinate.longitude) { (locationDic ) in
   
            let  decodeResult = locationDic
            
            let  addressComponent = decodeResult.object(forKey: "addressComponent") as? NSDictionary
            
            //let  cityname = addressComponent?.object(forKey: "city") as? String
            location.provincename = (addressComponent?.object(forKey: "province") as?  String)!
            location.cityname = (addressComponent?.object(forKey: "city") as?  String)!
            location.districtname = (addressComponent?.object(forKey: "district") as?  String)!
            location.address = (decodeResult.object(forKey: "formatted_address") as? String)!
            
            let  objCode = (decodeResult.object(forKey: "cityCode") as! NSNumber ).stringValue 
            location.citycode = objCode
            
            if location.citycode.lengthOfBytes(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) > 0
            {
                self.getCityIDStrByDistrict(district: location.districtname, location: location)
            }
            
            self.currentLocation = location
            self.locationCallBack?(location,"")
            
            if self.taskIdentifier != UIBackgroundTaskInvalid
            {
                return;
            }
            
            self.beingBackgroundUpdateTask()
            
            if (needUpdateLoaction)!
            {
                self.finishHandle!(self.currentLocation!)
               
                print("正在更新位置")
            }
            //TODO HTTP upload
            
            //上传完成记得调用
            self.endBackgroundUpdateTask()
            
            self.successHandle!(self.currentLocation!)
           

            
            
        }
        
      
        
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        if  self.locationCallBack != nil  {

            self.locationCallBack?(self.currentLocation!,"定位失败")

        }
        
    }
    
    
    func getCityIDStrByDistrict(district:String , location:CurrentLocation) -> Void {
        
        let districtStr = String.init(format: "%@", district)
        
        if district.lengthOfBytes(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) > 0 {
            
            for i in  globalCityArr!
            {
                let mode = i as! CityModel
                
                for j in mode.cityArr
                {
                    let mode1 = j as! CityModel
                    if mode1.baiduCityId == location.citycode {
                        location.locationCityCode = mode1.cityId
                        for k in mode1.cityArr
                        {
                            let model2 = k as! CityModel
                            if (model2.cityFullName == districtStr || model2.cityName == districtStr) {
                                location.locationCityCode = model2.cityId;
                                location.locationArrearId = model2.weatherId;
                                break;
                            }

                        }

                    }
                    
                    
                }

            }
            

            
            
        }
        
    }
    
    
    
    func getLocationServiceOpened() -> Bool {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways,.denied:
            return false
            break
            
        default:
            return true
        }
        
        return true
    }
    
    
    func openLBSTipsAlert() -> Void {
        switch CLLocationManager.authorizationStatus() {
        case .restricted,.denied:
            
            
            let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String

            let alertVC = UIAlertController.init(title: "", message: String.init(format: "\"%@\"想获取您的位置，允许的话请在设置->隐私->位置中开启", appName), preferredStyle: .alert)
            alertVC.addAction(UIAlertAction.init(title: "知道了", style: .default, handler: { (action) in
                
            }))
            
            
            alertVC.showAlert()
            
           
            break
            
        default:
            break

        }

    }
    
    
    
    //MARk: -对URL编码的处理
    func encodeURL(string:String)  -> String
    {
        let unescapedString:String = string
        let escapedUrlString = self.escape(string: unescapedString)
        
        return escapedUrlString

    }
    
    func escape(string: String) -> String {
        let legalURLCharactersToBeEscaped: CFString = "!*'();:@&=+$,/?%#[]" as CFString
        return CFURLCreateStringByAddingPercentEscapes(nil, string as CFString!, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }
    
    func md5String(str:String) -> String{
        let cStr = str.cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
    
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< 16{
            md5String.appendFormat("%02x", buffer[i])
        }
        free(buffer)
        return md5String as String
    }
    
    func beingBackgroundUpdateTask() -> Void {
        
        self.taskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: { 
            self.endBackgroundUpdateTask()
        })
    }
    
    
    func endBackgroundUpdateTask() -> Void {
        
        if self.taskIdentifier != UIBackgroundTaskInvalid {
            UIApplication.shared.endBackgroundTask(self.taskIdentifier!)
            self.taskIdentifier = UIBackgroundTaskInvalid
        }
        
    }
    
}
