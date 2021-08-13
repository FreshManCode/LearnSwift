//
//  SWSameTreeVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/12.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//  二叉树题合集 https://leetcode-cn.com/problems/same-tree/solution/xie-shu-suan-fa-de-tao-lu-kuang-jia-by-wei-lai-bu-/

import UIKit

class SWSameTreeVC: SWBaseViewController {
    
    var leftLength = 0
    var rightLength = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    
    func p_initDefautData()  {
        title = "相同的树-对称二叉树"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.相同的树(我自己实现) ",
                                            subTitle: "",
                                            funName: "myIsSameTree"))
        listItemArray.append(SWBookListItem(title: "2.对称二叉树(我自己实现) ",
                                            subTitle: "",
                                            funName: "mySymmetric"))
        
        listItemArray.append(SWBookListItem(title: "3.二叉树的最大深度(我自己实现) ",
                                            subTitle: "",
                                            funName: "myMaxTreeLength"))
        listItemArray.append(SWBookListItem(title: "4.将有序数组转换为二叉搜索树 ",
                                            subTitle: "",
                                            funName: "sortedArrayToBST"))
        
        
        
        
        
        
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
    
    
    // MARK: - . 二叉树的最大深度
    @objc func myMaxTreeLength()  {
        /** 二叉树的最大深度
         给定一个二叉树，找出其最大深度。

         二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。

         说明: 叶子节点是指没有子节点的节点。

         示例：
         给定二叉树 [3,9,20,null,null,15,7]，

         返回它的最大深度 3
         
         */
        
        
    }
    
    func myMaxDepth(_ root: TreeNode?) -> Int {
        /**
         方法一：深度优先搜索
         思路与算法

         如果我们知道了左子树和右子树的最大深度 ll 和 rr，那么该二叉树的最大深度即为

         max(l,r)+1

         而左子树和右子树的最大深度又可以以同样的方式进行计算。因此我们可以用「深度优先搜索」的方法来计算二叉树的最大深度。具体而言，在计算当前二叉树的最大深度时，可以先递归计算出其左子树和右子树的最大深度，然后在O(1) 时间内计算出当前二叉树的最大深度。递归在访问到空节点时退出。

         链接：https://leetcode-cn.com/problems/maximum-depth-of-binary-tree/solution/er-cha-shu-de-zui-da-shen-du-by-leetcode-solution/
         
         */
        if root == nil {
            return 0
        }
        let left  = myMaxDepth(root?.left)
        let right = myMaxDepth(root?.right)
        return max(left, right) + 1
        
    }
    
    
    // MARK: - 将有序数组转换为二叉搜索树
    @objc func sortedArrayToBST()  {
        /**
         将有序数组转换为二叉搜索树
         给你一个整数数组 nums ，其中元素已经按 升序 排列，请你将其转换为一棵 高度平衡 二叉搜索树。

         高度平衡 二叉树是一棵满足「每个节点的左右两个子树的高度差的绝对值不超过 1 」的二叉树。

         输入：nums = [-10,-3,0,5,9]
         输出：[0,-3,9,-10,null,5]
         解释：[0,-10,5,null,-3,null,9] 也将被视为正确答案：

         链接：https://leetcode-cn.com/problems/convert-sorted-array-to-binary-search-tree
         
         
         方法二：中序遍历，总是选择中间位置右边的数字作为根节点
         选择中间位置右边的数字作为根节点，则根节点的下标为 mid = (left + right + 1) / 2 ，此处的除法为整数除法。

         链接：https://leetcode-cn.com/problems/convert-sorted-array-to-binary-search-tree/solution/jiang-you-xu-shu-zu-zhuan-huan-wei-er-cha-sou-s-33/
         
         */
    }
    
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        return sortedArrayToBST(nums, 0, nums.count - 1)
    }
    
    func sortedArrayToBST(_ nums: [Int],_ left:Int, _ right:Int) -> TreeNode? {
        if left > right {
            return nil
        }
        // 总是选择中间位置右边的数字作为根节点
        let mid = (left + right + 1) / 2
        let treeNode   = TreeNode(nums[mid])
        treeNode.left  = sortedArrayToBST(nums, left, mid - 1)
        treeNode.right = sortedArrayToBST(nums, mid + 1, right)
        
        return treeNode
    }
    
   
    
    

    
    
    
    
    
    
    
}
