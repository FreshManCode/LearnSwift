//
//  SWBinayTreeOrderVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/24.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWBinayTreeOrderVC: SWBaseViewController {
    
    var treeNode1:TreeNode?
    var treeNode2:TreeNode?
    var treeNode3:TreeNode?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    func p_initDefault() {
        treeNode1 = TreeNode(1, nil, TreeNode(2, TreeNode(3), nil))
        treeNode2 = TreeNode(1, TreeNode(3, TreeNode(5), TreeNode(3, TreeNode(5), TreeNode(4))), TreeNode(2, TreeNode(3), nil))
        treeNode3 = TreeNode(1)
        
    }
    
    func p_initDefautData()  {
        title = "二叉树遍历"
        view.addSubview(tableView)
        p_initDefault()
        listItemArray.append(SWBookListItem(title: "1. 二叉树前序遍历 ",
                                            subTitle: "",
                                            funName: "myBinaryTreeForwardOrder"))
        listItemArray.append(SWBookListItem(title: "1.1 二叉树前序遍历(迭代) ",
                                            subTitle: "",
                                            funName: "binaryTreeForwardOrder"))
        tableView.reloadData()
    }
    
    // MARK: - 二叉树前序遍历
    @objc func myBinaryTreeForwardOrder() {
        /**
         二叉树的前序遍历
         给你二叉树的根节点 root ，返回它节点值的 前序 遍历。
         “前序遍历的规则为:若二叉树为空,则返回空操作。否则先访问根节点,然后前序遍历左子树,在前序遍历右子树。”
         */
        func preorderTraversal(_ root: TreeNode?) -> [Int] {
            var result = [Int]()
            preorderTraversal(root, &result)
            return result
        }
        func preorderTraversal(_ root: TreeNode?,_ result:inout [Int]) {
            if root != nil {
                result.append(root!.val)
                preorderTraversal(root?.left, &result)
                preorderTraversal(root?.right, &result)
            }
        }
        
        print("1:\(preorderTraversal(treeNode1))")
        print("2:\(preorderTraversal(treeNode2))")
        print("3:\(preorderTraversal(treeNode3))")
        
    }
    
    // MARK: - 二叉树前序遍历(迭代)
    @objc func binaryTreeForwardOrder()  {
        /**
         方法二：迭代
         思路与算法

         我们也可以用迭代的方式实现方法一的递归函数，两种方式是等价的，区别在于递归的时候隐式地维护了一个栈，而我们在迭代的时候需要显式地将这个栈模拟出来，其余的实现与细节都相同，

         链接：https://leetcode-cn.com/problems/binary-tree-preorder-traversal/solution/er-cha-shu-de-qian-xu-bian-li-by-leetcode-solution/
         */
        func preorderTraversal(_ root: TreeNode?) -> [Int] {
            var result = [Int]()
            if root == nil {
                return result
            }
            var stackArray = [TreeNode?]()
            stackArray.append(root)
//          由于是入栈,先进后出,所以先入栈右子树,因为要先遍历左子树
            while !stackArray.isEmpty  {
                let node = stackArray.popLast()!
                result.append(node!.val)
                if node?.right != nil {
                    stackArray.append(node?.right)
                }
                if node?.left != nil {
                    stackArray.append(node?.left)
                }
            }
            return result
        }
        
        
        print("1:\(preorderTraversal(treeNode1))")
        print("2:\(preorderTraversal(treeNode2))")
        print("3:\(preorderTraversal(treeNode3))")
        
    }
    
    
    
    
    
    
}
