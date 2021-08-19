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
        listItemArray.append(SWBookListItem(title: "3.买卖股票的最佳时机 ",
                                            subTitle: "",
                                            funName: "myMaxProfit"))
        listItemArray.append(SWBookListItem(title: "4.买卖股票的最佳时机II ",
                                            subTitle: "",
                                            funName: "myMaxProfit2"))
        
        
        
        
        
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
    
    // MARK: - 买卖股票的最佳时机
    @objc func myMaxProfit()  {
        /**
         定一个数组 prices ，它的第 i 个元素 prices[i] 表示一支给定股票第 i 天的价格。
         
         你只能选择 某一天 买入这只股票，并选择在 未来的某一个不同的日子 卖出该股票。设计一个算法来计算你所能获取的最大利润。
         
         返回你可以从这笔交易中获取的最大利润。如果你不能获取任何利润，返回 0 。
         
         链接：https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock
         
         
         示例 1：
         
         输入：[7,1,5,3,6,4]
         输出：5
         解释：在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
         注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格；同时，你不能在买入前卖出股票。
         示例 2：
         
         输入：prices = [7,6,4,3,1]
         输出：0
         解释：在这种情况下, 没有交易完成, 所以最大利润为 0。
         
         */
        let inputs1 = [7,1,5,3,6,4]
        let inputs2 = [3,2,6,5,0,3]
        
        print("1:\(myMaxProfit(inputs1))")
        print("2:\(myMaxProfit(inputs2))")
        
    }
    
    func myMaxProfit(_ prices: [Int]) -> Int {
        /**
         暴力计算法,性能低.可能提交通不过
         */
        var maxProfix = 0
        let maxLength = prices.count
        for i in 0 ..< maxLength {
            for j  in i + 1 ..< maxLength {
                maxProfix = max(maxProfix, prices[j] - prices[i])
            }
        }
        return maxProfix
    }
    
    func modifyMaxProfit(_ prices: [Int]) -> Int {
        /**
         我们来假设自己来购买股票。随着时间的推移，每天我们都可以选择出售股票与否。那么，假设在第 i 天，如果我们要在今天卖股票，那么我们能赚多少钱呢？
         
         显然，如果我们真的在买卖股票，我们肯定会想：如果我是在历史最低点买的股票就好了！太好了，在题目中，我们只要用一个变量记录一个历史最低价格 minprice，我们就可以假设自己的股票是在那天买的。那么我们在第 i 天卖出股票能得到的利润就是 prices[i] - minprice。
         
         因此，我们只需要遍历价格数组一遍，记录历史最低点，然后在每一天考虑这么一个问题：如果我是在历史最低点买进的，那么我今天卖出能赚多少钱？当考虑完所有天数之时，我们就得到了最好的答案。
         
         链接：https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock/solution/121-mai-mai-gu-piao-de-zui-jia-shi-ji-by-leetcode-/
         */
        var minValue = Int.max
        var maxProfit = 0
        for item in prices {
            if item < minValue {
                minValue = item
            } else if (item - minValue > maxProfit) {
                maxProfit = item - minValue
            }
        }
        return maxProfit
    }
    
    // MARK: - 买卖股票的最佳时机II
    @objc func myMaxProfit2()  {
        /**
         买卖股票的最佳时机 II
         给定一个数组 prices ，其中 prices[i] 是一支给定股票第 i 天的价格。
         
         设计一个算法来计算你所能获取的最大利润。你可以尽可能地完成更多的交易（多次买卖一支股票）。
         
         注意：你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）。
         
         链接：https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-ii
         
         示例 1:
         
         输入: prices = [7,1,5,3,6,4]
         输出: 7
         解释: 在第 2 天（股票价格 = 1）的时候买入，在第 3 天（股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5-1 = 4 。
              随后，在第 4 天（股票价格 = 3）的时候买入，在第 5 天（股票价格 = 6）的时候卖出, 这笔交易所能获得利润 = 6-3 = 3 。
         示例 2:
         
         输入: prices = [1,2,3,4,5]
         输出: 4
         解释: 在第 1 天（股票价格 = 1）的时候买入，在第 5 天 （股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5-1 = 4 。
              注意你不能在第 1 天和第 2 天接连购买股票，之后再将它们卖出。因为这样属于同时参与了多笔交易，你必须在再次购买前出售掉之前的股票。
         
         */
    }
    
    func myMaxProfit2(_ prices: [Int]) -> Int {
        // 因为交易次数不受限，如果可以把所有的上坡全部收集到，一定是利益最大化的
        var maxProfit = 0
        if prices.count < 2 {
            return maxProfit
        }
        var index = 1
        while index < prices.count {
            //  买入价比卖出去价低就可以卖出赚钱
            if prices[index - 1] < prices[index] {
                maxProfit += prices[index] - prices[index - 1]
            }
            index += 1
        }
        return maxProfit
    }
    
    
}
