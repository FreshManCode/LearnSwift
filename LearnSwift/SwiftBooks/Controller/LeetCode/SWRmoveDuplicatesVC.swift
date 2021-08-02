//
//  SWRmoveDuplicatesVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/2.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWRmoveDuplicatesVC: SWBaseViewController {
    
    var inputs  = [0,0,1,1,1,2,2,3,3,4]
    var inputs1 = [0,0,1,1,1,2,2,3,3,4]
    
    var inputs2 = [0,1,2,2,3,0,4,2]
    var inputs3 = [0,1,2,2,3,0,4,2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    
    func p_initDefautData()  {
        title = "删除有序数组中的重复项"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.删除有序数组中的重复项(自己实现) ",
                                            subTitle: "",
                                            funName: "myRemoveDuplicates"))
        listItemArray.append(SWBookListItem(title: "2.**删除有序数组中的重复项(双指针解法) ",
                                            subTitle: "",
                                            funName: "modifyRemoveDuplicates"))
        listItemArray.append(SWBookListItem(title: "3.移除元素(自己实现,效率低) ",
                                            subTitle: "",
                                            funName: "removeSpecifiedElement"))
        listItemArray.append(SWBookListItem(title: "4.移除元素(双指针) ",
                                            subTitle: "",
                                            funName: "modifyRemoveSpecifiedElement"))
        
        
        
        tableView.reloadData()
        
    }
    
    @objc func myRemoveDuplicates() {
       print("myRemoveDuplicates_result:\(removeDuplicates(&inputs))")
    }
    
    // MARK: - 双指针解法
    @objc func modifyRemoveDuplicates() {
        /**
         删除有序数组中的重复项

         解题思路：
         解法： 双指针

         首先注意数组是有序的，那么重复的元素一定会相邻。

         要求删除重复元素，实际上就是将不重复的元素移到数组的左侧。

         考虑用 2 个指针，一个在前记作 p，一个在后记作 q，算法流程如下：

         1.比较 p 和 q 位置的元素是否相等。

         如果相等，q 后移 1 位
         如果不相等，将 q 位置的元素复制到 p+1 位置上，p 后移一位，q 后移 1 位
         重复上述过程，直到 q 等于数组长度。

         返回 p + 1，即为新数组长度。

         链接：https://leetcode-cn.com/problems/remove-duplicates-from-sorted-array/solution/shuang-zhi-zhen-shan-chu-zhong-fu-xiang-dai-you-hu/
         
         
         */
        print("modifyRemoveDuplicates:\(moreEfficient(&inputs))")
    }
    
    
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        var singleMap = [Int:Int]();
        var removeCount = 0
        for (index,value) in nums.enumerated() {
            if singleMap[value] != nil {
                nums.remove(at: index - removeCount)
                removeCount += 1
            } else {
                singleMap[value] = value
            }
        }
        singleMap.removeAll()
        print("result is:\(nums)")
        return nums.count
    }
    
    func moreEfficient(_ nums:inout [Int]) -> Int {
        if nums.count < 2 {
            return nums.count
        }
        var p = 0,q = 1;
        while q < nums.count {
            if nums[p] != nums[q] {
                nums[p + 1] = nums[q]
                p += 1
            }
            q += 1
        }
//      此时数组中在index之后都是排序出来的多余元素
        print("result is:\(nums)")
//      p为数组中的索引,从0开始,
        return p + 1
    }
    
    @objc func removeSpecifiedElement() {
        print("result:\(myRemoveSpecifiedElement(2, &inputs2))")
    }
    
    @objc func modifyRemoveSpecifiedElement() {
        /**
         题目:移除元素
         双指针
         思路及算法

         由于题目要求删除数组中等于 \textit{val}val 的元素，因此输出数组的长度一定小于等于输入数组的长度，我们可以把输出的数组直接写在输入数组上。可以使用双指针：右指针 \textit{right}right 指向当前将要处理的元素，左指针 \textit{left}left 指向下一个将要赋值的位置。

         如果右指针指向的元素不等于 \textit{val}val，它一定是输出数组的一个元素，我们就将右指针指向的元素复制到左指针位置，然后将左右指针同时右移；

         如果右指针指向的元素等于 \textit{val}val，它不能在输出数组里，此时左指针不动，右指针右移一位。

         整个过程保持不变的性质是：区间 [0,\textit{left})[0,left) 中的元素都不等于 \textit{val}val。当左右指针遍历完输入数组以后，\textit{left}left 的值就是输出数组的长度。

         这样的算法在最坏情况下（输入数组中没有元素等于 \textit{val}val），左右指针各遍历了数组一次

         链接：https://leetcode-cn.com/problems/remove-element/solution/yi-chu-yuan-su-by-leetcode-solution-svxi/
         */
        print("result:\(modifyRemoveSpecifiedElement(2, &inputs3))\n inputs:\(inputs3)")
    }
 
    func myRemoveSpecifiedElement(_ element:Int,_ inputs:inout [Int]) -> Int {
        var count = 0
        for (index,value) in inputs.enumerated() {
            print("index:\(index),value:\(value)")
            if value == element {
                inputs.remove(at: index - count)
                print("inputs:\(inputs)")
                count += 1
            }
        }
        print("inputs:\(inputs)")
        return inputs.count
    }
    
    func modifyRemoveSpecifiedElement(_ element:Int,_ inputs:inout [Int]) -> Int {
        let maxLength = inputs.count
        var left = 0
        var right = 0
        while right < maxLength {
            if inputs[right] != element {
                inputs[left] = inputs[right]
                left += 1
            }
            right += 1
        }
        return left
    }
}
