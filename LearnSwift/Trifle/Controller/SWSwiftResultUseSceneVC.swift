//
//  SWSwiftResultUseSceneVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/11.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit


let ExplainOne:String = "下面我们来手动实现一个自己的result类型。\n\n1、我们先定义成功和失败的两个协议：\n\n 成功的协议，可以扩展成功的对象需要的任何东西。 LWSuccessedProtocol\n\n 失败的协议，可以扩展失败的对象需要的任何东西。 LWFailedProtocol"

let ExplainTwo:String = "2. 我们创建一个LWResult枚举\n\nResult枚举有2个泛型，T继承LWSuccessedProtocol，Error继承LWFailedProtocol。枚举有2种情况，一种是成功（success），一种是失败（failure），还有对应的初始化。 我们就完成了一个Result类型的定义了。"



class SWSwiftResultUseSceneVC: SWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    func p_initDefautData()  {
        view.addSubview(tableView)
        listArray.append("ResultScene")
        listArray.append("ResultSuccessScene")
        listArray.append("ResultFailureScene")
        tableView.reloadData()
    }
    
    
    // MARK: - ResultScene (Result使用场景)
    @objc  func ResultScene()  {
        self.setText(ExplainOne + ExplainTwo)
    }
    @objc  func ResultSuccessScene()  {
        let mySuccess = LWMySuccess()
        let result = LWResult<LWMySuccess,LWMyError >.init(value: mySuccess)
        switch result {
        case .success(let t):
            if t.isSuccess {
                printLog("ResultSuccessScene  ^^^^ 111")
            }
        default:
            printLog("sss11111")
        }
    }
    @objc  func ResultFailureScene()  {
        let result = LWResult<LWMySuccess, LWMyError>.init(error: LWMyError())
        switch result {
        case .failure(let failure):
            if failure.isError {
                printLog("ResultFailureScene ^^^ 222")
            }
        default:
            printLog("fff22222")
        }
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
