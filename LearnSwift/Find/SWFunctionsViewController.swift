//
//  SWFunctionsViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/6/29.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//  Functions (函数)

import UIKit

class SWFunctionsViewController: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "函数"
        p_initDefaultData();
    }
    
    func p_initDefaultData() -> Void {
        self.view.addSubview(self.tableView);
        listArray.append("FunctionParametersAndReturnValues")
        listArray.append("OptionalTupleReturnTypes")
        tableView.reloadData()
    }
    
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
    
    // MARK: - 函数
    @objc func FunctionParametersAndReturnValues() {
        //1. Functions Without Return Values (无返回值的函数)
        //.因为该函数无返回值,所以该函数可以不用包含->
        func greet(person:String) {
            print("This a function without return value")
        }
        //This a function without return value
        greet(person: "bac")
        //注意:函数的返回值可以忽略,但是如果一个函数定义的有返回值,返回值是必须有的,如果在一个有返回值的函数,尝试着在函数执行的底部
        //没有返回值,将会导致一个运行时错误.
        
        //2.Functions with Multiple Return Values (函数有多个返回值)
        //如果函数有多个返回值,使用元组来进行表示
        
        func findMax(array:[Int])->(min:Int,max:Int) {
            var currentMin = array[0]
            var currentMax = array[1]
            for value in array {
                if value < currentMin {
                    currentMin = value
                }
                else if value > currentMax {
                    currentMax = value
                }
            }
            return (currentMin,currentMax)
        }
        let result = findMax(array: [1,2,3,4,5,6,4,1])
        //min is:1 max is:6
        print("min is:\(result.min) max is:\(result.max)")
    }
    
    // MARK: - Optional Tuple Return Types (可选元组返回类型)

    func OptionalTupleReturnTypes()  {
        
    }
    
}
