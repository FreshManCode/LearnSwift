//
//  SWBracketValidVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/7/30.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWBracketValidVC: SWBaseViewController {
    let bracket1 = "()"
    let bracket2 = "()[]{}"
    let bracket3 = "(]"
    let bracket4 = "([)]"
    let bracket5 = "{[]}"
    
    let bracketMaps:[Character:Character] = ["(":"(","{":"{","[":"["]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    func p_initDefautData()  {
        title = "有效的括号"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "有效的括号(自己实现) ",
                                            subTitle: "",
                                            funName: "myValidBracket"))
        
        tableView.reloadData()
        
    }
    
    @objc func myValidBracket() {
        /**
         有效的括号
         
         给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。

         有效字符串需满足：

         1.左括号必须用相同类型的右括号闭合。
         2.左括号必须以正确的顺序闭合。

         链接：https://leetcode-cn.com/problems/valid-parentheses
         题解:https://leetcode-cn.com/problems/valid-parentheses/solution/zhu-bu-fen-xi-tu-jie-zhan-zhan-shi-zui-biao-zhun-d/
         
         解题思路
         当开始接触题目时，我们会不禁想到如果计算出左括号的数量，和右括号的数量，如果每种括号左右数量相同，会不会就是有效的括号了呢？

         事实上不是的，假如输入是 [{]}，每种括号的左右数量分别相等，但不是有效的括号。这是因为结果还与括号的位置有关。

         仔细分析我们发现，对于有效的括号，它的部分子表达式仍然是有效的括号，比如 {()[()]} 是一个有效的括号，()[{}] 是有效的括号，[()] 也是有效的括号。并且当我们每次删除一个最小的括号对时，我们会逐渐将括号删除完。比如下面的例子。

        
        
         
         */
        printLog("bracket1:\(isValidBracket(bracket1))")
        printLog("bracket2:\(isValidBracket(bracket2))")
        printLog("bracket3:\(isValidBracket(bracket3))")
        printLog("bracket4:\(isValidBracket(bracket4))")
        printLog("bracket5:\(isValidBracket(bracket5))")
    }
    
    
    //  括号是否有效
    func isValidBracket(_ s:String) -> Bool {
        if s.count % 2 != 0 {
            return false
        }
        var result = [Character]()
        for item in s {
            switch item {
            case "(","{","[":
                result.append(item)
            case ")":
                guard let popResult = result.popLast() else { return false }
                if String(popResult) != "(" {
                    return false
                }
                
            case "}":
                guard let popResult = result.popLast() else { return false }
                if String(popResult) != "{" {
                    return false
                }
                
            case "]":
                guard let popResult = result.popLast() else { return false }
                if String(popResult) != "[" {
                    return false
                }
            default:
                break;
            }
        }
        if result.count != 0 {
            return false
        }
        return true
    }
    
}
