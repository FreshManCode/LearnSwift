//
//  SWFindViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/6/29.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWFindViewController: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发现";
        self.p_initDefaultData()
    }
    
    func p_initDefaultData() -> Void {
        self.view.addSubview(self.tableView);
        listArray.append("Functions")
        listArray.append("Enumerations")
        listArray.append("Properties")
        listArray.append("ApplyWrapperProperty")
        listArray.append("Subscripts")
        listArray.append("Initialization")
        listArray.append("ErrorHandling")
        listArray.append("Extensions")
        listArray.append("Protocols")
        listArray.append("Generics")
        listArray.append("OpaqueTypes")
        listArray.append("AutomaticReferenceCounting")
        listArray.append("AccessControl")
        listArray.append("SwiftAdvancedTips")
        tableView.reloadData()
    }
    
    // MARK: - 函数
    @objc func Functions() {
        self.navigationController?.pushViewController(SWFunctionsViewController.init(), animated: true)
    }
    
    // MARK: - 枚举
    
    @objc func Enumerations () {
        self.navigationController?.pushViewController(SWEnumerationsController.init(), animated: true)
    }
    
    // MARK: - 属性
    @objc func Properties() {
        self.navigationController?.pushViewController(SWPropertiesViewController(),animated:true)
    }
    
    // MARK: - 属性包装应用
    @objc func ApplyWrapperProperty() {
        pushToTragetVC(classStr: "SWApplyPropertyWrapperVC")
    }
    
    // MARK: - 下标语法
    @objc func Subscripts()  {
        pushToTragetVC(classStr: "SWSubscriptsViewController")
    }
    
    // MARK: - 初始化
    @objc func Initialization()  {
        pushToTragetVC(classStr: "SWInitializationViewController")
    }
    
    // MARK: - ErrorHandling 错误处理
    @objc  func ErrorHandling()  {
        pushToTragetVC(classStr: "SWErrorHandlingViewController")
    }
    
    // MARK: - Extensions
    @objc func Extensions()  {
        pushToTragetVC(classStr: "SWExtensionsViewController")
    }
    
    // MARK: - Protocols
    @objc  func Protocols()  {
        pushToTragetVC(classStr: "SWProtocolsViewController")
    }
    
    // MARK: - Generics
    @objc  func Generics()  {
        pushToTragetVC(classStr: "SWGenericsViewController")
    }
    // MARK: - OpaqueTypesViewController
    @objc  func OpaqueTypes()  {
        pushToTragetVC(classStr: "OpaqueTypesViewController")
    }
    // MARK: - AutomaticReferenceCounting
    @objc  func AutomaticReferenceCounting()  {
        pushToTragetVC(classStr: "SWARCViewController")
    }
    
    // MARK: - AccessControl
    @objc  func AccessControl()  {
        pushToTragetVC(classStr: "SWAccessViewControler")
    }
    
    // MARK: - SwiftAdvancedTips
    @objc  func SwiftAdvancedTips()  {
        pushToTragetVC(classStr: "SWSwiftAdvancedTipsViewControler")
    }
    
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
    
    func pushToTragetVC(classStr:String)  {
        let vcStr = "LearnSwift."+classStr
        let targetClass: AnyClass? = NSClassFromString(vcStr)
        if let aClass = targetClass as? UIViewController.Type {
            let targetVC = aClass.init()
            self.navigationController?.pushViewController(targetVC, animated: true)
        }
    }
    
    
    
}
