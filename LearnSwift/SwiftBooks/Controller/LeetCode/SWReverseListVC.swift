//
//  SWReverseListVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/9/6.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWReverseListVC: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    func p_initDefautData()  {
        title = " 反转链表"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.  反转链表 ",
                                            subTitle: "",
                                            funName: "myReverseList"))
        listItemArray.append(SWBookListItem(title: "1.1  反转链表(迭代法) ",
                                            subTitle: "",
                                            funName: "reverseList"))
        listItemArray.append(SWBookListItem(title: "2  存在重复元素 ",
                                            subTitle: "",
                                            funName: "myContainsDuplicate"))
        
        
        tableView.reloadData()
    }
    
    // MARK: - 1.反转链表
    @objc func myReverseList()  {
        /**
         给你单链表的头节点 head ，请你反转链表，并返回反转后的链表。
         
         输入：head = [1,2,3,4,5]
         输出：[5,4,3,2,1]
         
         输入：head = [1,2]
         输出：[2,1]
         
         */
        
        func reverseList(_ head: ListNode?) -> ListNode? {
            if head == nil {
                return nil
            }
            var listArray = [ListNode]()
            var node = head
            while node?.next != nil {
                let tempNode = node
                if listArray.count > 0 {
                    listArray.insert(tempNode!, at: 0)
                } else {
                    listArray.append(tempNode!)
                }
                node = node?.next
            }
            listArray.insert(node!, at: 0)
            var resultNode:ListNode?
            var headNode:ListNode?
            for (index,node) in listArray.enumerated() {
                if headNode == nil {
                    resultNode = node
                    headNode = resultNode
                    if listArray.count > 1 {
                        headNode?.next = listArray[index + 1]
                        headNode = headNode?.next
                    }
                }
                else {
                    if index < listArray.count - 1 {
                        headNode?.next = listArray[index + 1]
                        headNode = headNode?.next
                    } else {
                        headNode = node
                        headNode?.next = nil
                    }
                }
                
                
            }
            return resultNode
        }
        
        let list1 = ListNode.createNode([1,2,3,4,5])
        let list2 = ListNode.createNode([1,2])
        
        let reverse_1 = reverseList(list1)
        let reverse_2 = reverseList(list2)
        
        print("1:\(ListNode.transListNodeToListArray(reverse_1))")
        print("1:\(ListNode.transListNodeToListArray(reverse_2))")
        
    }
    
    // MARK: - 1.1  反转链表(迭代法)
    @objc func reverseList()  {
        /**
         假设链表为 1→2→3→∅，我们想要把它改成 3∅←1←2←3。
         
         在遍历链表时，将当前节点的next 指针改为指向前一个节点。
         由于节点没有引用其前一个节点，因此必须事先存储其前一个节点。在更改引用之前，还需要存储后一个节点。最后返回新的头引用。
         
         链接：https://leetcode-cn.com/problems/reverse-linked-list/solution/fan-zhuan-lian-biao-by-leetcode-solution-d1k2/
         */
        func reverseList(_ head: ListNode?) -> ListNode? {
            if head == nil {
                return nil
            }
            var currentNode = head
            var preNode:ListNode?
            while currentNode != nil {
                //              记录正常遍历下一个节点
                let nextNode = currentNode?.next
                //              将当前节点的next 指针改为指向前一个节点
                currentNode?.next = preNode
                //              前一个节点指向改变
                preNode = currentNode
                //              在更改引用之前，还需要存储后一个节点
                currentNode = nextNode
            }
            return preNode
        }
        
        let list1 = ListNode.createNode([1,2,3,4,5])
        let list2 = ListNode.createNode([1,2])
        
        let reverse_1 = reverseList(list1)
        let reverse_2 = reverseList(list2)
        
        print("1:\(ListNode.transListNodeToListArray(reverse_1))")
        print("2:\(ListNode.transListNodeToListArray(reverse_2))")
    }
    
    
    // MARK: - 2.存在重复元素
    @objc func myContainsDuplicate()  {
        /**
         给定一个整数数组，判断是否存在重复元素。
         
         如果存在一值在数组中出现至少两次，函数返回 true 。如果数组中每个元素都不相同，则返回 false 。
         
         示例 1:
         
         输入: [1,2,3,1]
         输出: true
         
         示例 2:
         
         输入: [1,2,3,4]
         输出: false
         
         
         */
        func myContainsDuplicate(_ nums: [Int]) -> Bool {
            /**
             2.哈希表法，map集合
             3.利用set集合的唯一性,把值加入，看长度是否一致
             */
            var mapArray = [Int:Int]()
            for item in nums {
                if mapArray[item] != nil {
                    return true
                } else {
                    mapArray[item] = item
                }
            }
            return false
        }
        
        func containsDuplicate(_ nums: [Int])-> Bool {
            var result = nums
//          先对数组进行排序 (a > b 降序) a < b 升序
            result.sort { (a, b) -> Bool in
//              先按升序排列
                return a < b
            }
//            print("nums:\(nums)_ result:\(result)")
            for index in 0..<result.count - 1 {
                if result[index] == result[index + 1] {
                    return true
                }
            }
            return false
            
        }
        let  input1 = [1,2,3,1]
        let  input2 = [1,2,3,4]
        let  input3 = [1,1,1,3,3,4,3,2,4,2]
        
        print("my:\(myContainsDuplicate(input1)) sort:\(containsDuplicate(input1))")
        print("my:\(myContainsDuplicate(input2)) sort:\(containsDuplicate(input2))")
        print("my:\(myContainsDuplicate(input3)) sort:\(containsDuplicate(input3))")
        
    }
    
    
    
    
    
}
