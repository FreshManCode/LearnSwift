//
//  SWIsPowerOfFourVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/9/27.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWIsPowerOfFourVC: SWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    func p_initDefautData()  {
        title = " 丢失的数字"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.  4的幂 ",
                                            subTitle: "",
                                            funName: "myIsPowerOfFour"))
        listItemArray.append(SWBookListItem(title: "2.  反转字符串 ",
                                            subTitle: "",
                                            funName: "myReverseString"))
        listItemArray.append(SWBookListItem(title: "3.  反转字符串中的元音字母 ",
                                            subTitle: "",
                                            funName: "myReverseVowels"))
        listItemArray.append(SWBookListItem(title: "4.  两个数组的交集 ",
                                            subTitle: "",
                                            funName: "myIntersection"))
        listItemArray.append(SWBookListItem(title: "4.1  两个数组的交集2 (哈希表) ",
                                            subTitle: "",
                                            funName: "intersection"))
        listItemArray.append(SWBookListItem(title: "5  有效的完全平方数 ",
                                            subTitle: "",
                                            funName: "mySsPerfectSquare"))
        listItemArray.append(SWBookListItem(title: "6.  猜数字大小 ",
                                            subTitle: "",
                                            funName: "guessNumber"))
        

        tableView.reloadData()
    }
    
    // MARK: - 1.  4的幂
    @objc func myIsPowerOfFour()  {
        /**
         给定一个整数，写一个函数来判断它是否是 4 的幂次方。如果是，返回 true ；否则，返回 false 。

         整数 n 是 4 的幂次方需满足：存在整数 x 使得 n == 4x
         */
        func isPowerOfFour(_ n: Int) -> Bool {
            var number = n
            while number % 4 == 0 && number > 1 {
                number = number / 4
                print("number:\(number)")
            }
            return number == 1
        }
        print("16:\(isPowerOfFour(16) ? "true" : "false")")
    }
    
    // MARK: - 反转字符串
    @objc func myReverseString()  {
        /**
         编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 s 的形式给出。

         不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。
         
         双指针:left与right,互相交换,然后两个指针逐渐往中间移动
         */
        func reverseString(_ s: inout [Character]) {
            var left = 0,right = s.count - 1
            while left < right {
                let temp = s[left]
                s[left] = s[right]
                s[right] = temp
                left += 1
                right -= 1
            }
            
        }
        
    }

    // MARK: - 反转字符串中的元音字母
    @objc func myReverseVowels()  {
        /**
         给你一个字符串 s ，仅反转字符串中的所有元音字母，并返回结果字符串。

         元音字母包括 'a'、'e'、'i'、'o'、'u'，且可能以大小写两种形式出现。
         
         我们可以使用两个指针 i 和 j 对字符串相向地进行遍历。

         具体地，指针 i初始时指向字符串 s 的首位，指针 j 初始时指向字符串 s 的末位。在遍历的过程中，我们不停地将 i 向右移动，直到 i 指向一个元音字母（或者超出字符串的边界范围）；同时，我们不停地将 j 向左移动，直到 j 指向一个元音字母。此时，如果 i<j，那么我们交换 i 和 j 指向的元音字母，否则说明所有的元音字母均已遍历过，就可以退出遍历的过程

         链接：https://leetcode-cn.com/problems/reverse-vowels-of-a-string/solution/fan-zhuan-zi-fu-chuan-zhong-de-yuan-yin-2bmos/
         */
        let vowelMaps:[Character:Character] = ["a":"a","e":"e","i":"i","o":"o","u":"u","A":"A","E":"E","I":"I","O":"O","U":"U"]
        func isVowel (_ char:Character)->Bool {
            return vowelMaps[char] != nil
        }
        func reverseVowels(_ s: String) -> String {
            var chars = Array.init(s)
            var left = 0
            var right = chars.count - 1
            while left < right {
                
                while left < chars.count && !isVowel(chars[left]) {
                    left += 1
                }
                
                while right > 0 && !isVowel(chars[right]) {
                    right -= 1
                }
                
                if left < right {
                    let temp = chars[left]
                    chars[left] = chars[right]
                    chars[right] = temp
                    left += 1
                    right -= 1
                }
            }
            return String.init(chars)
        }
        
        print("hello->\(reverseVowels("hello"))")
        print("leetcode->\(reverseVowels("leetcode"))")
    }
    
    // MARK: - 两个数组的交集
    @objc func myIntersection()  {
        /** 两个数组的交集
         给定两个数组，编写一个函数来计算它们的交集。
         1.先使用个数比较小的数组,假定该数组就是需要的交集
         2.在对假定的数组的每个元素进行判断是否在另一个数组中,
         */
        func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
            var tempSet = Set<Int>()
            if nums1.count < nums2.count {
                tempSet = Set.init(nums1)
            } else {
                tempSet = Set.init(nums2)
            }
            
            var resultArray = [Int]()
            for item in tempSet {
                if nums1.count < nums2.count {
                    if nums2.contains(item) {
                        resultArray.append(item)
                    }
                }
                else {
                    if nums1.contains(item) {
                        resultArray.append(item)
                    }
                }
            }
            return resultArray
         }
        
        let nums1 = [1,2,2,1], nums2 = [2,2];
        let nums1_1 = [4,9,5], nums2_2 = [9,4,9,8,4];
        
        print("1:\(intersection(nums1, nums2))")
        print("2:\(intersection(nums1_1, nums2_2))")
        
        
        
        /*
         方法二：排序 + 双指针
        如果两个数组是有序的，则可以使用双指针的方法得到两个数组的交集。

        首先对两个数组进行排序，然后使用两个指针遍历两个数组。可以预见的是加入答案的数组的元素一定是递增的，为了保证加入元素的唯一性，我们需要额外记录变量 pre 表示上一次加入答案数组的元素。

        初始时，两个指针分别指向两个数组的头部。每次比较两个指针指向的两个数组中的数字，如果两个数字不相等，则将指向较小数字的指针右移一位，如果两个数字相等，且该数字不等于pre ，将该数字添加到答案并更新pre 变量，同时将两个指针都右移一位。当至少有一个指针超出数组范围时，遍历结束。
         
         
         说明：

         输出结果中每个元素出现的次数，应与元素在两个数组中出现次数的最小值一致。
         我们可以不考虑输出结果的顺序。

        链接：https://leetcode-cn.com/problems/intersection-of-two-arrays/solution/liang-ge-shu-zu-de-jiao-ji-by-leetcode-solution/
         */
        
        
        func doublePointerIntersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
//          如果两个数组已经是有序的,则不用排序效率更高
            let array1 = nums1.sorted()
            let array2 = nums2.sorted()
            
            var index = 0, index1 = 0,index2 = 0
            var result = [Int]()
    
            while index1 < array1.count && index2 < array2.count {
                let number1 = array1[index1]
                let number2 = array2[index2]
                if number1 == number2 {
                    if index == 0 || result[index - 1] != number1 {
                        result.append(number1)
                        index += 1
                    }
                    index1 += 1
                    index2 += 1
                    
                } else if number1 < number2 {
                    index1 += 1
                } else {
                    index2 += 1
                }
                
            }
            return result
         }
       
        
        print("1:\(doublePointerIntersection(nums1, nums2))")
        print("2:\(doublePointerIntersection(nums1_1, nums2_2))")
    }
    
    // MARK: - 方法一：哈希表

    @objc func intersection()  {
        /**
         由于同一个数字在两个数组中都可能出现多次，因此需要用哈希表存储每个数字出现的次数。对于一个数字，其在交集中出现的次数等于该数字在两个数组中出现次数的最小值。

         首先遍历第一个数组，并在哈希表中记录第一个数组中的每个数字以及对应出现的次数，然后遍历第二个数组，对于第二个数组中的每个数字，如果在哈希表中存在这个数字，则将该数字添加到答案，并减少哈希表中该数字出现的次数。

         为了降低空间复杂度，首先遍历较短的数组并在哈希表中记录每个数字以及对应出现的次数，然后遍历较长的数组得到交集。

         链接：https://leetcode-cn.com/problems/intersection-of-two-arrays-ii/solution/liang-ge-shu-zu-de-jiao-ji-ii-by-leetcode-solution/
         */
        func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
            if nums1.count > nums2.count  {
                return intersection(nums2, nums1)
            }
            var resultMap = [Int:Int]()
            var result = [Int]()
            
            
            for item in nums1 {
                if let count = resultMap[item] {
                    resultMap[item] = count + 1
                } else {
                    resultMap[item] = 1
                }
            }
            
            for item in nums2 {
                if let count = resultMap[item] {
                    if count > 0 {
                        resultMap[item] = count - 1
                        result.append(item)
                    } else {
                        resultMap.removeValue(forKey: item)
                    }
                }
            }
            return result
        }
        
        let nums1 = [1,2,2,1], nums2 = [2,2];
        let nums1_1 = [4,9,5], nums2_2 = [9,4,9,8,4];
        
        print("1:\(intersection(nums1, nums2))")
        print("2:\(intersection(nums1_1, nums2_2))")
    }

    // MARK: - 有效的完全平方数
    @objc func mySsPerfectSquare()  {
        /**
         有效的完全平方数
         给定一个 正整数 num ，编写一个函数，如果 num 是一个完全平方数，则返回 true ，否则返回 false 。

         进阶：不要 使用任何内置的库函数，如  sqrt 。
         */
        func isPerfectSquare(_ num: Int) -> Bool {
            /**
             平方根相关问题通常可以在对数时间内求解。这里列出了从最坏到最好的三种标准对数时间的方法：

             递归
             二分查找
             牛顿迭代法
             后面两个算法是最有趣的，让我们详细的讨论它。

             这些解决方法都有相同的起点。num 是一个有效的完全平方数若 x∗x==num。

             链接：https://leetcode-cn.com/problems/valid-perfect-square/solution/you-xiao-de-wan-quan-ping-fang-shu-by-leetcode/
             
             
             方法一：二分查找
             若 num < 2，返回 true。
             设置左边界为 2，右边界为 num/2。
             当 left <= right：
             令 x = (left + right) / 2 作为一个猜测，计算 guess_squared = x * x 与 num 做比较：
             如果 guess_squared == num，则 num 是一个完全平方数，返回 true。
             如果 guess_squared > num ，设置右边界 right = x-1。
             否则设置左边界为 left = x+1。
             如果在循环体内没有找到，则说明 num 不是完全平方数，返回 false。

             链接：https://leetcode-cn.com/problems/valid-perfect-square/solution/you-xiao-de-wan-quan-ping-fang-shu-by-leetcode/
             */
            var left = 0
            var right = num
            while left < right {
                let mid = left + (right - left) / 2
                if mid * mid > num {
                    right = mid - 1
                } else if mid * mid < num {
                    left = mid + 1
                }
                else {
                    return true
                }
            }
            return num < 2
        }
        
        
        func newTonIsPerfectSquare(_ num:Int)->Bool {
            /**
             方法二：牛顿迭代法
             牛顿迭代法：公式是如何推导的呢？让我们做一个非常粗略的推导。

             问题是找出：f(x) = x^2 -num = 0 的根。

             牛顿迭代法的思想是从一个初始近似值开始，然后作一系列改进的逼近根的过程。

             作者：LeetCode
             链接：https://leetcode-cn.com/problems/valid-perfect-square/solution/you-xiao-de-wan-quan-ping-fang-shu-by-leetcode/
             来源：力扣（LeetCode）
             著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
             */
            if num < 2 {
                return true
            }
            var x = num / 2
            while x * x > num {
                x =  (x + num / x ) / 2
            }
            return x * x == num
        }
        
        print("25:\(isPerfectSquare(25))")
        print("4:\(isPerfectSquare(4))")
        print("81:\(isPerfectSquare(81))")
        
        print("25_1:\(newTonIsPerfectSquare(25))")
        print("4_1:\(newTonIsPerfectSquare(4))")
        print("81_1:\(newTonIsPerfectSquare(81))")
    }
    
    
    // MARK: - 猜数字大小
    @objc func guessNumber()  {
        /**
         猜数字游戏的规则如下：

         每轮游戏，我都会从 1 到 n 随机选择一个数字。 请你猜选出的是哪个数字。
         如果你猜错了，我会告诉你，你猜测的数字比我选出的数字是大了还是小了。
         你可以通过调用一个预先定义好的接口 int guess(int num) 来获取猜测结果，返回值一共有 3 种可能的情况（-1，1 或 0）：

         -1：我选出的数字比你猜的数字小 pick < num
         1：我选出的数字比你猜的数字大 pick > num
         0：我选出的数字和你猜的数字一样。恭喜！你猜对了！pick == num
         
         使用二分查找法 [left + 1 , mid] [mid,right]
         
         
         */
        func guess (_ num:Int) ->Int {
            if num > 10 {
                return 1
            }
            else if num < 10 {
                return -1
            }
            return 0
        }
        func guessNumber(_ n: Int) -> Int {
            
            var left = 0
            var right = n
            while left < right {
                let midValue = left + (right - left) / 2
                if guess(midValue) <= 0{
                    right = midValue
                }
                else if guess(midValue) == -1 {
                    left = midValue + 1
                }
            }
            return left
        }
        
    }

    
    



}
