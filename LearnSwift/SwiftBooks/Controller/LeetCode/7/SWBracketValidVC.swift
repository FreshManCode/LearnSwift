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
        
        listItemArray.append(SWBookListItem(title: "合并两个有序链表",
                                            subTitle: "",
                                            funName: "compositeTwoOrderList"))
        
        
        
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
        
        printLog("my_bracket1:\(myIsValidInputBracket(bracket1))")
        printLog("my_bracket2:\(myIsValidInputBracket(bracket2))")
        printLog("my_bracket3:\(myIsValidInputBracket(bracket3))")
        printLog("my_bracket4:\(myIsValidInputBracket(bracket4))")
        printLog("my_bracket5:\(myIsValidInputBracket(bracket5))")
        
        
        
    }
    
    
    func myIsValidInputBracket(_ s:String) -> Bool {
        var tempBrackets = [Character]()
        for char in s {
            switch char {
            case "(","{","[":
                tempBrackets.append(char)
            case ")":
                guard let popResult = tempBrackets.popLast() else { return false }
                if popResult != "(" {
                    return false
                }
            case "}" :
                guard let popResult = tempBrackets.popLast() else { return false }
                if popResult != "{" {
                    return false
                }
            case "]":
                guard let popResult = tempBrackets.popLast() else { return false }
                if popResult != "[" {
                    return false
                }
            default:
                break;
            }
        }
        if (tempBrackets.count != 0) {
            return false
        }
        return true
        
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
    
    
    // MARK: - 合并两个有序链表
    /**
     
     将两个升序链表合并为一个新的 升序 链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。
     输入：l1 = [1,2,4], l2 = [1,3,4]
     输出：[1,1,2,3,4,4]
     链接:https://leetcode-cn.com/problems/merge-two-sorted-lists/
     
     题解: https://leetcode-cn.com/problems/merge-two-sorted-lists/solution/he-bing-liang-ge-you-xu-lian-biao-by-leetcode-solu/
     
     
     思路
     
     我们可以用迭代的方法来实现上述算法。当 l1 和 l2 都不是空链表时，判断 l1 和 l2 哪一个链表的头节点的值更小，将较小值的节点添加到结果里，当一个节点被添加到结果里之后，将对应链表中的节点向后移一位。
     
     算法
     
     首先，我们设定一个哨兵节点 prehead ，这可以在最后让我们比较容易地返回合并后的链表。我们维护一个 prev 指针，我们需要做的是调整它的 next 指针。然后，我们重复以下过程，直到 l1 或者 l2 指向了 null ：如果 l1 当前节点的值小于等于 l2 ，我们就把 l1 当前的节点接在 prev 节点的后面同时将 l1 指针往后移一位。否则，我们对 l2 做同样的操作。不管我们将哪一个元素接在了后面，我们都需要把 prev 向后移一位。
     
     在循环终止的时候， l1 和 l2 至多有一个是非空的。由于输入的两个链表都是有序的，所以不管哪个链表是非空的，它包含的所有元素都比前面已经合并链表中的所有元素都要大。这意味着我们只需要简单地将非空链表接在合并链表的后面，并返回合并链表即可。
     
     作者：LeetCode-Solution
     链接：https://leetcode-cn.com/problems/merge-two-sorted-lists/solution/he-bing-liang-ge-you-xu-lian-biao-by-leetcode-solu/
     来源：力扣（LeetCode）
     著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
     
     
     */
    @objc func compositeTwoOrderList()  {
        let nodeOne  = generateNode([1,2,4])
        let nodeTwo  = generateNode([1,1,4])
        print("nodeOne:\(mapListNodeToArray(nodeOne))")
        print("nodeOne:\(mapListNodeToArray(nodeTwo))")
        
        let resultNode = mergeTwoLists(nodeOne, nodeTwo)
        print("resultNode:\(mapListNodeToArray(resultNode))")
        
        let _nodeOne  = generateNode([1,2,4])
        let _nodeTwo  = generateNode([1,1,4])
        print("nodeOne:\(mapListNodeToArray(_nodeOne))")
        print("nodeOne:\(mapListNodeToArray(_nodeTwo))")
        
        let resultNode2 = myMergeTwoList(_nodeOne, _nodeTwo)
        print("resultNode2:\(mapListNodeToArray(resultNode2))")
    }
    
    func generateNode(_ inputs:[Int]) -> OrderListNode? {
//        先创建一个链表
        let nodeOne:OrderListNode? = OrderListNode()
        let array1 = inputs
//       创建头指针 这个头指针的意义在于，在访问链表时，总要知道链表存储在什么位置（从何处开始访问），由于链表的特性（next指针），知道了头指针，那么整个链表的元素都能够被访问，也就是说头指针是必须存在的。
        var currentOne = nodeOne
        for value in array1 {
            let tempNode = OrderListNode(value)
            currentOne?.next = tempNode
            currentOne = currentOne?.next!
        }
        return nodeOne?.next
    }
    
    
    func myMergeTwoList(_ l1:OrderListNode?,_ l2:OrderListNode?)-> OrderListNode? {
//         创建一个新的链表
        let result = OrderListNode()
//        创建链表的头指针
        var current = result
        var node1 = l1
        var node2 = l2
        while let current1 = node1, let current2 = node2 {
            if (current1.val < current2.val) {
                current.next = current1
                node1 = current1.next
            } else {
                current.next = current2
                node2 = current2.next
            }
            current = current.next!
        }
        current.next = node1 ?? node2
        return result.next
    }
    
    
    
    
    
    
    func mergeTwoLists(_ l1: OrderListNode?, _ l2: OrderListNode?) -> OrderListNode? {
        let result = OrderListNode()
        var current = result
        var myL1 = l1,myL2 = l2;
        while let current1 = myL1,let current2 = myL2 {
            if (current1.val < current2.val) {
                current.next = current1
                myL1 = current1.next
            } else {
                current.next = current2
                myL2 = current2.next
            }
            current = current.next!
        }
        current.next = myL1 ?? myL2
        return result.next
    }
    
    func mapListNodeToArray(_ listNode:OrderListNode?) -> [Int] {
        guard let node = listNode else { return [] }
        var resultArray = [Int]()
        var currentNode = node
        while currentNode.next != nil {
            resultArray.append(currentNode.val)
            currentNode = currentNode.next!
        }
        resultArray.append(currentNode.val)
        return resultArray
    }
}

class OrderListNode {
    public var val: Int
    public var next: OrderListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: OrderListNode?) { self.val = val; self.next = next;}
}
