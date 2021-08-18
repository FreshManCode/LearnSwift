//
//  SWTriangleVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/17.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWTriangleVC: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
        
        
    }
    
    func p_initDefautData()  {
        title = "杨辉三角"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.生成杨辉三角(自己实现) ",
                                            subTitle: "",
                                            funName: "myGenerateTriangle"))
        listItemArray.append(SWBookListItem(title: "2.杨辉三角 II ",
                                            subTitle: "",
                                            funName: "myGetRowTriangle"))
        
        
        
    
        
        tableView.reloadData()
    }
    
    // MARK: - 杨辉三角
    @objc func myGenerateTriangle()  {
        /**
         给定一个非负整数 numRows，生成「杨辉三角」的前 numRows 行。
         
         在「杨辉三角」中，每个数是它左上方和右上方的数的和。
         
         示例 1:
         输入: numRows = 5
         输出: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]
         
         示例 2:
         输入: numRows = 1
         输出: [[1]]
         */
        print(myGenerate(5))
        
    }
    
    func myGenerate(_ numRows: Int) -> [[Int]] {
        /**
         每个数字等于上一行的左右两个数字之和，可用此性质写出整个杨辉三角。即第 n行的第 i 个数等于第 n-1 行的第 i-1个数和第 i 个数之和
         
         我们可以一行一行地计算杨辉三角。每当我们计算出第 i 行的值，我们就可以在线性时间复杂度内计算出第 i+1 行的值。
         
         链接：https://leetcode-cn.com/problems/pascals-triangle/solution/yang-hui-san-jiao-by-leetcode-solution-lew9/
         
         
         */
        if numRows <= 0 {
            return []
        }
        var result = [[Int]]()
        if numRows <= 2 {
            for index in 1...numRows {
                result.append(Array.init(repeating: 1, count: index))
            }
        } else {
            result.append([1])
            result.append([1,1])
            for index in 3...numRows {
                //              取出上一个数组
                let lastArray = result[index - 2]
                var tempArray = [Int]()
                tempArray.append(1)
                for subIndex in 0 ..< lastArray.count {
                    if subIndex > 0 {
                        tempArray.append(lastArray[subIndex] + lastArray[subIndex - 1])
                    }
                }
                tempArray.append(1)
                result.append(tempArray)
            }
        }
        return result
        
    }
    
    // MARK: - 杨辉三角 II
    @objc func myGetRowTriangle()  {
        /**
         给定一个非负索引 rowIndex，返回「杨辉三角」的第 rowIndex 行。
         
         在「杨辉三角」中，每个数是它左上方和右上方的数的和。
         示例 1:
         
         输入: rowIndex = 3
         输出: [1,3,3,1]
         示例 2:
         
         输入: rowIndex = 0
         输出: [1]
         */
        print("0:\(getRow(0))")
        print("3:\(getRow(3))")
        
    }
    func getRow(_ rowIndex: Int) -> [Int] {
        /**
         使用 递推方式
         */
        if rowIndex <= 1 {
            return Array.init(repeating: 1, count: rowIndex + 1)
        } else {
            var result = [[Int]]()
            result.append([1])
            result.append([1,1])
            
            for index in 2 ... rowIndex {
                var tempArray = [Int]()
                let lastArray = result[index - 1]
                tempArray.append(1)
                for lastIndex in 0 ..< lastArray.count  {
                    if lastIndex > 0 {
                        tempArray.append(lastArray[lastIndex] + lastArray[lastIndex - 1])
                    }
                }
                tempArray.append(1)
                result.append(tempArray)
            }
            return result[rowIndex]
            
        }
        
    }
    
    
    /// 比方法一的运行效率高
    /// - Parameter rowIndex: 指定索引
    /// - Returns: 返回结果
    func highGetRow(_ rowIndex: Int) -> [Int] {
            var res = [[Int]]()
            for i in 0 ... rowIndex {
                var temp = [Int](repeating: 0, count: i + 1)
                temp[0] = 1
                temp[i] = 1
                if i > 1 {
                    for j in 1 ..< i {
                        temp[j] = res[i - 1][j - 1] + res[i - 1][j]
                    }
                }
                res.append(temp)
            }
            return res.last!
        }
    
    
    
}
