//
//  SWSummaryRangesViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/9/13.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWSummaryRangesViewController: SWBaseViewController {
    
    let ranges_1 = [0,1,2,4,5,7]
    let ranges_2 = [0,2,3,4,6,8,9]
    
//  初始化两个一样节点的链表,防止在执行完判断逻辑之后,更改了链表结构,导致判断不准确
    let listNode1 = ListNode.createNode([1,2,2,1])
    let listNode2 = ListNode.createNode([1,2])
    let listNode3 = ListNode.createNode([1,2,3,2,1])
    
    let listNode11 = ListNode.createNode([1,2,2,1])
    let listNode22 = ListNode.createNode([1,2])
    let listNode33 = ListNode.createNode([1,2,3,2,1])
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    
    func p_initDefautData()  {
        title = " 汇总区间"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.  汇总区间 ",
                                            subTitle: "",
                                            funName: "mySummaryRanges"))
        listItemArray.append(SWBookListItem(title: "1.1  汇总区间 (双指针) ",
                                            subTitle: "",
                                            funName: "summaryRanges"))
        listItemArray.append(SWBookListItem(title: "2. 2 的幂 ",
                                            subTitle: "",
                                            funName: "myIsPowerOfTwo"))
        listItemArray.append(SWBookListItem(title: "2.1 2 的幂(位运算) ",
                                            subTitle: "",
                                            funName: "isPowerOfTwo"))
        listItemArray.append(SWBookListItem(title: "3 用栈实现队列 ",
                                            subTitle: "",
                                            funName: "myQueue"))
        listItemArray.append(SWBookListItem(title: "4. 回文链表 ",
                                            subTitle: "",
                                            funName: "myIsPalindrome"))
        listItemArray.append(SWBookListItem(title: "4.1 回文链表(双指针) ",
                                            subTitle: "",
                                            funName: "isPalindrome"))
        
        
        
        

        
        tableView.reloadData()
    }
    
    
    // MARK: - 汇总区间
    @objc func mySummaryRanges()  {
        /**
         给定一个无重复元素的有序整数数组 nums 。
         
         返回 恰好覆盖数组中所有数字 的 最小有序 区间范围列表。也就是说，nums 的每个元素都恰好被某个区间范围所覆盖，并且不存在属于某个范围但不属于 nums 的数字 x 。
         
         列表中的每个区间范围 [a,b] 应该按如下格式输出：
         
         "a->b" ，如果 a != b
         "a" ，如果 a == b
         
         输入：nums = [0,1,2,4,5,7]
         输出：["0->2","4->5","7"]
         解释：区间范围是：
         [0,2] --> "0->2"
         [4,5] --> "4->5"
         [7,7] --> "7"
         
         方法一：
         一次遍历
         我们从数组的位置 0 出发，向右遍历。每次遇到相邻元素之间的差值大于 1 时，我们就找到了一个区间。遍历完数组之后，就能得到一系列的区间的列表。
         
         在遍历过程中，维护下标ow 和 high 分别记录区间的起点和终点，对于任何区间都有low≤high。当得到一个区间时，根据 low 和 high 的值生成区间的字符串表示。
         
         当low<high 时，区间的字符串表示为 `‘low→high"；
         
         当low=high 时，区间的字符串表示为 `‘low"。
         
         链接：https://leetcode-cn.com/problems/summary-ranges/solution/hui-zong-qu-jian-by-leetcode-solution-6zrs/
         
         
         */
        func summaryRanges(_ nums: [Int]) -> [String] {
            if nums.count == 0 {
                return []
            }
            else if nums.count == 1 {
                return ["\(nums.first!)"]
            }
            var result      = [String]()
            var left  = 0
            var right = 0
            var lastNumber = nums.first!
            
            for index in 1..<nums.count {
                let currentNumber = nums[index]
                if currentNumber - lastNumber == 1 {
                    right += 1
                    lastNumber = currentNumber
                } else {
                    if left == right {
                        result.append("\(nums[left])")
                    } else {
                        result.append("\(nums[left])->\(nums[right])")
                    }
                    left  = index
                    right = left
                    lastNumber = currentNumber
                }
                
            }
            if left == right {
                result.append("\(nums[left])")
            } else {
                result.append("\(nums[left])->\(nums[right])")
            }
            return result
        }
        
        print("1:\(summaryRanges(ranges_1))")
        print("2:\(summaryRanges(ranges_2))")
        
    }
    
    // MARK: - 汇总区间 (双指针)
    @objc func summaryRanges()  {
        /**
         分析： 使用 双指针，i 指向每个区间的起始位置，j 从 i 开始向后遍历直到不满足连续递增（或 j 达到数组边界），则当前区间结束；然后将 i 指向更新为 j + 1，作为下一个区间的开始位置，j 继续向后遍历找下一个区间的结束位置，如此循环，直到输入数组遍历完毕。
         
         
         链接：https://leetcode-cn.com/problems/summary-ranges/solution/shuang-zhi-zhen-100-miao-dong-by-sweetie-7vo6/
         
         */
        func summaryRanges(_ nums: [Int]) -> [String] {
            
            var result      = [String]()
            // i 初始指向第 1 个区间的起始位置
            var i  = 0
            for j in 0 ..< nums.count {
                // j 向后遍历，直到不满足连续递增(即 nums[j] + 1 != nums[j + 1])
                // 或者 j 达到数组边界，则当前连续递增区间 [i, j] 遍历完毕，将其写入结果列表。
                if j + 1 == nums.count || nums[j] + 1 != nums[j + 1] {
                    var tempStr = "\(nums[i])"
                    if i != j {
                        tempStr =  tempStr + "->\(nums[j])"
                    }
                    result.append(tempStr)
                    // 将 i 指向更新为 j + 1，作为下一个区间的起始位置
                    i = j + 1
                }
            }
            return result
        }
        print("1:\(summaryRanges(ranges_1))")
        print("2:\(summaryRanges(ranges_2))")
        
    }
    
    // MARK: - 2 的幂
    @objc func myIsPowerOfTwo()  {
        /**
         给你一个整数 n，请你判断该整数是否是 2 的幂次方。如果是，返回 true ；否则，返回 false 。
         
         如果存在一个整数 x 使得 n == 2x ，则认为 n 是 2 的幂次方。
         
         */
        func isPowerOfTwo(_ n: Int) -> Bool {
            var input = n
            while input >= 2  {
                if input % 2 != 0 {
                    return  false
                }
                input = input / 2
            }
            return input == 1
        }
        print("8:\(isPowerOfTwo(8))")
        print("16:\(isPowerOfTwo(16))")
        print("4:\(isPowerOfTwo(4))")
        print("3:\(isPowerOfTwo(3))")
        
    }
    
    // MARK: - 2 的幂(位运算)
    @objc func isPowerOfTwo()  {
        /**
         https://leetcode-cn.com/problems/power-of-two/solution/power-of-two-er-jin-zhi-ji-jian-by-jyd/
         解题思路：
         若 n = 2^x;
           且 x 为自然数（即 n 为 22的幂），则一定满足以下条件：
         恒有 n & (n - 1) == 0，这是因为：
         n 二进制最高位为 1，其余所有位为 0；
         n - 1 二进制最高位为 0，其余所有位为 1；
         一定满足 n > 0。

         通过 n > 0 且 n & (n - 1) == 0 即可判定是否满足 n = 2^x
          。
         */
        func isPowerOfTwo(_ n: Int) -> Bool {
            return n > 0 && (n & (n - 1)) == 0
        }
        print("8:\(isPowerOfTwo(8))")
        print("16:\(isPowerOfTwo(16))")
        print("4:\(isPowerOfTwo(4))")
        print("3:\(isPowerOfTwo(3))")
        
    }
    
    // MARK: - 3 用栈实现队列
    @objc func myQueue()  {
        /**
         请你仅使用两个栈实现先入先出队列。队列应当支持一般队列支持的所有操作（push、pop、peek、empty）：

         实现 MyQueue 类：

         void push(int x) 将元素 x 推到队列的末尾
         int pop() 从队列的开头移除并返回元素
         int peek() 返回队列开头的元素
         boolean empty() 如果队列为空，返回 true ；否则，返回 false
          

         说明：

         你只能使用标准的栈操作 —— 也就是只有 push to top, peek/pop from top, size, 和 is empty 操作是合法的。
         你所使用的语言也许不支持栈。你可以使用 list 或者 deque（双端队列）来模拟一个栈，只要是标准的栈操作即可。
         */
        
    }
    
    // MARK: - 4. 回文链表
    @objc func myIsPalindrome()  {
        /**
         给你一个单链表的头节点 head ，请你判断该链表是否为回文链表。如果是，返回 true ；否则，返回 false 。
         输入：head = [1,2,2,1]
         */
        
        func isPalindrome(_ head: ListNode?) -> Bool {
            var result = [Int]()
            var listNode = head
            while listNode != nil {
                result.append(listNode!.val)
                listNode = listNode?.next
            }
            var index = 0
            while index < result.count {
                let left = result[index]
                let right = result[result.count - index - 1]
                if left != right {
                    return false
                }
                index += 1
            }
            return true
        }
        
        print("1:\(isPalindrome(listNode1))")
        print("2:\(isPalindrome(listNode2))")
        print("3:\(isPalindrome(listNode3))")
    }
    
    // MARK: - 4.1 回文链表(双指针)
    @objc func isPalindrome()  {
        /**快指针走到末尾，慢指针刚好到中间。其中慢指针将前半部分反转。然后比较。*/
        func isPalindrome(_ head: ListNode?) -> Bool {
            var preNode:ListNode?
            var slowNode = head
            var fastNode = head
//          翻转前半段链表
            while fastNode != nil && fastNode?.next != nil {
                fastNode = fastNode?.next?.next
                let tempNode = slowNode?.next
                slowNode?.next = preNode
                preNode = slowNode
                slowNode = tempNode
            }
            if fastNode != nil {
                slowNode = slowNode?.next
            }
            
            while preNode != nil && slowNode != nil {
                if preNode?.val != slowNode?.val {
                    return false
                }
                preNode = preNode?.next
                slowNode = slowNode?.next
            }
            return true
        }
        
        print("1:\(isPalindrome(listNode11))")
        print("2:\(isPalindrome(listNode22))")
        print("3:\(isPalindrome(listNode33))")
        
    }


    
}


class MyQueue {
    
//  辅助
    var queue1 = [Int]()
//  用来操作
    var queue2 = [Int]()

    /** Initialize your data structure here. */
    init() {

    }
    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        queue1 = queue2
        queue1.append(x)
        queue2 = queue1
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        return queue2.removeFirst()
    }
    
    /** Get the front element. */
    func peek() -> Int {
        return queue2.first!
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return queue2.isEmpty
    }
}

public struct MyQueueStack<T> {
     fileprivate var array = [T]()
     public var isEmpty: Bool {
         return array.isEmpty
     }
     public var count: Int {
        return array.count
     }
     public mutating func push(_ element: T) {
        array.append(element)
     }
     public mutating func pop() -> T? {
        return array.popLast()
     }
     public var top: T? {
        return array.last
     }
}
/**
 （使用两个栈 入队 - O(n)O(n)， 出队 - O(1)O(1)）
 算法

 入队（push）

 一个队列是 FIFO 的，但一个栈是 LIFO 的。这就意味着最新压入的元素必须得放在栈底。为了实现这个目的，我们首先需要把 s1 中所有的元素移到 s2 中，接着把新元素压入 s2。最后把 s2 中所有的元素弹出，再把弹出的元素压入 s1。

 链接：https://leetcode-cn.com/problems/implement-queue-using-stacks/solution/yong-zhan-shi-xian-dui-lie-by-leetcode/
 */

class MyQueue2 {
    private var stack1: MyQueueStack<Int>
    private var stack2: MyQueueStack<Int>

    /** Initialize your data structure here. */
    init() {
        stack1 = MyQueueStack() //用于存储
        stack2 = MyQueueStack() //用于辅助，新入队的元素一定在堆底
    }

    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        //将 stack1 元素全部加入 stack2
        while !stack1.isEmpty {
            let e = stack1.pop()
            stack2.push(e!)
        }
        stack1.push(x)
        //将 stack2 元素移回 stack1
        while !stack2.isEmpty {
            let e = stack2.pop()
            stack1.push(e!)
        }
    }

    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        return stack1.pop()!
    }

    /** Get the front element. */
    func peek() -> Int {
        return stack1.top!
    }

    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return stack1.isEmpty
    }
}

