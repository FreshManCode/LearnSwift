//
//  SWTrailingZeroesVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/30.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWTrailingZeroesVC: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    
    func p_initDefautData()  {
        title = "相同的树-对称二叉树"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.阶乘后的0 ",
                                            subTitle: "",
                                            funName: "myTrailingZeros"))
        listItemArray.append(SWBookListItem(title: "1.1 阶乘后的0 (优化) ",
                                            subTitle: "",
                                            funName: "myModifyTrailingZeros"))
        listItemArray.append(SWBookListItem(title: "2. 快乐数(效率低) ",
                                            subTitle: "",
                                            funName: "myIsHappy"))
        listItemArray.append(SWBookListItem(title: "2.1 快乐数(快慢指针) ",
                                            subTitle: "",
                                            funName: "isHappyFastAndSlowPointer"))
        listItemArray.append(SWBookListItem(title: "3.移除链表元素 ",
                                            subTitle: "",
                                            funName: "myRemoveElements"))
        
        
        
        
        

        tableView.reloadData()
    }
    
    // MARK: - 阶乘后的0
    @objc func myTrailingZeros()  {
        /**
         
         阶乘后的零
         给定一个整数 n，返回 n! 结果尾数中零的数量。
         
         示例 1:
         
         输入: 3
         输出: 0
         解释: 3! = 6, 尾数中没有零。
         示例 2:
         
         输入: 5
         输出: 1
         解释: 5! = 120, 尾数中有 1 个零.
         
         */
        
        func trailingNumber(_ n:Int) -> Int {
            if n <= 2 {
                return n
            }else {
                return n * trailingNumber(n - 1)
            }
        }
        /**
         解法一:先使用阶乘计算出来这一项,然后在根据尾数是否能被0整除.逐渐移动位置计算.在n>20时就会溢出.不可取
         */
        func trailingZeroes(_ n: Int) -> Int {
            var resultCount = 0
            var lastNumber = trailingNumber(n)
            while lastNumber % 10 == 0 {
                resultCount += 1
                lastNumber = lastNumber / 10
            }
            return resultCount
        }
        print("10:\(trailingZeroes(10))")
        print("15:\(trailingZeroes(15))")
    }
    
    // MARK: - 阶乘后的0 (优化)
    @objc func myModifyTrailingZeros()  {
        /**
         解题思路
         计算有多少个5，就有多个0。因为5前面一定有2根他乘
         但是25有两个5，125有三个，也就是5的n次算会产生n个0
         所以递归中每次计算5的某次方有产生多少个0
         
         链接：https://leetcode-cn.com/problems/factorial-trailing-zeroes/solution/yi-xing-dai-ma-di-gui-logn-by-hello-5c-o81a/
         */
        func trailingZeroes(_ n: Int) -> Int {
            return n >= 5  ? n / 5 + trailingZeroes(n / 5) : 0
        }
        
    }
    
    // MARK: - 2. 快乐数
    @objc func myIsHappy()  {
        /**
         编写一个算法来判断一个数 n 是不是快乐数。
         
         「快乐数」定义为：
         
         对于一个正整数，每一次将该数替换为它每个位置上的数字的平方和。
         然后重复这个过程直到这个数变为 1，也可能是 无限循环 但始终变不到 1。
         如果 可以变为  1，那么这个数就是快乐数。
         如果 n 是快乐数就返回 true ；不是，则返回 false
         */
        
        func isHappy(_ n: Int) -> Bool {
            /**
             把给定的数进行分解,然后按照平方和进行比较.
             */
            var index = 0
            var number = n
            var tempArray = [Int]()
            while index < 100 {
                if number < 10 {
                    if tempArray.count == 0 {
                        if number * number != 1 && number * number < 10 {
                            return false
                        }
                    }
                    
                    var result = 0
                    index += 1
                    tempArray.append(number)
                    for item in tempArray {
                        result += item * item
                    }
                    number = result
                    if result == 1 {
                        return true
                    } else {
                        tempArray.removeAll()
                    }
                } else {
                    tempArray.append(number % 10)
                    number = number / 10
                }
            }
            return false
        }
        print("23:\(isHappy(23))")
        print("19:\(isHappy(19))")
        print("2:\(isHappy(2))")
    }
    
    // MARK: - 快乐数(快慢指针)
    @objc func isHappyFastAndSlowPointer()  {
        /**
         解题思路：
         方法：
         使用 “快慢指针” 思想，找出循环：“快指针” 每次走两步，“慢指针” 每次走一步，当二者相等时，即为一个循环周期。此时，判断是不是因为 1 引起的循环，是的话就是快乐数，否则不是快乐数。
         注意：此题不建议用集合记录每次的计算结果来判断是否进入循环，因为这个集合可能大到无法存储；另外，也不建议使用递归，同理，如果递归层次较深，会直接导致调用栈崩溃。不要因为这个题目给出的整数是 int 型而投机取巧。
         
         判断循环用快慢指针
         
         链接：https://leetcode-cn.com/problems/happy-number/solution/shi-yong-kuai-man-zhi-zhen-si-xiang-zhao-chu-xun-h/
         
         */
        
        func caculateSum(_ n : Int) ->Int {
            var number = n
            var result = 0
            while number > 0 {
                let bitNumber = number % 10
                result += bitNumber * bitNumber
                number = number / 10
            }
            return result
        }
        
        func isHappy(_ n:Int)->Bool {
            var fast = n
            var slow = n
            var first = true
            while first || slow != fast {
                if first {
                    first = false
                }
                slow = caculateSum(slow)
                fast = caculateSum(fast)
                fast = caculateSum(fast)
            }
            return slow == 1
        }
        print("23:\(isHappy(23))")
        print("19:\(isHappy(19))")
        print("2:\(isHappy(2))")
    }
    
    // MARK: - 移除链表元素
    @objc func myRemoveElements()  {
        /**
         给你一个链表的头节点 head 和一个整数 val ，请你删除链表中所有满足 Node.val == val 的节点，并返回 新的头节点 。
         
         链表的定义具有递归的性质，因此链表题目常可以用递归的方法求解。这道题要求删除链表中所有节点值等于特定值的节点，可以用递归实现。

         对于给定的链表，首先对除了头节点 head 以外的节点进行删除操作，然后判断head 的节点值是否等于给定的val。如果 head 的节点值等于val，则 head 需要被删除，因此删除操作后的头节点为 head.next；如果head 的节点值不等于val，则head 保留，因此删除操作后的头节点还是 ead。上述过程是一个递归的过程。

         递归的终止条件是 head 为空，此时直接返回head。当 head 不为空时，递归地进行删除操作，然后判断 head 的节点值是否等于 val 并决定是否要删除 head。

         链接：https://leetcode-cn.com/problems/remove-linked-list-elements/solution/yi-chu-lian-biao-yuan-su-by-leetcode-sol-654m/
         */
        
        func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
            let node = head
            if node == nil {
                return head
            }
            node?.next = removeElements(node?.next, val)
            return node?.val == val ? node?.next : node
        }
        
        let nodeOne = ListNode.createNode([1,2,3,4,5,6,7,7,8,7])
        let nodeTwo = ListNode.createNode([1,2,3,4,5,6,7,8,9,6])
        
        let nodeOneResult = removeElements(nodeOne, 7)
        let nodeTwoResult = removeElements(nodeTwo, 6)
        
        print("1:\(ListNode.transListNodeToListArray(nodeOneResult))")
        print("2:\(ListNode.transListNodeToListArray(nodeTwoResult))")
        
        
        
        /**
         方法二：迭代
         也可以用迭代的方法删除链表中所有节点值等于特定值的节点。

         用temp 表示当前节点。如果temp 的下一个节点不为空且下一个节点的节点值等于给定的val，则需要删除下一个节点。删除下一个节点可以通过以下做法实现：

         temp.next=temp.next.next

         如果 temp 的下一个节点的节点值不等于给定的val，则保留下一个节点，将 temp 移动到下一个节点即可。

         当temp 的下一个节点为空时，链表遍历结束，此时所有节点值等于val 的节点都被删除。

         具体实现方面，由于链表的头节点head 有可能需要被删除，因此如果头结点需要被删除,则从head.next节点开始，然后遍历链表进行删除操作。最终返回 \textit{dummyHead}.\textit{next}dummyHead.next 即为删除操作后的头节点。

         链接：https://leetcode-cn.com/problems/remove-linked-list-elements/solution/yi-chu-lian-biao-yuan-su-by-leetcode-sol-654m/
         */
        func removeElements2(_ head: ListNode?, _ val: Int) -> ListNode? {
//          指向head 的头结点
            var preNode = head
            //删除值相同的头结点后，可能新的头结点也值相等，用循环解决
            while head != nil && head?.val == val {
                preNode = head?.next
            }
            if preNode == nil {
                return preNode
            }
            //确保当前结点后还有结点
            while preNode?.next != nil {
                if preNode?.next?.val == val  {
                    //删除结点值与val相同的结点
                    preNode?.next = preNode?.next?.next
                } else {
                    preNode = preNode?.next
                }
            }
            return head
        }
        
        
        let _nodeOne = ListNode.createNode([1,2,3,4,5,6,7,7,8,7])
        let _nodeTwo = ListNode.createNode([1,2,3,4,5,6,7,8,9,6])
        
        let _nodeOneResult = removeElements2(_nodeOne, 7)
        let _nodeTwoResult = removeElements2(_nodeTwo, 6)
        
        print("1:\(ListNode.transListNodeToListArray(_nodeOneResult))")
        print("2:\(ListNode.transListNodeToListArray(_nodeTwoResult))")
        
        
    }

    
    
}
