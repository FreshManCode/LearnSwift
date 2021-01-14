//
//  SWBookListViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/9/11.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWBookListViewController: SWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    func p_initDefautData()  {
        title = "Swift书籍列表"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "Swift函数式编程", subTitle: "", funName: "SwiftProgramingChain"))
        listItemArray.append(SWBookListItem(title: "AVFoundation编程", subTitle: "", funName: "AVFoundationCode"))

        
        
        tableView.reloadData()
    }
    
    
    
    // MARK: - SwiftProgramingChain (函数式swift编程)
    @objc  func SwiftProgramingChain()  {
        psuhToTargetVC(className: "SWSwiftProgramingChainVC")
    }
    
    // MARK: - AVFoundation

    @objc func AVFoundationCode() {
        psuhToTargetVC(className: "SWAVFoundationListVC")
        
    }
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listItemArray[indexPath.row].title!, tableView: tableView);
    }
    
    func psuhToTargetVC(className:String)  {
        let modelClass: AnyClass? = NSClassFromString("LearnSwift.\(className)")
        if let VCClass = modelClass as? UIViewController.Type {
            let vcInstance = VCClass.init()
            navigationController?.pushViewController(vcInstance, animated: true)
        }
    }

}
