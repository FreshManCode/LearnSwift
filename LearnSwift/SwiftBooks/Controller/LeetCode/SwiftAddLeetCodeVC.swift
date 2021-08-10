//
//  SwiftAddLeetCodeVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/3/1.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SwiftAddLeetCodeVC: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        p_initDefautData()
        /*
         给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。
         
         请你将两个数相加，并以相同形式返回一个表示和的链表。
         
         你可以假设除了数字 0 之外，这两个数都不会以 0 开头。
         
         [0,1,2]
         [1,2,3]
         结果为 531
         210 + 321 = 531
         
         来源：力扣（LeetCode）
         链接：https://leetcode-cn.com/problems/add-two-numbers
         */
    }
    
    
    func p_initDefautData()  {
        title = "LeetCode两数相加"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1. 两数之和我自己的想法",
                                            subTitle: "",
                                            funName: "SwiftSumLeetMyCode"))
        listItemArray.append(SWBookListItem(title: "2. 两数之和优解",
                                            subTitle: "",
                                            funName: "SwiftSumLeetModifyCode"))
        tableView.reloadData()
    }
    
    
    // MARK: - 两数之和
    @objc  func SwiftSumLeetMyCode()  {
        //        twoAddSum([1,2,3], [4,5,6])
        //        twoAddSum([2,4,3], [5,6,4])
        
        testTwoListNode()
        
    }
    
    // MARK: - 两数之和
    @objc  func SwiftSumLeetModifyCode()  {
        /*
         思路及算法
         
         注意到方法一的时间复杂度较高的原因是寻找 target - x
         的时间复杂度过高。因此，我们需要一种更优秀的方法，能够快速寻找数组中是否存在目标元素。如果存在，我们需要找出它的索引。
         
         使用哈希表，可以将寻找 target - x 的时间复杂度降低到从 O(N)O(N) 降低到 O(1)O(1)。
         
         这样我们创建一个哈希表，对于每一个 x，我们首先查询哈希表中是否存在 target - x，然后将 x 插入到哈希表中，即可保证不会让 x 和自己匹配。
         
         作者：LeetCode-Solution
         链接：https://leetcode-cn.com/problems/two-sum/solution/liang-shu-zhi-he-by-leetcode-solution/
         来源：力扣（LeetCode）
         */
        
    }
    
    func twoAddSum(_ num1: [Int], _ num2: [Int]) -> [Int] {
        let result = transToNormalNumber(num1) + transToNormalNumber(num2)
        printLog("nums1 is:\(num1) \n nums2 is:\(num2) \n ,result is:\(result)")
        return ListNode.transferNumberToReverseArray(result)
    }
    
    
    func transToNormalNumber(_ numbers:[Int]) -> Int {
        var sum = 0
        for (index,value) in numbers.enumerated() {
            sum = sum + value * Int(pow(Float(10), Float(index)))
        }
        print("numbers is:\(numbers) \n sum is:\(sum)")
        return sum
    }
    
    
    
   
    
    
    func addTwoNumbers(_ l1:ListNode?,_ l2:ListNode?) -> ListNode? {
        guard let myL1 = l1 else { return nil }
        guard let myL2 = l2 else { return nil }
        
        return nil
    }
    
    func testTwoListNode() {
        //        var index = 0
        let array1 = [1,2,3]
        let node = ListNode.createNode(array1)
        let nodeResult = ListNode.transListNodeToListArray(node)
        printLog("nodeResult is:\(nodeResult)")
        
    }
    
    
    
}


class ListNode {
    var val:Int
    var next:ListNode?
    init() {
        self.val = 0
        self.next = nil
    }
    init(_ val:Int) {
        self.val = val
        self.next = nil
    }
    init(_ val:Int,_ next:ListNode?) {
        self.val = val
        self.next = next
    }
}

extension ListNode {
    
    
    /// 把数组转为ListNode
    /// - Parameter numbers: 数组
    /// - Returns: 链表
    class func createNode(_ numbers:[Int]) -> ListNode? {
        if numbers.count < 1 {
            return nil
        }
        let headNode = ListNode.init(numbers[0])
        var node:ListNode = headNode
        
        let length = numbers.count
        var index = 1
        
        while index < length {
            let my_node = ListNode.init(numbers[index])
            node.next = my_node
            node = node.next!
            index += 1
        }
        return headNode
    }
    
    
    class func transferNumberToReverseArray(_ number:Int) -> [Int] {
        
        let string = String(number)
        let length = string.count
        var result:[Int] = []
        for index in 0..<length {
            let resultStr = (string as NSString).substring(with: NSMakeRange(length - index - 1,1))
            result.append(Int(resultStr)!)
        }
        return result
    }
    
    
    /// 把链表打印为数组
    /// - Parameter number: 数组
    /// - Returns: 链表
    class func transListNodeToListArray(_ node:ListNode?) -> [Int] {
        if node != nil {
            var nextNode = node
            var result = [Int]()
            while nextNode != nil {
                result.append(nextNode!.val)
                nextNode = nextNode?.next
            }
            return result
        }
        return []
    }
    
    
}
