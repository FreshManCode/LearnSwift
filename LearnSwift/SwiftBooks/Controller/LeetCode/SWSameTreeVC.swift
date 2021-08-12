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
        listItemArray.append(SWBookListItem(title: "2.对称二叉树(我自己实现) ",
                                            subTitle: "",
                                            funName: "mySymmetric"))
        
        
        
        
        
        
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
    
    // MARK: - 对称二叉树
    @objc func mySymmetric()  {
        /**对称二叉树
         题目描述:
         给定一个二叉树，检查它是否是镜像对称的。
         例如，二叉树 [1,2,2,3,4,4,3] 是对称的。
         但是下面这个 [1,2,2,null,3,null,3] 则不是镜像对称的:

         
         方法一：递归
         思路和算法

         如果一个树的左子树与右子树镜像对称，那么这个树是对称的。
         因此，该问题可以转化为：两个树在什么情况下互为镜像？

         如果同时满足下面的条件，两个树互为镜像：

         它们的两个根结点具有相同的值
         每个树的右子树都与另一个树的左子树镜像对称
         
         我们可以实现这样一个递归函数，通过「同步移动」两个指针的方法来遍历这棵树，pp 指针和 qq 指针一开始都指向这棵树的根，随后 pp 右移时，qq 左移，pp 左移时，qq 右移。每次检查当前 pp 和 qq 节点的值是否相等，如果相等再判断左右子树是否对称。

         链接：https://leetcode-cn.com/problems/symmetric-tree/solution/dui-cheng-er-cha-shu-by-leetcode-solution/
         */
        let nodeOne = TreeNode(1, TreeNode(2, TreeNode(3), TreeNode(4)), TreeNode(2, TreeNode(4), TreeNode(3)))
        let nodeTwo = TreeNode(1, TreeNode(2, nil, TreeNode(3)), TreeNode(2, nil, TreeNode(3)))
        print("nodeOne:\(isSymmetric(nodeOne))")
        print("nodeTwo:\(isSymmetric(nodeTwo))")
        
        
        print("queueNodeOne:\(queueIsSymmetric(nodeOne))")
        print("queueNodeTwo:\(queueIsSymmetric(nodeTwo))")
        
        
        
    }
    func isSymmetric(_ root: TreeNode?) -> Bool {
        return check(root, root)
    }
    
    func check(_ leftNode:TreeNode? ,_ rightNode:TreeNode? ) -> Bool {
        if leftNode == nil && rightNode == nil {
            return true
        }
        else if (leftNode == nil || rightNode == nil) {
            return false
        }
        return leftNode?.val == rightNode?.val && check(leftNode?.left, rightNode?.right) && check(leftNode?.right, rightNode?.left)
    }
    
    // MARK: - 对称二叉树(队列方法)
    func queueIsSymmetric(_ root:TreeNode?) -> Bool {
        /**
         队列实现
         回想下递归的实现：
         当两个子树的根节点相等时，就比较:
         左子树的 left 和 右子树的 right，这个比较是用递归实现的。
         现在我们改用队列来实现，思路如下：
         首先从队列中拿出两个节点(left 和 right)比较
         将 left 的 left 节点和 right 的 right 节点放入队列
         将 left 的 right 节点和 right 的 left 节点放入队列
         时间复杂度是 O(n)O(n)，空间复杂度是 O(n)O(n)

         链接：https://leetcode-cn.com/problems/symmetric-tree/solution/dong-hua-yan-shi-101-dui-cheng-er-cha-shu-by-user7/
         */
        return queueCheck(root)
    }
    
    func queueCheck(_ root:TreeNode?) -> Bool {
        var nodeArray = [TreeNode?]()
        nodeArray.append(root?.left)
        nodeArray.append(root?.right)
        while nodeArray.count > 0 {
            let leftNode  = nodeArray.removeFirst()
            let rightNode = nodeArray.removeFirst()
            //如果两个节点都为空就继续循环，两者有一个为空就返回false
            if leftNode == nil && rightNode == nil {
                continue
            }
            if leftNode == nil || rightNode == nil {
                return false
            }
            if leftNode!.val != rightNode!.val {
                return false
            }
            //将左节点的左孩子， 右节点的右孩子放入队列
            nodeArray.append(leftNode!.left)
            nodeArray.append(rightNode!.right)
            
            ////将左节点的右孩子，右节点的左孩子放入队列
            nodeArray.append(leftNode!.right)
            nodeArray.append(rightNode!.left)
        }
        return true
    }
    
    
}
