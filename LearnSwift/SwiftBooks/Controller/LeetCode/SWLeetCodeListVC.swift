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
        listItemArray.append(SWBookListItem(title: "11.+1以及",
                                            subTitle: "",
                                            funName: "SWPlusOne"))
        
        
        
        
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
    
    
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listItemArray[indexPath.row].title!, tableView: tableView);
    }
    
    func psuhToTargetVC(className:String)  {
        let modelClass: AnyClass? = NSClassFromString("LearnSwift.\(className)")
        if let VCClass = modelClass as? UIViewController.Type {
            let vcInstance = VCClass.init()
            navigationController?.pushViewController(vcInstance, animated: true)
        }
    }
    
}
