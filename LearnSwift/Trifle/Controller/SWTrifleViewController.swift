//
//  SWTrifleViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/11.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWTrifleViewController: SWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "琐事集合"
        p_initDefautData()
    }
    
    
    func p_initDefautData()  {
        view.addSubview(tableView)
        listArray.append("ResultScene")
        listArray.append("DisplayAppStore")
        tableView.reloadData()
    }
    
    
    // MARK: - ResultScene (Result使用场景)
    @objc  func ResultScene()  {
        psuhToTargetVC(className: "SWSwiftResultUseSceneVC")
    }
    
    // MARK: - 弹出Appstore
    @objc  func DisplayAppStore()  {
        psuhToTargetVC(className: "SWDisplayAppstoreVC")
    }
    
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
    func psuhToTargetVC(className:String)  {
        let modelClass: AnyClass? = NSClassFromString("LearnSwift.\(className)")
        if let VCClass = modelClass as? UIViewController.Type {
            let vcInstance = VCClass.init()
            navigationController?.pushViewController(vcInstance, animated: true)
        }
    }


}
