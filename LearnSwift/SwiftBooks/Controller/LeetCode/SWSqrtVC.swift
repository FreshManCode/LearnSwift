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
        title = "x 的平方根"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.mySquart ",
                                            subTitle: "",
                                            funName: "mySquart"))
        
        
        
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
    
}
