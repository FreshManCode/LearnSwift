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
        }
        else if index == .Collect {
            self.doCollect(itemID: model.IDNumber)
        }
    }
    
}
