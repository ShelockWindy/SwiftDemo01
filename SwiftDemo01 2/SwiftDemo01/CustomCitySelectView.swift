//
//  CustomCitySelectView.swift
//  SwiftDemo01
//
//  Created by sunwf on 2017/1/18.
//  Copyright © 2017年 sunwf. All rights reserved.
//

import UIKit


enum CityArrayType {
  case  GloabCityArr
  case  PostCityArr
  case  LocalWeatherCityArr
  case  SmartGoods
}


 /*
  * 城市选择后的代理方法
  */

protocol CustomCitySelectViewDelegate {
    func customCitySelectViewDidSelectItem(atIndexPath:NSIndexPath,modelForItem:CityModel, view:UIView) -> Void
}


typealias FinishHideHandle = (Void) ->Void


public class CustomCitySelectView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var  _selectCityName:String?
    var  selectCityName:String{
        set{
            _selectCityName = newValue
        }
        get{
        
            //2.2重新定义城市选择后的显示名称
            
            if (self.secondModel?.cityFullName.contains((self.firstModel?.cityFullName)!))! {
                
                if (self.thirdModel?.cityFullName.contains("全境"))! || (self.thirdModel?.cityFullName.lengthOfBytes(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)))! > 0 {
                    
                    _selectCityName = String.init(format: "%@",self.dealShortCityNameWithCityName(cityName: (self.secondModel?.cityFullName)!) )
                }else
                {
                    _selectCityName = String.init(format: "%@ %@", self.dealShortCityNameWithCityName(cityName: (self.secondModel?.cityFullName)!),(self.thirdModel?.cityFullName)!)
                    
                }
            }else
            {
                if (self.thirdModel?.cityFullName.contains("全境"))! || (self.thirdModel?.cityFullName.lengthOfBytes(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)))! > 0 {
                    
                    _selectCityName = String.init(format: "%@",(self.firstModel?.cityFullName)!, self.dealShortCityNameWithCityName(cityName: (self.secondModel?.cityFullName)!) )
                }else
                {
                    _selectCityName = String.init(format: "%@ %@", self.dealShortCityNameWithCityName(cityName: (self.secondModel?.cityFullName)!),(self.thirdModel?.cityFullName)!)
                    
                }

            }
            
            _selectCityName = _selectCityName?.replacingOccurrences(of: "省", with: "")
            
          return _selectCityName!
        }
    }//选择的城市
    var  selectCityCode:String = "" //选择的城市ID
    var  _province:String?
    var  province:String  {
        set{
            _province = newValue
        }
        
        get{
            return firstTitle
        }
        
    }  //选择的省
    var  _city:String?
    var  city:String
    {
        set{
            _city = newValue
        }
        get{
           return _city!
        }
    } //选择的市
    
    var _distrit:String?
    var  distrit:String {
        set{
            _distrit = newValue
        }
        get{
            return _distrit!
        }
        
    }//选择的区
    var  firstModel:CityModel? = CityModel.init() //选择的一级模型
    var  secondModel:CityModel? = CityModel.init() //选择的二级模型
    var  thirdModel:CityModel? = CityModel.init() //选择的三级模型
    var  _cityType:CityArrayType?
    var  cityType:CityArrayType? {
        set{
            
            _cityType = newValue
            
            switch _cityType! {
            case .PostCityArr:
             cityArrays =   CityModelMethod.shareInstance().getThePostCityArr()
                break
            case .GloabCityArr:
                
                break
            case .LocalWeatherCityArr:
                
                break
            case .SmartGoods:
                
                break
            default:
                break
                
            }
            
        }
        get{
            
            return _cityType!
        }

    }//城市数据源类型
    var  delegate:CustomCitySelectViewDelegate?  //代理
    var  isShow:Bool = false //
    var  isNeedThirdLeve:Bool = true //默认显示支持三级选择， false 只能选择到二级城市
    var  isNeedAutoHide:Bool = true //点击屏幕其他区域是否消失
    var  isNeedAnnimation:Bool = true //消失的时候是否需要动画
    var  mainTintColor:UIColor?  //主题颜色
    var  hideHandle:FinishHideHandle? //消失后的回调
    
    
    private var titleBtnArr:NSMutableArray = NSMutableArray.init()
    private var borderLineArr:NSMutableArray = NSMutableArray.init()
    private var menuViewHeight:CGFloat = 0.0
    private var cityArrays:NSMutableArray? = NSMutableArray.init()
    private var _firstDataSource:NSMutableArray? = NSMutableArray.init()
    private var _secondDataSource:NSMutableArray? = NSMutableArray.init()
    private var _thirdDataSource:NSMutableArray? = NSMutableArray.init()
    private var _collectionDataSource:NSMutableArray = NSMutableArray.init()
    private var selectModel:CityModel?
    private var currentSelectLevel:NSInteger = 0
    private var currentSeletIndex:NSInteger = 0;
    private var itemWidth:CGFloat = 0.0
    private var itemHeight:CGFloat = 0.0
    private var _collectionView:UICollectionView?
    private var tipsLable:UILabel = UILabel.init()
    private var firstTitle:String = ""
    private var secondTitle:String = ""
    private var thirdTitle:String = ""
    private var space:CGFloat = 0.0
    private var orginY:CGFloat = 0.0 //菜单起点y坐标
    

    init() {
        
        
        super.init(frame: CGRect.init(x: FixGap(gap: 20), y: 0, width: UIScreen.main.bounds.size.width - 40, height: 0))

        self.setDisplay()
    }
    
    
   convenience init(type:CityArrayType) {
        
        self.init()
    }
    
    

//
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setDisplay() -> Void {
        
        space = 0
        self.mainTintColor = UIColor.blue
        menuViewHeight = self.frame.size.height
        itemWidth = self.bounds.size.width  / 4
        itemHeight = FixGap(gap: 46)
        
        let  titleArray:NSArray = ["省","市","区"]
   
        cityType = CityArrayType.GloabCityArr
        cityArrays = CityModelMethod.shareInstance().getTheCityArr()
        
        let  titleBtnBG:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: itemHeight))
        titleBtnBG.tag = 1400
        let  titleWidth:CGFloat = self.bounds.size.width/3
        

        //布局城市菜单
        let layout:UICollectionViewFlowLayout =
        UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize.init(width: itemWidth, height: itemHeight)
        
        _collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: itemHeight+space-1.5, width: self.bounds.size.width, height: self.frame.size.height - itemHeight), collectionViewLayout: layout)
        _collectionView?.delegate  = self
        _collectionView?.dataSource = self
        _collectionView?.tag = 650
        _collectionView?.isScrollEnabled = true
        
        //注册Cell，必须要有
        _collectionView?.register(CityCollectionCell.self, forCellWithReuseIdentifier: "CityCollectionCell");
        
        self.addSubview(_collectionView!);

        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
        
        _collectionView?.layer.cornerRadius = 3
        _collectionView?.layer.masksToBounds = true
        
        for  i in 0 ..< titleArray.count
        {
            let selectBtn:UIButton = UIButton.init(type: .custom)
            selectBtn.frame = CGRect.init(x: CGFloat(i)*titleWidth, y: 0, width: self.bounds.size.width/3, height: itemHeight)
            selectBtn.setTitle(titleArray.object(at: i) as? String , for: .normal)
            selectBtn.titleLabel?.font = UIFont.systemFont(ofSize: FixFont(fontSize: 20));
            selectBtn.setTitleColor(UIColor.black, for: .normal);
            selectBtn.tag = 500+i;
            selectBtn.backgroundColor = UIColor.white;
            selectBtn.addTarget(self, action: #selector(CustomCitySelectView.selectCityAreaAction), for: .touchUpInside)
            titleBtnBG.addSubview(selectBtn);
            titleBtnArr.add(selectBtn)
        }
        self.addSubview(titleBtnBG)
        
        //添加提示
        tipsLable = UILabel.init();
        tipsLable.backgroundColor = UIColor.white.withAlphaComponent(0.85);
        tipsLable.font = UIFont.systemFont(ofSize: FixFont(fontSize: 16));
        tipsLable.textAlignment = .center;
        tipsLable.isHidden = true;
        tipsLable.textColor = UIColor.red;
        tipsLable.layer.cornerRadius = 3;
        tipsLable.layer.masksToBounds = true;
        self.addSubview(tipsLable)
        


    }
    
    
    //MARK: -切换 省 市 区
    func selectCityAreaAction(sender:UIButton) -> Void {
        
        switch sender.tag {
        case 500:
            print("选择省");
            currentSelectLevel = 0;
            _firstDataSource = cityArrays;
            firstModel = nil;
            secondModel = nil;
            thirdModel = nil;
            _collectionDataSource = _firstDataSource!;
            _collectionView?.reloadData();
            currentSeletIndex = -1;
            
            let titleButt1 = titleBtnArr.object(at: 0) as! UIButton
            titleButt1.setTitle("省", for: .normal)
            
            let titleButt2 = titleBtnArr.object(at: 1) as! UIButton
            titleButt2.setTitle("市", for: .normal)
            
            let titleButt3 = titleBtnArr.object(at: 2) as! UIButton
            titleButt3.setTitle("区", for: .normal)
            
            break
        case  501:
            if ( currentSeletIndex == -1) && currentSelectLevel != 1 && currentSelectLevel != 2 {
                tipsLable.isHidden = false;
                tipsLable.text = "请先选择省";
                tipsLable.frame = CGRect.init(x: (self.frame.size.width-100)/2 , y: (self.frame.size.height-itemHeight)/2, width: 100, height: itemHeight)
                self.bringSubview(toFront: tipsLable)
                UIApplication.shared.keyWindow?.isUserInteractionEnabled = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    // your code here
                    UIApplication.shared.keyWindow?.isUserInteractionEnabled = true
                    self.tipsLable.isHidden = true
                }
              
                return;

            }
            
            //如果已经选择过二级，是从三级返回二级
            if (currentSelectLevel == 2) {
                thirdTitle = "";
                secondTitle = "";
                secondModel = nil;
                thirdModel = nil;
                currentSelectLevel = 1;
            }
            _collectionDataSource  = _secondDataSource!;
            _thirdDataSource = nil;
            _collectionView?.reloadData()
            
            break
        case  502:
            
            if ( currentSelectLevel != 2) {
                tipsLable.isHidden = false;
                tipsLable.text = "请先选择市";
                tipsLable.frame = CGRect.init(x: (self.frame.size.width-100)/2, y: (self.frame.size.height-itemHeight)/2, width: 100, height: itemHeight)
                self.bringSubview(toFront: tipsLable)
                UIApplication.shared.keyWindow?.isUserInteractionEnabled = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    UIApplication.shared.keyWindow?.isUserInteractionEnabled = true
                    self.tipsLable.isHidden = true
                })
                
                return;
            }
            _collectionDataSource  = _thirdDataSource!;
            _collectionView?.reloadData()
            break
        default:
            break
            
        }
        
        for i in titleBtnArr
        {
            let btn = i as! UIButton
            
            
            if btn.isEqual(sender) {
                btn.backgroundColor = self.mainTintColor
                btn.setTitleColor(UIColor.white, for: .normal)
            }else
            {
                btn.backgroundColor = UIColor.white
                btn.setTitleColor(self.mainTintColor, for: .normal)

            }
        }
        
        self.updateBorderLineFrame()
    }
    
    func updateBorderLineFrame() -> Void {
        var colum:Int = _collectionDataSource.count/4
        let remain:Int = _collectionDataSource.count % 4
        if (remain > 0) {
            colum += 1
        }
        menuViewHeight = (CGFloat(colum) + 1) * itemHeight + space
        
        let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        orginY = ( SCREEN_HEIGHT - (9 + 1 ) * itemHeight - 5 + space ) / 2
        self.frame = CGRect.init(x: self.frame.origin.x, y: orginY, width: self.bounds.size.width, height: menuViewHeight)
        _collectionView?.frame = CGRect.init(x: 0, y: itemHeight + space - 2, width: self.bounds.size.width, height: menuViewHeight - itemHeight - space)
        
        //update borderLines
        for  i in borderLineArr {
            let line = i as! UIView
            line.removeFromSuperview()
        }
        
        //画横线
        for i in 0 ..< colum {
            
            let  line = UIView.init(frame: CGRect.init(x: 0, y: itemHeight + itemHeight * CGFloat(i) + space, width: self.frame.size.width, height: 0.5))
            
            line.backgroundColor = UIColor.init(colorLiteralRed: 221/255, green: 221/255, blue: 221/255, alpha:1)
            
            self.addSubview(line)
            borderLineArr.add(line)
        }
        
        //画竖线
        for j in 0 ..< 4 {
            let line  = UIView.init(frame: CGRect.init(x: itemWidth * CGFloat(j), y:  itemHeight+space, width: 0.5, height: self.frame.size.height-itemHeight-space-2))
            
            
        
            if (j > remain&&remain > 0) {
                line.frame = CGRect.init(x: itemWidth * CGFloat(j), y:  itemHeight+space, width: 0.5, height: CGFloat(colum) * itemHeight - itemHeight - 0.5)
            }
            line.backgroundColor = UIColor.init(colorLiteralRed: 221/255, green: 221/255, blue: 221/255, alpha:1)
            self.addSubview(line)
            borderLineArr.add(line)
            
        }

    }
    
  
    //处理省市名
    func dealShortCityNameWithCityName(cityName:String) -> String {
        
        if  cityName.hasSuffix("市") {
            let index = cityName.index(cityName.endIndex, offsetBy: -1)
            return cityName.substring(to: index)
        } else
        {
            return cityName
        }
    }
    
    
    
    //MARK: -UICollectionViewDelegate,UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCollectionCell", for: indexPath) as! CityCollectionCell;
        
        let  model = _collectionDataSource.object(at: indexPath.row) as! CityModel  ;
        
        cell.titleLable.text = model.cityName;
        
        return cell;
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        currentSeletIndex = indexPath.row
        
        switch currentSelectLevel {
        case 0:
            
            let  model = cityArrays?.object(at: indexPath.row) as! CityModel;
            _secondDataSource = model.cityArr
            selectModel = model
            firstTitle = model.cityName
            firstModel = model
            _collectionDataSource = _secondDataSource!
            collectionView.reloadData()
            self.selectCityAreaAction(sender: titleBtnArr.object(at: 1) as! UIButton)
            currentSelectLevel = 1;
            //扩展，如果选择的是直辖市，跳过第二级的选择
            self.fiterDirectlyByCentralGovernmentWith(model: model)
            
            let titleButt = titleBtnArr.object(at: 0) as! UIButton
            titleButt.setTitle(firstTitle, for: .normal)
            
            break
        case 1:
            
            currentSelectLevel = 2
            
            let model = _secondDataSource?.object(at: indexPath.row) as! CityModel
            _thirdDataSource = model.cityArr;
            
            if (model.cityName.contains("全境")) {
                model.cityFullName = "全境";
//                print("%@-----%@",selectModel?.cityName,selectModel?.cityId)
                secondTitle = model.cityName
                secondModel = model
                thirdTitle = "";
                
                selectCityName = String.init(format: "%@ %@ %@", firstTitle,secondTitle,thirdTitle)
                
                delegate?.customCitySelectViewDidSelectItem(atIndexPath: indexPath as NSIndexPath, modelForItem: selectModel!, view: self)
               
                self.hide()
                return;
            }
            
            selectModel = model
            secondTitle = model.cityName
            secondModel = model
            thirdTitle = ""
            
            
            if self.isNeedThirdLeve == false {
                delegate?.customCitySelectViewDidSelectItem(atIndexPath: indexPath as NSIndexPath, modelForItem: selectModel!, view: self)
                self.hide()
                return;

            }
            

            _collectionDataSource = _thirdDataSource!
            collectionView.reloadData()
            self.selectCityAreaAction(sender: titleBtnArr.object(at: 2) as! UIButton)
            
            let  titleButt = titleBtnArr.object(at: 1) as! UIButton
            titleButt.setTitle(model.cityName, for: .normal)
            

            break
        case 2:
            
            let  model = _collectionDataSource.object(at: indexPath.row) as! CityModel
            if (model.cityName.contains("全境")) {
                model.cityFullName = "全境"
                //                print("%@-----%@",selectModel?.cityName,selectModel?.cityId)
                thirdTitle = model.cityName
                thirdModel = model
                selectCityName = String.init(format: "%@ %@ %@", firstTitle,secondTitle,thirdTitle)
                
                delegate?.customCitySelectViewDidSelectItem(atIndexPath: indexPath as NSIndexPath, modelForItem: selectModel!, view: self)
                
                self.hide()
                return;
            }
            
            if (model.cityName.contains("市辖区")) {
                model.cityFullName = "市辖区"
            }
            
            selectModel = model
            thirdTitle = model.cityName
            thirdModel = model
            
            //                print("%@-----%@",selectModel?.cityName,selectModel?.cityId)
            selectCityName = String.init(format: "%@ %@ %@", firstTitle,secondTitle,thirdTitle)
            delegate?.customCitySelectViewDidSelectItem(atIndexPath: indexPath as NSIndexPath, modelForItem: selectModel!, view: self)

            self.hide()

            break

        default: break
            
        }
        
        
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return _collectionDataSource.count
    }

    
    
     public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(0,0 ,0,0);
    }
    
    //MARK: -show
    func show() -> Void {
        self.isShow = true;
        
        self.selectCityAreaAction(sender: self.viewWithTag(500) as! UIButton)
        
        let  bgAlphView = UIButton.init(type: .custom)
        bgAlphView.frame = UIScreen.main.bounds
        bgAlphView.isAccessibilityElement = false;
        bgAlphView.backgroundColor = UIColor.black.withAlphaComponent(0.3);
        _collectionView?.backgroundColor = UIColor.white;
        
        bgAlphView.tag =  600;
        bgAlphView.addTarget(self, action:#selector(CustomCitySelectView.touchesHideMenuView), for: .touchUpInside)
        
        UIApplication.shared.keyWindow?.addSubview(bgAlphView)
        UIApplication.shared.keyWindow?.bringSubview(toFront: bgAlphView)
        
        bgAlphView.addSubview(self)
        self.alpha = 0
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: { 
             self.alpha = 1
            
        }) { (Bool ) in
            self.isHidden = false
            UIApplication.shared.keyWindow?.viewWithTag(600)?.isHidden = false
        }
        

    }
    
    
    //MARK: 跳过二级直辖市到第三级
    func fiterDirectlyByCentralGovernmentWith(model:CityModel) -> Void {
        let  indexPath:NSIndexPath?
        
        if cityType == CityArrayType.PostCityArr || cityType == CityArrayType.LocalWeatherCityArr {
            
            let newIndex:Array = [0,0]

              indexPath = NSIndexPath.init(indexes: newIndex, length: 2)
            
        }else
        {
            let newIndex:Array = [0,1]
            
              indexPath = NSIndexPath.init(indexes: newIndex, length: 2)
        }
       
        if model.cityName.contains("上海") || model.cityName.contains("天津") || model.cityName.contains("重庆") || model.cityName.contains("北京") {
            
            currentSelectLevel = 2
            
            let  model = _secondDataSource?.object(at: (indexPath?.row)!) as! CityModel;
            _thirdDataSource = model.cityArr;
            
            if  model.cityName.contains("全境") {
                //                print("%@-----%@",selectModel?.cityName,selectModel?.cityId)
                secondTitle = model.cityName;
                secondModel = model;
                thirdTitle = "";
                selectCityName = String.init(format: "%@ %@ %@", firstTitle,secondTitle,thirdTitle)
                
                delegate?.customCitySelectViewDidSelectItem(atIndexPath: indexPath!, modelForItem: selectModel!, view: self)
                
               self.hide()
                
                return;
            }

            selectModel = model;
            secondTitle = model.cityName;
            secondModel = model;
            thirdTitle = "";
            
            if (self.isNeedThirdLeve == false)
            {
                delegate?.customCitySelectViewDidSelectItem(atIndexPath: indexPath!, modelForItem: selectModel!, view: self)
                
                self.hide()
                return;
            }
            
            _collectionDataSource = _thirdDataSource!
            _collectionView?.reloadData()
            
            self.selectCityAreaAction(sender: titleBtnArr.object(at: 2) as! UIButton)
            
        }

        
    }
    
    

    //MARK: -hide
    func hide() -> Void {
        self.isShow = false;
        //消失前重置数据
        self.selectCityAreaAction(sender: self.viewWithTag(500) as! UIButton)
        
        self.alpha = 1
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: { 
              self.alpha = 0
        }) { (bool ) in
            self.isHidden = true
            UIApplication.shared.keyWindow?.viewWithTag(600)?.removeFromSuperview()
            if self.hideHandle != nil
            {
                self.hideHandle!()
            }
        }
    }
    
    
    
    func touchesHideMenuView() -> Void {
        self.hide()
    }
    
    
    
    
}


//--------------------------MARK: CityCollectionCell

class CityCollectionCell: UICollectionViewCell {
    
    var titleLable:UILabel = UILabel.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let lab =  UILabel.init(frame: self.bounds);
        lab.textAlignment = .center;
        lab.font = UIFont.systemFont(ofSize: FixFont(fontSize: 16));
        lab.adjustsFontSizeToFitWidth = true;
        lab.numberOfLines = 2;
        lab.textColor = hexColor(str: 0x666666)
        lab.backgroundColor = UIColor.white
        titleLable = lab;
        
        self.addSubview(lab)
        
        
        let bgView = UIView.init(frame: self.frame)
        self.selectedBackgroundView = bgView

    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}







