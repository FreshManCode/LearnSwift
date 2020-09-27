//
//  SWEnumViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/9/25.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

enum LookUpError : Error {
    case capitialNotFound
    case populationNotFound
}

class SWEnumViewController: SWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swift中的枚举类型"
        view.addSubview(tableView)
        listArray.append("HandleError")
        tableView.reloadData()
    }
    

    // MARK: - Swift中的错误处理
    @objc  func HandleError()  {
        let captials = ["CH":"beijing","Am":"Losan"]
        let populations = ["beijing":2828828,"Losan":2992923]
        
        
        func populationOfCaption(country:String) throws -> Int  {
            guard let capital = captials[country] else {
                throw LookUpError.capitialNotFound
            }
            guard let population = populations[capital] else {
                throw LookUpError.populationNotFound
            }
            return population
        }
        //要调用一个有throws标记的函数,我们可以将调用代码嵌入到一个do执行块中,然后添加一个try前缀.
        
        do {
            let population = try populationOfCaption(country: "abc")
            print("population is:\(population)")
        } catch  {
            print("lookup error: \(error)")
            //lookup error:capitialNotFound
        }
    }
   
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
}
