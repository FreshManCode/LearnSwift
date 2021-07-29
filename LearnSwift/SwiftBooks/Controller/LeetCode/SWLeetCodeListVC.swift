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
