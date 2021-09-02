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
        listItemArray.append(SWBookListItem(title: "4.计数质数 ",
                                            subTitle: "",
                                            funName: "myCountPrimes"))
        listItemArray.append(SWBookListItem(title: "4.1 计数质数(埃氏筛) ",
                                            subTitle: "",
                                            funName: "countPrimes"))
        
        listItemArray.append(SWBookListItem(title: "5.同构字符串 ",
                                            subTitle: "",
                                            funName: "myIsIsomorphic"))
        
        listItemArray.append(SWBookListItem(title: "5.1 同构字符串 ",
                                            subTitle: "",
                                            funName: "isIsomorphic"))
        
        
        
        
        
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
    
    // MARK: - 计数质数
    @objc func myCountPrimes()  {
        /**
         统计所有小于非负整数 n 的质数的数量。
         
         示例 1：
         
         输入：n = 10
         输出：4
         解释：小于 10 的质数一共有 4 个, 它们是 2, 3, 5, 7 。
         示例 2：
         
         输入：n = 0
         输出：0
         示例 3：
         
         输入：n = 1
         输出：0
         */
        
        /// 校验一个数是不是质数
        /// - Parameter n: 给定的数
        /// - Returns: true/false
        func isPrime(_ n:Int) -> Bool {
            //枚举方法,只要验证[2 , x * x <= n]的区间就可以
            var start = 2
            while start * start <= n {
                if n % start == 0 {
                    return false
                }
                start += 1
            }
            return true
        }
        func countPrimes(_ n: Int) -> Int {
            var count = 0
            var index = 2
            while index < n {
                if isPrime(index) {
                    count += 1
                }
                index += 1
            }
            return count
        }
        
        print("10:\(countPrimes(10))")
        print("1:\(countPrimes(1))")
    }
    
    // MARK: - 4.1 计数质数(埃氏筛)
    @objc func countPrimes()  {
        /**
         枚举没有考虑到数与数的关联性，因此难以再继续优化时间复杂度。接下来我们介绍一个常见的算法
         我们考虑这样一个事实：如果 xx 是质数，那么大于 xx 的 xx 的倍数 2x,3x,… 一定不是质数，因此我们可以从这里入手。
         
         我们设 isPrime[i] 表示数 i 是不是质数，如果是质数则为 1，否则为 0。从小到大遍历每个数，如果这个数为质数，则将其所有的倍数都标记为合数（除了该质数本身），即 0，这样在运行结束的时候我们即能知道质数的个数。
         
         
         当然这里还可以继续优化，对于一个质数 x，如果按上文说的我们从 2x 开始标记其实是冗余的，应该直接从 x⋅x 开始标记，因为 2x,3x,,… 这些数一定在 x 之前就被其他数的倍数标记过了，例如 2 的所有倍数，3 的所有倍数等。
         
         
         
         链接：https://leetcode-cn.com/problems/count-primes/solution/ji-shu-zhi-shu-by-leetcode-solution/
         */
        func countPrimes(_ n:Int)-> Int {
            var primes = Array.init(repeating: 1, count: n)
            var answer = 0
            var i = 2
            while i < n {
                if primes[i] == 1 {
                    answer += 1
                    var j = i * i
                    while j  < n {
                        primes[j] = 0
                        j += i
                    }
                }
                i += 1
            }
            return answer
        }
        
        print("10:\(countPrimes(10))")
        print("1:\(countPrimes(1))")
        
    }
    
    // MARK: - 同构字符串
    @objc func myIsIsomorphic()  {
        /**
         给定两个字符串 s 和 t，判断它们是否是同构的。
         如果 s 中的字符可以按某种映射关系替换得到 t ，那么这两个字符串是同构的。
         每个出现的字符都应当映射到另一个字符，同时不改变字符的顺序。不同字符不能映射到同一个字符上，相同字符只能映射到同一个字符上，字符可以映射到自己本身。
         
         示例 1:
         
         输入：s = "egg", t = "add"
         输出：true
         示例 2：
         
         输入：s = "foo", t = "bar"
         输出：false
         示例 3：
         
         输入：s = "paper", t = "title"
         输出：true
         */
        func isIsomorphic(_ s: String, _ t: String) -> Bool {
            /**
             做双向映射table,去检查对应的key是否有值,无值就添加,有值就判断是否一致.
             */
            if s.count != t.count {
                return false
            }
            let sChars = Array.init(s)
            let tChars = Array.init(t)
            var index = 0
            var mapValue  = [Character:Character]()
            var mapValue2 = [Character:Character]()
            while index < sChars.count {
                let keyChar = sChars[index]
                let valueChar = tChars[index]
                if mapValue[keyChar] == nil {
                    mapValue[keyChar] = tChars[index]
                } else {
                    if mapValue[keyChar] != tChars[index] {
                        return false
                    }
                }
                if mapValue2[valueChar] != nil {
                    if mapValue2[valueChar] != sChars[index] {
                        return false
                    }
                } else {
                    mapValue2[valueChar] = keyChar
                }
                index += 1
                
            }
            return true
        }
        
        print("1:\(isIsomorphic("egg", "add"))")
        print("2:\(isIsomorphic("foo", "bar"))")
        print("3:\(isIsomorphic("paper", "title"))")
        print("3:\(isIsomorphic("badc", "baba"))")
        
    }
    
    // MARK: - 同构字符串
    @objc func isIsomorphic()  {
        /**
         解法一中，我们判断 s 和 t 是否一一对应，通过对两个方向分别考虑来解决的。
         
         这里的话，我们找一个第三方来解决，即，按照字母出现的顺序，把两个字符串都映射到另一个集合中。
         
         举个现实生活中的例子，一个人说中文，一个人说法语，怎么判断他们说的是一个意思呢？把中文翻译成英语，把法语也翻译成英语，然后看最后的英语是否相同即可。
         
         链接：https://leetcode-cn.com/problems/isomorphic-strings/solution/xiang-xi-tong-su-de-si-lu-fen-xi-duo-jie-fa-by-42/
         
         将第一个出现的字母映射成 1，第二个出现的字母映射成 2
         
         对于 egg
         e -> 1
         g -> 2
         也就是将 egg 的 e 换成 1, g 换成 2, 就变成了 122
         
         对于 add
         a -> 1
         d -> 2
         也就是将 add 的 a 换成 1, d 换成 2, 就变成了 122
         
         egg -> 122, add -> 122
         都变成了 122，所以两个字符串异构。
         
         
         */
        
        func isIsomorphicHelper(s:String)->String {
            var map = [Character:Int]()
            var result = [Int]()
            var count = 1
            for item in s {
                if map[item] == nil {
                    map[item] = count
                    count += 1
                }
                result.append(map[item]!)
            }
            let dataStr = result.map(String.init)
            let resultStr = dataStr.joined(separator: "")
            print("resultStr:\(resultStr)")
            return resultStr
            
        }
        
        func isIsomorphic(_ s: String, _ t: String) -> Bool {
            return isIsomorphicHelper(s: s) == isIsomorphicHelper(s: t)
        }
        
        print("1:\(isIsomorphic("egg", "add"))")
        print("2:\(isIsomorphic("foo", "bar"))")
        print("3:\(isIsomorphic("paper", "title"))")
        print("3:\(isIsomorphic("badc", "baba"))")
        print("3:\(isIsomorphic("abcdefggfedcba", "hijklmnnmlkih"))")
        
    }
    
    
    
    
    
    
}
