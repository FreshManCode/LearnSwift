//
//  SWSqrtVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/6.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWSqrtVC: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
        
    }
    
    
    func p_initDefautData()  {
        title = "x 的平方根 以及爬楼梯"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.x 的平方根(我自己实现) ",
                                            subTitle: "",
                                            funName: "mySquart"))
        listItemArray.append(SWBookListItem(title: "2.x 的平方根(牛顿迭代) ",
                                            subTitle: "",
                                            funName: "squartNewTon"))
        listItemArray.append(SWBookListItem(title: "3.爬楼梯(自己实现) ",
                                            subTitle: "",
                                            funName: "myClimbStairs"))
        listItemArray.append(SWBookListItem(title: "4.爬楼梯(动态规划) ",
                                            subTitle: "",
                                            funName: "dynamicClimbStairs"))
        
        
        
        
        
        
        
        
        tableView.reloadData()
    }
    
    @objc func mySquart() {
        /**
         
         实现 int sqrt(int x) 函数。
         
         计算并返回 x 的平方根，其中 x 是非负整数。
         
         由于返回类型是整数，结果只保留整数的部分，小数部分将被舍去。
         
         
         方法二：二分查找
         由于 x 平方根的整数部分ans 是满足 k^2 <= x^2的最大 k值，因此我们可以对 k 进行二分查找，从而得到答案。
         
         二分查找的下界为 0，上界可以粗略地设定为 x。在二分查找的每一步中，我们只需要比较中间元素 mid 的平方与 x 的大小关系，并通过比较的结果调整上下界的范围。由于我们所有的运算都是整数运算，不会存在误差，因此在得到最终的答案 ans 后，也就不需要再去尝试ans+1 了。
         
         
         链接：https://leetcode-cn.com/problems/sqrtx/solution/x-de-ping-fang-gen-by-leetcode-solution/
         */
    }
    
    func mySqrt(_ x: Int) -> Int {
        
        var l  = 0
        var r = x
        var result = 0
        while l <= r {
            let midValue = l + (r - l) / 2
            if midValue * midValue <= x {
                result = midValue
                l = midValue + 1
            } else {
                r = midValue - 1
            }
        }
        return result
    }
    
    // MARK: - 牛顿迭代法
    @objc func squartNewTon() {
        /**牛顿迭代法是一种可以用来快速求解函数零点的方法。
         
         解释:https://leetcode-cn.com/problems/sqrtx/solution/x-de-ping-fang-gen-by-leetcode-solution/
         
         算法: (i,或者i+1 为下标)  X(i + 1) 为新的迭代结果
         X(i + 1) = 1 / 2 * (Xi + C/Xi)
         
         */
    }
    
    func newTonSqrt(_ x: Int) -> Int {
        var  r = x
        while r * r > x {
            r = 1 / 2 * (r + x / r)
        }
        return r
        
    }
    
    
    // MARK: - 爬楼梯
    @objc func myClimbStairs() {
        /**
         爬楼梯
         设你正在爬楼梯。需要 n 阶你才能到达楼顶。
         
         每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？
         
         注意：给定 n 是一个正整数。
         
         示例 1：
         
         输入： 2
         输出： 2
         解释： 有两种方法可以爬到楼顶。
         1.  1 阶 + 1 阶
         2.  2 阶
         示例 2：
         
         输入： 3
         输出： 3
         解释： 有三种方法可以爬到楼顶。
         1.  1 阶 + 1 阶 + 1 阶
         2.  1 阶 + 2 阶
         3.  2 阶 + 1 阶
         
         来源：力扣（LeetCode）
         链接：https://leetcode-cn.com/problems/climbing-stairs
         
         数学归纳法得出，有n阶台阶那么就是 n - 1 阶台阶和 n - 2 阶台阶爬上楼顶的方法的和。

         公式： f(n) = f(n - 1) + f(n - 2) , 这不就是菲波那切数列数量求和吗？

         
         */
        
        print("3:\(myClimbStairs(3))")
        print("4:\(myClimbStairs(4))")
        print("5:\(myClimbStairs(5))")
        
    }
    
    // MARK: - 使用了递归,数据量大效率低下 (如果n比较大,就会爆掉)
    func myClimbStairs(_ n : Int) -> Int {
        return caculate(n)
    }
    
    func caculate(_ n:Int) -> Int {
        if n <= 2 {
            return n
        }
        else {
            return caculate(n - 1) + caculate(n - 2)
        }
    }
    //  使用动态规划 
    @objc func dynamicClimbStairs()  {
        print("3:\(dynamicClimbStairs(3))")
        print("4:\(dynamicClimbStairs(4))")
        print("5:\(dynamicClimbStairs(5))")
        
    }
    func dynamicClimbStairs( _ n: Int) -> Int {
        if n <= 2 {
            return n
        }
        var result:[Int] = Array(repeating: 0, count: n)
        result[0] = 1
        result[1] = 2
        
        for index in 2..<n {
            result[index] = result[index - 1] + result[index - 2]
        }
        return result[n - 1]
    }
}

