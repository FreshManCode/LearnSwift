//
//  SWLeetCodeListVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/3/1.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWLeetCodeListVC: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    func p_initDefautData()  {
        title = "LeetCode刷题"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1. 两数之和", subTitle: "", funName: "SwiftSumLeetCode"))
        listItemArray.append(SWBookListItem(title: "2. 两数相加", subTitle: "", funName: "SwiftAddLeetCode"))
        listItemArray.append(SWBookListItem(title: "3. 二叉树中第二小的节点",
                                            subTitle: "",
                                            funName: "SecondSmallNodeOfTree"))
        listItemArray.append(SWBookListItem(title: "4.整数反转",
                                            subTitle: "",
                                            funName: "SwiftReverInteger"))
        listItemArray.append(SWBookListItem(title: "5.回文数",
                                            subTitle: "",
                                            funName: "SwiftPanlindrome"))
        listItemArray.append(SWBookListItem(title: "6.罗马数字转整数以及最长公共前缀",
                                            subTitle: "",
                                            funName: "RomanToInt"))
        listItemArray.append(SWBookListItem(title: "7.有效的括号以及合并两个有序链表",
                                            subTitle: "",
                                            funName: "SWBracketValidVC"))
        listItemArray.append(SWBookListItem(title: "8.删除有序数组中的重复项AND移除元素",
                                            subTitle: "",
                                            funName: "SWRmoveDuplicatesVC"))
        
        listItemArray.append(SWBookListItem(title: "9.实现 strStr() 以及搜索插入位置",
                                            subTitle: "",
                                            funName: "SWStrStrVC"))
        listItemArray.append(SWBookListItem(title: "10.最大子序和以及最后一个单词的长度",
                                            subTitle: "",
                                            funName: "SWMaxSubArray"))
        listItemArray.append(SWBookListItem(title: "11.+1以及二进制求和",
                                            subTitle: "",
                                            funName: "SWPlusOne"))
        listItemArray.append(SWBookListItem(title: "12.X的平方根以及二进制求和",
                                            subTitle: "",
                                            funName: "SWSqrtVC"))
        listItemArray.append(SWBookListItem(title: "13.删除排序链表中的重复元素以及合并两个有序数组以及二叉树的中序遍历",
                                            subTitle: "",
                                            funName: "SWDeleteDuplicateElement"))
        listItemArray.append(SWBookListItem(title: "14.相同的树,对称二叉树,二叉树的最大深度",
                                            subTitle: "",
                                            funName: "SWSameTree"))
        listItemArray.append(SWBookListItem(title: "15.平衡二叉树,二叉树的最小深度,路径总和",
                                            subTitle: "",
                                            funName: "SWBalancedTree"))
        listItemArray.append(SWBookListItem(title: "16.杨辉三角,买卖股票最佳时机",
                                            subTitle: "",
                                            funName: "SWTriangle"))
        listItemArray.append(SWBookListItem(title: "17.验证回文串",
                                            subTitle: "",
                                            funName: "SWPalindrome"))
        listItemArray.append(SWBookListItem(title: "18.二叉树前序/后续遍历/最小栈/相交链表",
                                            subTitle: "",
                                            funName: "SWBinayTreeOrder"))
        listItemArray.append(SWBookListItem(title: "19.两数之和/Excel表列名称/多数元素",
                                            subTitle: "",
                                            funName: "SWTwoSum"))
        listItemArray.append(SWBookListItem(title: "20.阶乘后的零/快乐数/移除链表元素/计数质数/同构字符串",
                                            subTitle: "",
                                            funName: "SWTrailingZeroes"))
        listItemArray.append(SWBookListItem(title: "21.反转链表/存在重复元素/存在重复元素 II/用队列实现栈",
                                            subTitle: "",
                                            funName: "SWReverseList"))
        listItemArray.append(SWBookListItem(title: "22.汇总区间/2 的幂/用栈实现队列/回文链表",
                                            subTitle: "",
                                            funName: "SWSummaryRanges"))
        listItemArray.append(SWBookListItem(title: "23.二叉搜索树的最近公共祖先/删除链表中的节点/有效的字母异位词/二叉树的所有路径/各位相加/丑数",
                                            subTitle: "",
                                            funName: "SWLowestCommonAncestor"))
        listItemArray.append(SWBookListItem(title: "24. 丢失的数字/第一个错误的版本/移动零/单词规律/Nim 游戏/区域和检索 - 数组不可变/3的幂/比特位计数",
                                            subTitle: "",
                                            funName: "SWMissingNumber"))
        listItemArray.append(SWBookListItem(title: "25. 4的幂",
                                            subTitle: "",
                                            funName: "SWIsPowerOfFour"))
        
        
        
        
        
        
        
        
        
        
        
        tableView.reloadData()
    }
    
    
    // MARK: - 两数之和
    @objc  func SwiftSumLeetCode()  {
        psuhToTargetVC(className: "SwiftSumLeetCodeVC")
    }
    
    // MARK: - 两数相加
    @objc  func SwiftAddLeetCode()  {
        psuhToTargetVC(className: "SwiftAddLeetCodeVC")
    }
    
    // MARK: 二叉树中第二小的节点
    @objc  func SecondSmallNodeOfTree()  {
        psuhToTargetVC(className: "SWSecondSmallNodeOfTreeVC")
    }
    // MARK: 二叉树中第二小的节点
    @objc  func SwiftReverInteger()  {
        psuhToTargetVC(className: "SWSWReverseIntegerVC")
    }
    
    // MARK:回文数
    @objc  func SwiftPanlindrome()  {
        psuhToTargetVC(className: "SWPalindromeVC")
    }
    
    // MARK: - 罗马数字转整数
    @objc func RomanToInt() {
        psuhToTargetVC(className: "SWRomanToIntVC")
    }
    
    // MARK: - 有效的括号
    @objc func SWBracketValidVC() {
        psuhToTargetVC(className: "SWBracketValidVC")
    }
    
    // MARK: - 删除有序数组中的重复项
    @objc func SWRmoveDuplicatesVC() {
        psuhToTargetVC(className: "SWRmoveDuplicatesVC")
    }
    
    // MARK: - 实现 strStr
    @objc func SWStrStrVC() {
        psuhToTargetVC(className: "SWStrStrVC")
    }
    
    // MARK: - 最大子序和
    @objc func SWMaxSubArray() {
        psuhToTargetVC(className: "SWMaxSubArrayVC")
    }
    
    // MARK: - 加一
    @objc func SWPlusOne() {
        psuhToTargetVC(className: "SWPlusOneVC")
    }
    
    // MARK: - X的平方根
    @objc func SWSqrtVC() {
        psuhToTargetVC(className: "SWSqrtVC")
    }
    
    // MARK: - 删除排序链表中的重复元素
    @objc func SWDeleteDuplicateElement() {
        psuhToTargetVC(className: "SWDeleteDuplicateVC")
    }
    
    // MARK: - 相同的树
    @objc func SWSameTree()  {
        psuhToTargetVC(className: "SWSameTreeVC")
    }
    
    // MARK: - 平衡二叉树
    @objc func SWBalancedTree()  {
        psuhToTargetVC(className: "SWBalancedTreeVC")
    }
    
    // MARK: - 杨辉三角
    @objc func SWTriangle()  {
        psuhToTargetVC(className: "SWTriangleVC")
    }

    // MARK: - 17.验证回文串
    @objc func SWPalindrome()  {
        psuhToTargetVC(className: "SWPalindromeStringVC")
    }

    // MARK: - 18.二叉树前序/后续遍历
    @objc func SWBinayTreeOrder()  {
        psuhToTargetVC(className: "SWBinayTreeOrderVC")
    }
    
    // MARK: - 19.两数之和/
    @objc func SWTwoSum()  {
        psuhToTargetVC(className: "SWTwoSumVC")
    }

    // MARK: - 20: 阶乘后的0
    @objc func SWTrailingZeroes()  {
        psuhToTargetVC(className: "SWTrailingZeroesVC")
    }

    // MARK: - 21:反转链表
    @objc func SWReverseList()  {
        psuhToTargetVC(className: "SWReverseListVC")
    }
    
    // MARK: - 22.汇总区间
    @objc func SWSummaryRanges()  {
        psuhToTargetVC(className: "SWSummaryRangesViewController")
    }
    
    // MARK: - 23.二叉搜索树的最近公共祖先
    @objc func SWLowestCommonAncestor()  {
        psuhToTargetVC(className: "SWLowestCommonAncestorVC")
    }
    
    // MARK: - 24.丢失的数字
    @objc func SWMissingNumber()  {
        psuhToTargetVC(className: "SWMissingNumberVC")
    }

    // MARK: - 25.4的幂
    @objc func SWIsPowerOfFour()  {
        psuhToTargetVC(className: "SWIsPowerOfFourVC")
    }

    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listItemArray[indexPath.row].title!, tableView: tableView);
    }
    
    
    /// 根据Class名找到对应的类并创建类的实例
    /// - Parameter className: 类名
    func psuhToTargetVC(className:String)  {
        let modelClass: AnyClass? = NSClassFromString("LearnSwift.\(className)")
        if let VCClass = modelClass as? UIViewController.Type {
            let vcInstance = VCClass.init()
            navigationController?.pushViewController(vcInstance, animated: true)
        }
    }
    
}
