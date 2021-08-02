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
    
}
