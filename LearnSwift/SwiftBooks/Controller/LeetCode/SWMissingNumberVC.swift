//
//  SWMissingNumberVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/9/22.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWMissingNumberVC: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    func p_initDefautData()  {
        title = " 丢失的数字"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.  丢失的数字 ",
                                            subTitle: "",
                                            funName: "myMissingNumber"))
        listItemArray.append(SWBookListItem(title: "1.1  丢失的数字(高斯公式求和)",
                                            subTitle: "",
                                            funName: "missingNumber"))
        
        listItemArray.append(SWBookListItem(title: "2  第一个错误的版本",
                                            subTitle: "",
                                            funName: "myFirstBadVersion"))
        
        
        
        
        
        
        
        
        
        tableView.reloadData()
    }
    
    
    // MARK: - 1.丢失的数字
    @objc func myMissingNumber()  {
        /**
         给定一个包含 [0, n] 中 n 个数的数组 nums ，找出 [0, n] 这个范围内没有出现在数组中的那个数。
         
         */
        func missingNumber(_ nums: [Int]) -> Int {
            var setIndex = Set <Int>()
            for index in 0...nums.count {
                setIndex.insert(index)
            }
            for item in nums {
                if setIndex.contains(item) {
                    setIndex.remove(item)
                }
            }
            return setIndex.first ?? -1
        }
        
        //      使用hash表进行映射
        func missingNumber2(_ nums: [Int]) -> Int {
            var index = 0
            let set = Set.init(nums)
            while index < set.count {
                if set.contains(index) {
                    index += 1
                } else {
                    break
                }
            }
            return index
        }
        
        let nums1 = [0,1],nums2 = [9,6,4,2,3,5,7,0,1];
        print("nums1:\(missingNumber(nums1))")
        print("nums2:\(missingNumber(nums2))")
        
        func missingNumber3 (_ nums:[Int]) ->Int {
            /**
             我们可以用 高斯求和公式 求出 [0..n][0..n] 的和，减去数组中所有数的和，就得到了缺失的数字。
             */
            let totalSum = nums.count * (nums.count + 1) / 2
            var currentSum = 0
            for item in nums {
                currentSum += item
            }
            return totalSum - currentSum
        }
    }
    
    // MARK: - 2  第一个错误的版本
    @objc func myFirstBadVersion()  {
        /**
         你是产品经理，目前正在带领一个团队开发新的产品。不幸的是，你的产品的最新版本没有通过质量检测。由于每个版本都是基于之前的版本开发的，所以错误的版本之后的所有版本都是错的。
         
         假设你有 n 个版本 [1, 2, ..., n]，你想找出导致之后所有版本出错的第一个错误的版本。
         
         你可以通过调用 bool isBadVersion(version) 接口来判断版本号 version 是否在单元测试中出错。实现一个函数来查找第一个错误的版本。你应该尽量减少对调用 API 的次数。
         */
        func isBadVersion(_ version:Int)->Bool {
            return version > 3
        }
        func firstBadVersion(_ n: Int) -> Int {
            var left = 1
            var right = n
            // 循环直至区间左右端点相同
            while left < right {
                let mid = left + (right - left )/2
                //              错误版本还要继续向下
                if isBadVersion(mid) {
                    //                   答案在区间 [left mid]
                    right = mid
                }
                //              错误版本在上面
                else {
                    //                   答案在区间 [mid+1, right] 中
                    left = mid + 1
                }
            }
            //           此时有 left == right，区间缩为一个点，即为答案
            return left
        }
    }
    
    
    
}
