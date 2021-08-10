//
//  SWDeleteDuplicateVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/10.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWDeleteDuplicateVC: SWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    func p_initDefautData()  {
        title = "删除排序链表中的重复元素以及"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.删除排序链表中的重复元素(我自己实现) ",
                                            subTitle: "",
                                            funName: "myDeleteDuplicateElement"))
        
        
        
        tableView.reloadData()
    }
    
    // MARK: - 删除排序链表中的重复元素
    @objc func myDeleteDuplicateElement() {
        /**
         
         存在一个按升序排列的链表，给你这个链表的头节点 head ，请你删除所有重复的元素，使每个元素 只出现一次 。

         返回同样按升序排列的结果链表。
         
         输入：head = [1,1,2]
         输出：[1,2]
         
         输入：head = [1,1,2,3,3]
         输出：[1,2,3]
         
         题解:
         https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list/solution/dong-hua-yan-shi-83-shan-chu-pai-xu-lie-lhuvr/
         
         
         思路
         标签：链表
         指定 cur 指针指向头部 head
         当 cur 和 cur.next 的存在为循环结束条件，当二者有一个不存在时说明链表没有去重复的必要了
         当 cur.val 和 cur.next.val 相等时说明需要去重，则将 cur 的下一个指针指向下一个的下一个，这样就能达到去重复的效果
         如果不相等则 cur 移动到下一个位置继续循环

        
         链接：https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list/solution/hua-jie-suan-fa-83-shan-chu-pai-xu-lian-biao-zhong/
         
         */
        let nodeOne = ListNode.createNode([1,1,2,3])
        let nodeTwo = ListNode.createNode([1,1,2,3,3,4,4,5,5,5,5])
        
        let result1 = ListNode.transListNodeToListArray(myDeleteDuplicates(nodeOne))
        let result2 = ListNode.transListNodeToListArray(myDeleteDuplicates(nodeTwo))
        print("result1:\(result1)")
        print("result2:\(result2)")
        
       
        
    }
    
    
    func myDeleteDuplicates(_ head: ListNode?) -> ListNode? {
        guard let headNode = head else {
            return nil
        }
        var currentNode = headNode
        while currentNode.next != nil {
            if currentNode.val == currentNode.next!.val {
                if currentNode.next!.next != nil {
                    currentNode.next = currentNode.next!.next!
                } else {
                    currentNode.next = nil
                }
            } else {
                currentNode = currentNode.next!
            }
        }
        return headNode
    }

    
}
