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
    
    let inputs  = ["flower","flow","flight"]
    let inputs2 = ["dog","racecar","car"]
    let input3  = ["ab", "a"]
    let input4  = ["reflower","flow","flight"]
    let input5  = ["flower","flower","flower","flower"]
    let input6  = ["flower","fkow"]
    
    
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
        
        listItemArray.append(SWBookListItem(title: "最长公共前缀(效率低) ",
                                            subTitle: "",
                                            funName: "maxCommonPrefix"))
        
        listItemArray.append(SWBookListItem(title: "最长公共前缀(效率高) ",
                                            subTitle: "",
                                            funName: "maxCommonPrefixHigh"))
        
        
        tableView.reloadData()
        
    }
    // MARK: - 罗马数字转整数
    // MARK: - 笨方法
    @objc func romanToInt1() {
        printLog("romanOne:\(romanToIntSlowMethod(romanOne))")
        printLog("romanTWO:\(romanToIntSlowMethod(romanTWO))")
        printLog("romanThree:\(romanToIntSlowMethod(romanThree))")
        
        
        printLog("2_romanOne:\(romanToIntSlowMethod(romanOne))")
        printLog("2_romanTWO:\(romanToIntSlowMethod(romanTWO))")
        printLog("2_romanThree:\(romanToIntSlowMethod(romanThree))")
        
    }
    
    
    @objc func romanToInt3() {
        printLog("romanOne:\(modifyRomanToInt(romanOne))")
        printLog("romanTWO:\(modifyRomanToInt(romanTWO))")
        printLog("romanThree:\(modifyRomanToInt(romanThree))")
    }
    
    // MARK: - 最长公共前缀
    @objc func maxCommonPrefix() {
        
        printLog("fl:\(findLongestCommPrefix(inputs))")
        printLog(":\(findLongestCommPrefix(inputs2))")
        printLog("a:\(findLongestCommPrefix(input3))")
        printLog(":\(findLongestCommPrefix(input4))")
        printLog("flower:\(findLongestCommPrefix(input5))")
        printLog("f:\(findLongestCommPrefix(input6))")
        
        
        printLog("my_fl:\((myFindMaxCommonLengthstr(inputs)))")
        printLog("my_:\(myFindMaxCommonLengthstr(inputs2))")
        printLog("my_a:\(myFindMaxCommonLengthstr(input3))")
        printLog("my_:\(myFindMaxCommonLengthstr(input4))")
        printLog("my_flower:\(myFindMaxCommonLengthstr(input5))")
        printLog("my_f:\(myFindMaxCommonLengthstr(input6))")
        
    }
    
    @objc func maxCommonPrefixHigh() {
        printLog("2_fl:\(findMaxCommonPrefixHigh(inputs))")
        printLog("2_:\(findMaxCommonPrefixHigh(inputs2))")
        printLog("2_a:\(findMaxCommonPrefixHigh(input3))")
        printLog("2_:\(findMaxCommonPrefixHigh(input4))")
        printLog("2_flower:\(findMaxCommonPrefixHigh(input5))")
        printLog("2_f:\(findMaxCommonPrefixHigh(input6))")
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
    
    
    func myRomanToIntMethod(_ s:String)->Int {
        var result = 0
        var lastItem = 0
        for item in s {
            guard let currentNumber = common[item] else {
                return result
            }
            
            //大的在右边做减法,
            if currentNumber > lastItem {
                //因为上一次多加了一个lastitem,本次做减法 -lastitem - 多加的lastitem,最后结果求和
                result = result + currentNumber - 2 * lastItem
            }
            //大的在左边做加法
            else {
                result += currentNumber
            }
            lastItem = currentNumber
            
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
    
    /* 最长公共前缀
     
     写一个函数来查找字符串数组中的最长公共前缀。
     
     如果不存在公共前缀，返回空字符串 ""。
     
     示例 1：
     
     输入：strs = ["flower","flow","flight"]
     输出："fl"
     示例 2：
     
     输入：strs = ["dog","racecar","car"]
     输出：""
     解释：输入不存在公共前缀。
     
     链接：https://leetcode-cn.com/problems/longest-common-prefix
     
     */
    
    func findLongestCommPrefix(_ strs:[String]) -> String {
        var result = ""
        var minLengthString = strs.first
        if strs.count < 1 {
            return result
        }
        else if strs.count == 1 {
            return minLengthString!
        }
        
        for string in strs {
            if string.count < minLengthString!.count {
                minLengthString = string
            }
        }
        var map    = [Int:String]() ;
        var maxTagIndex:Int?;
        var index = 0
        var indexString = ""
        
        for value in minLengthString! {
            indexString += "\(value)"
            map[index] = indexString
            index += 1
        }
        let miniLength = minLengthString!.count
        
        for index in 0 ..< miniLength {
            var stop = false
            let prefixChar = map[index]!
            for allString in strs {
                if !allString.hasPrefix(prefixChar) {
                    stop = true
                    break
                }
            }
            if !stop {
                maxTagIndex = index
            } else {
                break
            }
        }
        
        guard let tempResult = maxTagIndex else {
            return result
        }
        result = map[tempResult]!
        return result
    }
    
    
    
    
    /// 找出数组中,最长的公共字符串
    /// - Parameter strs: 字符串数组
    /// - Returns: 最长的公共字符串
    func myFindMaxCommonLengthstr(_ strs:[String]) -> String {
        if (strs.count < 1) {
            return ""
        }
        var commonStr = strs.first!
        for str in strs {
            while str.hasPrefix(commonStr) == false {
                if (commonStr.count == 0) {
                    return commonStr
                }
                commonStr.removeLast()
            }
        }
        return commonStr
    }
    
    
    
    /// 高效率查找最长公共前缀字符串
    /// - Parameter strs: 字符串数组
    /// - Returns: 公共最长字符串
    @objc func findMaxCommonPrefixHigh(_ strs:[String]) -> String {
        var result = ""
        if strs.count < 1 {
            return result
        }
        var resetStr = strs.first!
        for allStr in strs {
            while allStr.hasPrefix(resetStr) == false {
                //已经把所有的字符都删除完了,也就是没有公共最长字符串
                if resetStr.count == 0 {
                    return result
                }
                //如果不包含当前字符串,则删除最后一位,继续循环,当包含特定的前缀时,则继续下一个循环判定
                resetStr.removeLast();
            }
        }
        result = resetStr
        return result
    }
    
    
    
    
}
