//
//  SwiftSumLeetCodeVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/3/1.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SwiftSumLeetCodeVC: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
        
    }
    /*
     题目描述:两数之和
     给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 的那 两个 整数，并返回它们的数组下标。
     
     你可以假设每种输入只会对应一个答案。但是，数组中同一个元素不能使用两遍。
     
     来源：力扣（LeetCode）
     链接：https://leetcode-cn.com/problems/two-sum
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    func p_initDefautData()  {
        title = "LeetCode两数之和"
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
        let result = twoSum([1,3,4,5,6,9], 11)
        let result2 = twoSum([3,2,4], 6)
        printLog("result is:",result,"result2 is:",result2)
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
        let result = twoSumHash([1,3,4,5,6,9], 11)
        let result2 = twoSumHash([3,2,4], 6)
        printLog("result is:",result,"result2 is:",result2)
    }
        
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        for (index,element) in nums.enumerated() {
            let remain = target - element
            if let remainIndex =  nums.firstIndex(of:remain) {
                if  remainIndex != index {
                    return [index,remainIndex]
                }
            }
        }
        return []
    }
    
    /// 更快速的查找两数之和的方法
    /// - Parameters:
    ///   - nums: 元素集合
    ///   - target: 指定目标
    /// - Returns: 在数组中的排序
    func twoSumHash(_ nums: [Int], _ target: Int) -> [Int] {
        var map = [Int:Int]()
        for (index,element) in nums.enumerated() {
            if map.keys.contains(element) {
                return [map[element]!,index]
            }
            map[target - element] = index
        }
        return[]
    }
    

}
