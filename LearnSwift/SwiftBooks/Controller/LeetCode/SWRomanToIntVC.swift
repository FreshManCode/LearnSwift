//
//  SWRomanToIntVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/7/29.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWRomanToIntVC: SWBaseViewController {
    
    /**
     *题目:罗马数字转整数
     罗马数字包含以下七种字符: I， V， X， L，C，D 和 M。
     
     字符          数值
     I             1
     V             5
     X             10
     L             50
     C             100
     D             500
     M             1000
     例如， 罗马数字 2 写做 II ，即为两个并列的 1。12 写做 XII ，即为 X + II 。 27 写做  XXVII, 即为 XX + V + II 。
     
     通常情况下，罗马数字中小的数字在大的数字的右边。但也存在特例，例如 4 不写做 IIII，而是 IV。数字 1 在数字 5 的左边，所表示的数等于大数 5 减小数 1 得到的数值 4 。同样地，数字 9 表示为 IX。这个特殊的规则只适用于以下六种情况：
     
     I 可以放在 V (5) 和 X (10) 的左边，来表示 4 和 9。
     X 可以放在 L (50) 和 C (100) 的左边，来表示 40 和 90。
     C 可以放在 D (500) 和 M (1000) 的左边，来表示 400 和 900。
     给定一个罗马数字，将其转换成整数。输入确保在 1 到 3999 的范围内。
     
     链接：https://leetcode-cn.com/problems/roman-to-integer
     */
    
    let specialPrefix:[Character] = ["I","X","C"]
    
    let special = ["IV":4,
                   "IX":9,
                   "XL":40,
                   "XC":90,
                   "CD":400,
                   "CM":900,
    ]
    
    let common:[Character:Int] = [
        "I":1,
        "V":5,
        "X":10,
        "L":50,
        "C":100,
        "D":500,
        "M":1000,
    ]
    
    let romanOne   = "LCIID"
    let romanTWO   = "LVIII"
    let romanThree = "MCMXCIV"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData();
    }
    
    
    func p_initDefautData()  {
        title = "罗马数字转整数"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "罗马数字转整数1(效率低) ",
                                            subTitle: "",
                                            funName: "romanToInt1"))
        
        
        listItemArray.append(SWBookListItem(title: "罗马数字转整数3(高效率) ",
                                            subTitle: "",
                                            funName: "romanToInt3"))
        
        
        
        tableView.reloadData()
        
    }
    // MARK: - 笨方法
    @objc func romanToInt1() {
        printLog("romanOne:\(romanToIntSlowMethod(romanOne))")
        printLog("romanTWO:\(romanToIntSlowMethod(romanTWO))")
        printLog("romanThree:\(romanToIntSlowMethod(romanThree))")
        
    }
    
    
    @objc func romanToInt3() {
        printLog("romanOne:\(modifyRomanToInt(romanOne))")
        printLog("romanTWO:\(modifyRomanToInt(romanTWO))")
        printLog("romanThree:\(modifyRomanToInt(romanThree))")
    }
    
    
    
    func romanToIntSlowMethod(_ s: String) -> Int {
        let chars = s.characters
        var result = 0
        var index  = 0
        while index < chars.count  {
            let currentChar = chars[index]
            let currentCharString = String(currentChar)
            let currentValue = common[currentChar] ?? 0
            if specialPrefix.contains(currentChar) {
                if index < chars.count - 1 {
                    let nextCharString = String(chars[index + 1])
                    let specialKey = currentCharString + nextCharString
                    if special[specialKey] != nil {
                        let specialValue = special[specialKey]!
                        result += specialValue
                        index += 2
                    } else {
                        result += currentValue
                        index += 1
                    }
                } else {
                    result += currentValue
                    index += 1
                }
            } else {
                result += currentValue
                index += 1
            }
        }
        
        return result
    }
    
    
    func modifyRomanToInt(_ s:String) -> Int {
//      正常情况下小的在右边,大的在左边(做加法)
//      特殊情况下,大的右边,小的在左边 (做减法)
        var result = 0
        var lastItem = 0
        
        for item in s {
            guard let current = common[item] else {
                return result
            }
            // 右边比左边的大,做减法因为上一次多加了一个lastItem,再加上本次需要减去的
            if lastItem < current {
                result = result - 2 * lastItem + current
            }
            //正常情况
            else {
                result += current
            }
            lastItem = current
        }
        return result
    }
}
