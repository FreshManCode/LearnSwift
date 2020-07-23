//
//  SWApplyPropertyWrapperVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/7/23.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//  属性包装应用

import UIKit

class SWApplyPropertyWrapperVC: SWBaseViewController {
    
    lazy var placeHolderArray  =  [String]()
    lazy var textArray  =  [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "属性包装应用"
        p_initDefaultData()
    }
    
    func p_initDefaultData()  {
        self.view.addSubview(self.tableView);
        self.tableView.register(SWInputTextCell.self,
                                forCellReuseIdentifier: SWInputTextCell.CellID())
        listArray.append("姓名")
        placeHolderArray.append("请输入姓名")
        textArray.append(UserDefaultManager.UserName)
        listArray.append("年龄")
        placeHolderArray.append("请输入年龄")
        textArray.append(UserDefaultManager.UserAge)
        listArray.append("性别")
        placeHolderArray.append("请输入性别")
        textArray.append(UserDefaultManager.UserSex)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        weak var weakSelf = self
        let cell : SWInputTextCell  = tableView.dequeueReusableCell(withIdentifier: SWInputTextCell.CellID(),
                                                                    for: indexPath) as! SWInputTextCell;
        cell.set(leftText: listArray[indexPath.row],
                 placeholder: placeHolderArray[indexPath.row],
                 text: textArray[indexPath.row])
        cell.buttonEvent = { (buton) in
            weakSelf?.handleSaveAction(cell: cell, indexPath: indexPath as NSIndexPath)
        }
        return cell;
    }
    
    func handleSaveAction(cell:SWInputTextCell,indexPath:NSIndexPath) {
        let text = cell.midTextFiled.text ?? ""
        
        if indexPath.row == 0 {
            //姓名
            UserDefaultManager.UserName = text;
        } else if indexPath.row == 1 {
            //年龄
            UserDefaultManager.UserAge = text;
        } else if indexPath.row == 2 {
            //性别
            UserDefaultManager.UserSex = text;
        }
        textArray[indexPath.row] = text
        self.tableView.reloadRows(at: [indexPath as IndexPath], with: .none)
    }
    
    
//  使用 @propertyWrapper 关键词说明该结构体需要包装属性
    @propertyWrapper
    struct UserDefault <T> {
        let key : String
        let defaultValue :T
        
        init(_ key:String,defaultValue:T) {
            self.key = key
            self.defaultValue = defaultValue
        }
        
        var wrappedValue: T {
            get {
                return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
            }
            set {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
   
    struct UserDefaultManager {
        //用户名
        @UserDefault("userName",defaultValue:"")
        static var UserName:String
        
        //用户年龄
        @UserDefault("userAge",defaultValue:"")
        static var UserAge:String
        
        //用户性别
        @UserDefault("userSex", defaultValue: "")
        static var UserSex:String
        
    }
    
    
}
