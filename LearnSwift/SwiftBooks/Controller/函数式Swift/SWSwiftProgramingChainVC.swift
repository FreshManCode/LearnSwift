//
//  SWSwiftProgramingChainVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/9/14.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWSwiftProgramingChainVC: SWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swift函数式编程"
        view.addSubview(tableView)
        listArray.append("EncapsulateCoreImage")
        listArray.append("MapFilterReduce")
        listArray.append("OptionalValue")
        listArray.append("ConstantValue")
        listArray.append("SwiftPOP")
        tableView.reloadData()
    }
    
    // MARK: - 案例研究: 封装 Core Image
    @objc  func EncapsulateCoreImage()  {
        psuhToTargetVC(className: "SWEncapsulateCoreImageVC")
    }
    
    @objc  func MapFilterReduce()  {
        psuhToTargetVC(className: "SWMapFilterReduceVC")
    }
    
    @objc  func OptionalValue()  {
        psuhToTargetVC(className: "SWOptionalValueVC")
    }
    
    @objc  func ConstantValue()  {
        psuhToTargetVC(className: "SWConstantValueVC")
    }
    
    // MARK: - SwiftPOP swift 面向协议编程 POP (Protocol Oriented Programming)
    @objc  func SwiftPOP()  {
        psuhToTargetVC(className: "SWPOPVC")
    }
    
    func psuhToTargetVC(className:String)  {
        let modelClass: AnyClass? = NSClassFromString("LearnSwift.\(className)")
        if let VCClass = modelClass as? UIViewController.Type {
            let vcInstance = VCClass.init()
            navigationController?.pushViewController(vcInstance, animated: true)
        }
    }
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
    

}
