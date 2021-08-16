//
//  SWBalancedTreeVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/16.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWBalancedTreeVC: SWBaseViewController {
    
    var nodeOne:TreeNode?
    var nodeTwo:TreeNode?
    var nodeThree:TreeNode?
    
    
    var node1:TreeNode?
    var node2:TreeNode?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        p_initDefautData()
        p_initDefaultNode()
    }
    
    
    func p_initDefautData()  {
        title = "平衡二叉树"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.平衡二叉树 ",
                                            subTitle: "",
                                            funName: "myIsBalancedTree"))
        listItemArray.append(SWBookListItem(title: "2.平衡二叉树(自底向上的递归) ",
                                            subTitle: "",
                                            funName: "myIsBalancedTreeFromBottomToTop"))
        listItemArray.append(SWBookListItem(title: "3.二叉树的最小深度(自己实现) ",
                                            subTitle: "",
                                            funName: "myMinLengthBinaryTree"))
        
        
        
        
        
        tableView.reloadData()
    }
    
    func p_initDefaultNode() {
//        root = [3,9,20,null,null,15,7]
        nodeOne = TreeNode(3, TreeNode(9), TreeNode(20, TreeNode(15), TreeNode(7)))
//        root = [1,2,2,3,3,null,null,4,4]
        nodeTwo = TreeNode(1, TreeNode(2, TreeNode(3, TreeNode(4), TreeNode(4)), TreeNode(3)), TreeNode(2))
        
//      root = [3,9,20,null,null,15,7]
        node1 = TreeNode(3, TreeNode(9), TreeNode(20, TreeNode(15), TreeNode(7)))
        
//      root = [2,null,3,null,4,null,5,null,6]
        node2 = TreeNode(2, nil, TreeNode(3, nil, TreeNode(4, nil, TreeNode(5, nil, TreeNode(6)))))
        
        
        
    }
    
    
    @objc func myIsBalancedTree() {
        /**
         给定一个二叉树，判断它是否是高度平衡的二叉树。

         本题中，一棵高度平衡二叉树定义为：

         一个二叉树每个节点 的左右两个子树的高度差的绝对值不超过 1 。
         
         输入：root = [3,9,20,null,null,15,7]
         输出：true
         
         输入：root = [1,2,2,3,3,null,null,4,4]
         输出：false
         
         输入：root = []
         输出：true
         */
        let result = myCaculateIsBalancedTree(nodeOne)
        let result2 = myCaculateIsBalancedTree(nodeTwo)
        
        print("result:\(result) result2:\(result2)")
    }
    
    func myCaculateIsBalancedTree(_ root: TreeNode?) -> Bool {
        /**
         这道题中的平衡二叉树的定义是：二叉树的每个节点的左右子树的高度差的绝对值不超过 1，则二叉树是平衡二叉树。根据定义，一棵二叉树是平衡二叉树，当且仅当其所有子树也都是平衡二叉树，因此可以使用递归的方式判断二叉树是不是平衡二叉树，递归的顺序可以是自顶向下或者自底向上。

         链接：https://leetcode-cn.com/problems/balanced-binary-tree/solution/ping-heng-er-cha-shu-by-leetcode-solution/
         
         有了计算节点高度的函数，即可判断二叉树是否平衡。具体做法类似于二叉树的前序遍历，即对于当前遍历到的节点，首先计算左右子树的高度，如果左右子树的高度差是否不超过 1，再分别递归地遍历左右子节点，并判断左子树和右子树是否平衡。这是一个自顶向下的递归的过程。

         链接：https://leetcode-cn.com/problems/balanced-binary-tree/solution/ping-heng-er-cha-shu-by-leetcode-solution/

         
         
         */
        if root == nil {
            return true
        }
        let leftLength  = myCaculateTreeLength(root?.left)
        let rightLength = myCaculateTreeLength(root?.right)
        
        return (abs(leftLength - rightLength) <= 1 && myCaculateIsBalancedTree(root?.left) && myCaculateIsBalancedTree(root?.right))
        
    }
    
    
    /// 定义函数 height，用于计算二叉树中的任意一个节点 p 的高度：
    /// - Parameter tree: 节点
    /// - Returns: 高度
    func myCaculateTreeLength(_ tree:TreeNode?) -> Int {
        if tree == nil {
            return 0
        }
        return max(myCaculateTreeLength(tree?.left), myCaculateTreeLength(tree?.right)) + 1
    }
    
    
    // MARK: - 平衡二叉树(自底向上的递归)
    @objc func myIsBalancedTreeFromBottomToTop()  {
        /*
         方法一由于是自顶向下递归，因此对于同一个节点，函数 height 会被重复调用，导致时间复杂度较高。如果使用自底向上的做法，则对于每个节点，函数 height 只会被调用一次。

         自底向上递归的做法类似于后序遍历，对于当前遍历到的节点，先递归地判断其左右子树是否平衡，再判断以当前节点为根的子树是否平衡。如果一棵子树是平衡的，则返回其高度（高度一定是非负整数），否则返回 -1。如果存在一棵子树不平衡，则整个二叉树一定不平衡。
         链接：https://leetcode-cn.com/problems/balanced-binary-tree/solution/ping-heng-er-cha-shu-by-leetcode-solution/
         */
        let result = myCaculateIsBalancedTree(nodeOne)
        let result2 = myCaculateIsBalancedTree(nodeTwo)
        
        print("result:\(result) result2:\(result2)")
        
    }
    
    func isBalancedTree(_ tree:TreeNode?) -> Bool {
        return height(tree) >= 0
    }
    
    func height(_ tree:TreeNode?) -> Int {
        if tree == nil {
            return 0
        }
        let leftHeight  = height(tree?.left)
        let rightHeight = height(tree?.right)
        if leftHeight == -1 || rightHeight == -1 || abs(leftHeight - rightHeight) > 1 {
            return -1
        } else {
            return max(leftHeight, rightHeight) + 1
        }
    }
    
    
    // MARK: - 二叉树最小深度

    @objc func myMinLengthBinaryTree()  {
        /**
         二叉树的最小深度
         给定一个二叉树，找出其最小深度。

         最小深度是从根节点到最近叶子节点的最短路径上的节点数量。

         说明：叶子节点是指没有子节点的节点。


         输入：root = [3,9,20,null,null,15,7]
         输出：2
         
         输入：root = [2,null,3,null,4,null,5,null,6]
         输出：5
         
         */
        print("node1:\(myMinDepth(node1)) node2:\(myMinDepth(node2))")
        
    }
    func myMinDepth(_ root: TreeNode?) -> Int {
        /**
         方法一：深度优先搜索
         
         首先可以想到使用深度优先搜索的方法，遍历整棵树，记录最小深度。

         对于每一个非叶子节点，我们只需要分别计算其左右子树的最小叶子节点深度。这样就将一个大问题转化为了小问题，可以递归地解决该问题。

         链接：https://leetcode-cn.com/problems/minimum-depth-of-binary-tree/solution/er-cha-shu-de-zui-xiao-shen-du-by-leetcode-solutio/
        
         叶子节点的定义是左孩子和右孩子都为 null 时叫做叶子节点
         当 root 节点左右孩子都为空时，返回 1
         当 root 节点左右孩子有一个为空时，返回不为空的孩子节点的深度
         当 root 节点左右孩子都不为空时，返回左右孩子较小深度的节点值

   
         链接：https://leetcode-cn.com/problems/minimum-depth-of-binary-tree/solution/li-jie-zhe-dao-ti-de-jie-shu-tiao-jian-by-user7208/
         */
        if root == nil {
            return 0
        }
        if root?.left == nil {
            return myMinDepth(root?.right) + 1
        } else if root?.right == nil {
            return myMinDepth(root?.left) + 1
        }
        return min(myMinDepth(root?.left), myMinDepth(root?.right)) + 1
    }

    
}
