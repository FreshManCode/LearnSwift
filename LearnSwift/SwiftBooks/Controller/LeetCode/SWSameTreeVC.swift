//
//  SWSameTreeVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/12.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//  二叉树题合集 https://leetcode-cn.com/problems/same-tree/solution/xie-shu-suan-fa-de-tao-lu-kuang-jia-by-wei-lai-bu-/

import UIKit

class SWSameTreeVC: SWBaseViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    

    func p_initDefautData()  {
        title = "相同的树"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.相同的树(我自己实现) ",
                                            subTitle: "",
                                            funName: "myIsSameTree"))
       
        
        

        tableView.reloadData()
    }

    // MARK: - 相同的树
    @objc func myIsSameTree()  {
        /**
         
         
         相同的树
         前言
         两个二叉树相同，当且仅当两个二叉树的结构完全相同，且所有对应节点的值相同。因此，可以通过搜索的方式判断两个二叉树是否相同。

         方法一：深度优先搜索
         如果两个二叉树都为空，则两个二叉树相同。如果两个二叉树中有且只有一个为空，则两个二叉树一定不相同。

         如果两个二叉树都不为空，那么首先判断它们的根节点的值是否相同，若不相同则两个二叉树一定不同，若相同，再分别判断两个二叉树的左子树是否相同以及右子树是否相同。这是一个递归的过程，因此可以使用深度优先搜索，递归地判断两个二叉树是否相同。

         链接：https://leetcode-cn.com/problems/same-tree/solution/xiang-tong-de-shu-by-leetcode-solution/
       
         */
        //[1,2,3]
        let node1 = TreeNode(1, TreeNode(2), TreeNode(3))
        //[1,2,3]
        let node1_ = TreeNode(1, TreeNode(2), TreeNode(3))
        
        //[1,2]
        let node2 = TreeNode(1, TreeNode(2), nil)
        //[1,null,2]
        let node2_ = TreeNode(1, nil, TreeNode(2))
        
        print("node1:\(isSameTree(node1, node1_))")
        print("node2:\(isSameTree(node2, node2_))")
        
        
    }
    
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        } else if p == nil || q == nil {
            return false
        } else if (p?.val != q?.val) {
            return false
        } else {
//          判断左右子树是否相同
            return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
        }
       

    }
}
