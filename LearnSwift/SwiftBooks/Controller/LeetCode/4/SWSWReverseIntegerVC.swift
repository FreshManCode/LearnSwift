//
//  SWSWReverseIntegerVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/7/28.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWSWReverseIntegerVC: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData();
        
        // Do any additional setup after loading the view.
    }
    
    /*
     题目描述:整数反转
     
     给你一个 32 位的有符号整数 x ，返回将 x 中的数字部分反转后的结果。
     
     如果反转后整数超过 32 位的有符号整数的范围 [−231,  231 − 1] ，就返回 0。
     
     来源：力扣（LeetCode）
     链接：https://leetcode-cn.com/problems/reverse-integer
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     
     输入：1234
     输出：4321
     
     输入：-1234
     输出：-4321
     
     */
    
    func p_initDefautData()  {
        title = "整数反转"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.整数反转(1234) ",
                                            subTitle: "",
                                            funName: "reverIntegerPositive1"))
        listItemArray.append(SWBookListItem(title: "2.整数反转(-1234) ",
                                            subTitle: "",
                                            funName: "reverIntegerNegative1"))
        
        
        tableView.reloadData()
        
        
        
    }
    
    @objc func reverIntegerPositive1() {
        printLog("reverIntegerPositive1:\(reverseInteget(1234))")
        printLog("my_reverIntegerPositive1:\(myReverseInt(1234))")
        
        
    }
    
    @objc func reverIntegerNegative1() {
        printLog("reverIntegerNegative1:\(reverseInteget(-1234))")
        printLog("my_reverIntegerNegative1:\(myReverseInt(-1234))")
    }
    
    
    func myReverseInt(_ input:Int) -> Int {
        let isPositive = input > 0
        var inputNumber = abs(input)
        var resultStr = ""
        while inputNumber > 0 {
            let tailNumber = inputNumber % 10
            inputNumber = inputNumber / 10
            resultStr += "\(tailNumber)"
        }
        let resultNumber = Int(resultStr)!
        return  isPositive  ? resultNumber : -resultNumber
    }
    
    
    
    
    func reverseInteget(_ x:Int) -> Int {
        let isPositive = x > 0 ? true : false;
        var input = abs(x);
        var length = "\(input)".count;
        printLog("input is:\(input)")
        var resultArray = [Int]()
        while length > 0 {
            let tempResult = input % 10
            resultArray.append(tempResult)
            input = input / 10
            length -= 1
            printLog("tempResult:\(tempResult)")
        }
        printLog("resultArray:\(resultArray)")
//      填入初始值, 下一次运行的值,以及数组的元素
        let numString =  resultArray.reduce("") { (str,x)  in
            printLog("str is:\(str) x is:\(x)")
            return str + "\(x)"
        }
//        let numString = resultArray.reduce("",{str,x in str + "\(x)"})
        printLog("numString:\(numString)")
        let numberResult = Int(numString)!
        if (numberResult > INT32_MAX) {
            return 0
        }
        let result = isPositive ?  numberResult : -numberResult
        return result
    }
    
    
    /// 整数反转优化
    /// - Parameter x: 输入参数
    /// - Returns: 输出参数
    func reverIntegerImprove(_ x:Int) -> Int {
        var input = x;
        var result = 0
        while input != 0 {
            let tempResult = input % 10
            input = input / 10
            result = result * 10 + tempResult
        }
        if (result > INT32_MAX) {
            return 0
        } else if (result < -INT32_MAX - 1) {
            return 0
        }
        return result
    }
    
}
