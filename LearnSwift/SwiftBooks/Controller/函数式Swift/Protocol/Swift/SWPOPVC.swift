//
//  SWPOPVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/9/24.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

struct SWProtocolTestModel {
    var name:String
    var IDNumber:String
}

class SWPOPVC: SWBaseViewController,SWButtonRequestProtocol {
        
    var dataArray:Array = [SWProtocolTestModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.defaultData()
        tableView.register(UINib(nibName: "SWPOPTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "SWPOPTableViewCell")
        title = "Swift面向协议编程"
        view.addSubview(tableView)
        tableView.reloadData()
//        testUseExtensionProtolMethod()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        weak var weakSelf = self
        let cell = tableView.dequeueReusableCell(withIdentifier: "SWPOPTableViewCell", for: indexPath)
            as! SWPOPTableViewCell
        cell.ButtonEvent = { index in
            weakSelf?.callBack(index: index, indexPath: indexPath)
        }
        cell.set(model: dataArray[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentBottom(SWBottomPopViewController.self)
    }
    
    
    func callBack(index:SWButtonEvent,indexPath:IndexPath)  {
        let model = dataArray[indexPath.row]
        if index == .Favor {
            self.doFavor(itemID: model.IDNumber)
//            testPersonEqual()
        }
        else if index == .Collect {
            self.doCollect(itemID: model.IDNumber)
//            testPersonUnEqual()
        }
    }
    
    
//  遍历dataArray 数组中的每个模型的IDNumber 是不是大于10,由于IDNumber 是从1开始的,所以结果为false
    func testUseExtensionProtolMethod()  {
        let allLarge10 =  dataArray.differAll { (model) -> Bool in
            return Int(model.IDNumber)! > 10
        }
        // ["allLarge10 is:false"]
        printLog("allLarge10 is:\(allLarge10)")
        
    }
    
    func testUseExtensionProtolMethod2()  {
        let allLarge10 =  dataArray.matchAll{ (model) -> Bool in
            return Int(model.IDNumber)! > 10
        }
        // ["allLarge10 is:false"]
        printLog("allLarge10 is:\(allLarge10)")
    }
    
    
    /// 两个结构体实例相等的事例
    func testPersonEqual()  {
        let libai1 = ZJTestPerson(name: "李白", age: 24)
        let libai2 = ZJTestPerson(name: "李白", age: 24)
        printLog("以上两个结构体是否相等:\(libai1 == libai2)")
    }
    
    
    /// 两个结构体事例不相等的事例
    func testPersonUnEqual()  {
        let libai = ZJTestPerson(name: "李白", age: 24)
        let wangwei = ZJTestPerson(name: "王维", age: 24)
        printLog("以上两个结构体是否相等:\(libai == wangwei)")
    }
    
//  统计功能
//    func doCollect(eventName: String) {
//
//    }
    
}
