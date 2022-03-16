//
//  SWStrStrVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/3.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWStrStrVC: SWBaseViewController {
    
    let inputs = ["mississippi","issip"]
    let inputs2 = ["mississippi","issipi"]
    let inputs3 = ["hello","ll"]
    
    
    let search = [[1,2,3,4,5,6,7],1] as [Any]
    let search1 = [[1,2,3,4,5,6,7],3] as [Any]
    let search2 = [[1,2,3,4,5,6,7],4] as [Any]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        p_initDefautData();
    }
    
    
    func p_initDefautData()  {
        title = " 实现 strStr()"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1. 实现 strStr(自己实现) ",
                                            subTitle: "",
                                            funName: "myStrStr"))
        listItemArray.append(SWBookListItem(title: "2. 实现 strStr(KMP算法) ",
                                            subTitle: "",
                                            funName: "KMPStrStr"))
        listItemArray.append(SWBookListItem(title: "3. 搜索插入位置(自己实现) ",
                                            subTitle: "",
                                            funName: "mySearchInsert"))
        listItemArray.append(SWBookListItem(title: "4. 搜索插入位置(二分法) ",
                                            subTitle: "",
                                            funName: "modifySearchInsert"))
        
        
        
        
        
        tableView.reloadData()
        
    }
    
    @objc func myStrStr() {
        /**
         
         实现 strStr() 函数。
         
         给你两个字符串 haystack 和 needle ，请你在 haystack 字符串中找出 needle 字符串出现的第一个位置（下标从 0 开始）。如果不存在，则返回  -1 。
         
          
         
         说明：
         
         当 needle 是空字符串时，我们应当返回什么值呢？这是一个在面试中很好的问题。
         
         对于本题而言，当 needle 是空字符串时我们应当返回 0 。这与 C 语言的 strstr() 以及 Java 的 indexOf() 定义相符。
         链接：https://leetcode-cn.com/problems/implement-strstr
         
         */
        print("result:\(strStr(inputs[0], inputs[1]))")
        print("result2:\(strStr(inputs2[0], inputs2[1]))")
        print("result3:\(strStr(inputs3[0], inputs3[1]))")
    }
    
    //  leetcode运行超时
    func strStr(_ haystack: String, _ needle: String) -> Int {
        /**
         方法一：暴力匹配
         思路及算法
         
         我们可以让字符串 \textit{needle}needle 与字符串 \textit{haystack}haystack 的所有长度为 mm 的子串均匹配一次。
         
         为了减少不必要的匹配，我们每次匹配失败即立刻停止当前子串的匹配，对下一个子串继续匹配。如果当前子串匹配成功，我们返回当前子串的开始位置即可。如果所有子串都匹配失败，则返回 -1−1
         */
        let haystackLength = haystack.count
        let needleLength = needle.count
        let outChars = haystack.characters
        let needleChars = needle.characters
        
        if haystackLength < needleLength {
            return -1
        }
        else if (needleLength < 1) {
            return 0
        }
        
        for i in 0 ... haystackLength - needleLength  {
            var stop = false
            //两个字符串中的每个元素进行逐行遍历对比
            for j in 0 ..< needleLength {
                if outChars[i + j] != needleChars[j] {
                    stop = true
                    break
                }
            }
            if !stop {
                return i
            }
        }
        return -1;
    }
    
    //  在leetcode上运行通过
    func strStr2(_ haystack: String, _ needle: String) -> Int {
        let haystackLength = haystack.count
        let needleLength = needle.count
        if haystackLength < needleLength {
            return -1
        }
        else if (needleLength < 1) {
            return 0
        }
        
        var tempString = haystack
        for i in 0 ... haystackLength-needleLength {
            if tempString.hasPrefix(needle) {
                return i
            }
            tempString.remove(at: tempString.startIndex)
        }
        return -1;
    }
    
    //   https://leetcode-cn.com/problems/implement-strstr/solution/kmp-suan-fa-swift-shi-xian-by-yunhao/
    
    /// KMP 算法题解
    @objc func KMPStrStr() {
        print("result:\(kmp(s: Array(inputs[0]), p: Array(inputs[1])))")
        print("result:\(kmp(s: Array(inputs2[0]), p: Array(inputs2[1])))")
        print("result:\(kmp(s: Array(inputs3[0]), p: Array(inputs3[1])))")
         
    }
    func kmp(s: [Character], p: [Character]) -> Int {
        let m = s.count, n = p.count
        if p.count == 0 { return 0 }
        
        var i = 0, j = 0
        let next = getNext(p)
        
        while i < m && j < n {
            if j == -1 || s[i] == p[j] {
                i += 1
                j += 1
            } else {
                j = next[j]
            }
        }
        return (j == n) ? i - j : -1
    }
    
    /// 求解 next 数组
    func getNext(_ p: [Character]) -> [Int] {
        let n = p.count
        var k = -1, j = 0
        var next = Array<Int>(repeating: 0, count: n)
        next[0] = -1
        
        while j < n - 1 {
            if k == -1 || p[k] == p[j] {
                j += 1
                k += 1
                next[j] = (p[j] == p[k] ? next[k] : k)
            } else {
                k = next[k]
            }
        }
        
        return next
    }
    
    
    // MARK: - 搜索插入位置
    @objc func mySearchInsert() {
        /**
         
         搜索插入位置
         给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。

         请必须使用时间复杂度为 O(log n) 的算法。

         链接：https://leetcode-cn.com/problems/search-insert-position
         */
        print("search:\(searchInsert(search[0] as! [Int], search[1] as! Int))")
        print("search1:\(searchInsert(search1[0] as! [Int], search1[1] as! Int))")
        print("search2:\(searchInsert(search2[0] as! [Int], search2[1] as! Int))")
        
    }
    
    // MARK: - 二分查找
    @objc func modifySearchInsert() {
        /**
         二分查找
         思路与算法

         假设题意是叫你在排序数组中寻找是否存在一个目标值，那么训练有素的读者肯定立马就能想到利用二分法在 O(\log n)O(logn) 的时间内找到是否存在目标值。但这题还多了个额外的条件，即如果不存在数组中的时候需要返回按顺序插入的位置，那我们还能用二分法么？答案是可以的，我们只需要稍作修改即可。
         
         直接套用二分法即可，即不断用二分法逼近查找第一个大于等于 target 的下标 。下文给出的代码是笔者习惯的二分写法，\textit{ans}ans 初值设置为数组长度可以省略边界条件的判断，因为存在一种情况是 target 大于数组中的所有数，此时需要插入到数组长度的位置。


         链接：https://leetcode-cn.com/problems/search-insert-position/solution/sou-suo-cha-ru-wei-zhi-by-leetcode-solution/
         */
        
        print("search:\(halfSearchInsert(search[0] as! [Int], search[1] as! Int))")
        print("search1:\(halfSearchInsert(search1[0] as! [Int], search1[1] as! Int))")
        print("search2:\(halfSearchInsert(search2[0] as! [Int], search2[1] as! Int))")
        
    }
    
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var resultArray = nums
        if resultArray.count < 1 {
            resultArray.append(target)
            return 0
        }
        var index = 0
        while index < nums.count {
            let currentNumber = nums[index]
            if currentNumber > target {
                if index == 0 {
                    resultArray.insert(target, at: 0)
                    return 0
                } else {
                    let lastNumber = nums[index - 1]
                    if lastNumber == target {
                        return index - 1
                    } else {
                        resultArray.insert(target, at: index )
                        return index
                    }
                }
            }  else if (currentNumber == target) {
                return index
            }
            index += 1
        }
        resultArray.append(target)
        return nums.count
    }
    
    
    // MARK: - 二分法查找
    func halfSearchInsert(_ nums: [Int], _ target: Int) -> Int {
        var begin = 0
        var end = nums.count - 1
        var answer = nums.count
        while begin <= end {
            let mid = (begin + end) / 2
            if target <= nums[mid] {
                answer = mid
                end = mid - 1
            } else {
                begin = mid + 1
            }
        }
        return answer
    }
    
  
    
}

