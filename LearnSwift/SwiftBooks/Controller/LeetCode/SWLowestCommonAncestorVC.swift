//
//  SWLowestCommonAncestorVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/9/16.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWLowestCommonAncestorVC: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    
    func p_initDefautData()  {
        title = "二叉搜索树的最近公共祖先"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1 二叉搜索树的最近公共祖先 ",
                                            subTitle: "",
                                            funName: "myLowestCommonAncestor"))
        
        listItemArray.append(SWBookListItem(title: "1.1 二叉搜索树的最近公共祖先 (利用搜索二叉树的性质) ",
                                            subTitle: "",
                                            funName: "lowestCommonAncestor"))
        
        tableView.reloadData()
    }
    
    
    // MARK: - 二叉搜索树的最近公共祖先 (递归法)
    @objc func myLowestCommonAncestor()  {
        let node2     = TreeNode(4, TreeNode(3), TreeNode(5))
        let letftNode = TreeNode(2, TreeNode(0),node2)
        let rightNode = TreeNode(8, TreeNode(7), TreeNode(9))
        
        let rootNode = TreeNode(6, letftNode, rightNode)
        
        func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
            if root == nil || root == p || root == q {
                return root
            }
            let leftNode  = lowestCommonAncestor(root?.left, p, q)
            let rightNode = lowestCommonAncestor(root?.right, p, q)
            
            //如果left为空，说明这两个节点在cur结点的右子树上，我们只需要返回右子树查找的结果即可
            if leftNode == nil {
                return rightNode
            }
            //如果right为空,说明这两个节点在cur结点的左子树上，我们只需要返回左子树查找的结果即可
            else if (rightNode == nil) {
                return leftNode
            }
            //如果left和right都不为空，说明这两个节点一个在cur的左子树上一个在cur的右子树上，
            return root
        }
        
        let result = lowestCommonAncestor(rootNode, letftNode, rightNode)
        print("result:\(result?.val ?? -1)")
        
        let result2 = lowestCommonAncestor(rootNode, letftNode, node2)
        print("result:\(result2?.val ?? -1)")
        
    }
    
    
    
    
    // MARK:1.1 - 二叉搜索树的最近公共祖先 (利用搜索二叉树的性质)
    @objc func lowestCommonAncestor()  {
        /**
         给定一个二叉搜索树, 找到该树中两个指定节点的最近公共祖先。
         
         在二叉搜索树中：(注意,二叉搜索树的性质)
         1.若任意结点的左子树不空，则左子树上所有结点的值均不大于它的根结点的值。
         2. 若任意结点的右子树不空，则右子树上所有结点的值均不小于它的根结点的值。
         3.任意结点的左、右子树也分别为二叉搜索树。
         
         百度百科中最近公共祖先的定义为：“对于有根树 T 的两个结点 p、q，最近公共祖先表示为一个结点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”
         
         示例 1:
         
         输入: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
         输出: 6
         解释: 节点 2 和节点 8 的最近公共祖先是 6。
         示例 2:
         
         输入: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
         输出: 2
         解释: 节点 2 和节点 4 的最近公共祖先是 2, 因为根据定义最近公共祖先节点可以为节点本身。
         
         链接：https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-search-tree
         
         整体的遍历过程与方法一中的类似：
         
         我们从根节点开始遍历；
         
         如果当前节点的值大于 p 和 q 的值，说明 p 和 q应该在当前节点的左子树，因此将当前节点移动到它的左子节点；
         
         如果当前节点的值小于 p 和 q的值，说明 p和 q 应该在当前节点的右子树，因此将当前节点移动到它的右子节点；
         
         如果当前节点的值不满足上述两条要求，那么说明当前节点就是「分岔点」。此时，p 和 q 要么在当前节点的不同的子树中，要么其中一个就是当前节点。
         
         如果一个节点值大于根节点，一个节点值小于根节点，说明他们他们一个在根节点的左子树上一个在根节点的右子树上，那么根节点就是他们的最近公共祖先节点。
         
         
         
         链接：https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-search-tree/solution/er-cha-sou-suo-shu-de-zui-jin-gong-gong-zu-xian-26/
         
         */
        
        let node2     = TreeNode(4, TreeNode(3), TreeNode(5))
        let letftNode = TreeNode(2, TreeNode(0),node2)
        let rightNode = TreeNode(8, TreeNode(7), TreeNode(9))
        let rootNode  = TreeNode(6, letftNode, rightNode)
        
        func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
            var headNode = root
            while headNode != nil {
                //              如果当前节点的值 都大于p和q的节点值,那么肯定在当前节点的左子树中
                if headNode!.val > p!.val && headNode!.val > q!.val {
                    headNode = headNode?.left
                }
                else if  headNode!.val < p!.val && headNode!.val < q!.val {
                    headNode = headNode?.right
                }
                else {
                    break
                }
            }
            return headNode
        }
        
        let result = lowestCommonAncestor(rootNode, letftNode, rightNode)
        print("result:\(result?.val ?? -1)")
        
        let result2 = lowestCommonAncestor(rootNode, letftNode, node2)
        print("result:\(result2?.val ?? -1)")
        
    }
    
}
