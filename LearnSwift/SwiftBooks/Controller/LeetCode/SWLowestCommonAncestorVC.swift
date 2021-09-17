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
        
        listItemArray.append(SWBookListItem(title: "2. 删除链表中的节点 ",
                                            subTitle: "",
                                            funName: "myDeleteNode"))
        listItemArray.append(SWBookListItem(title: "3. 有效的字母异位词 ",
                                            subTitle: "",
                                            funName: "myIsAnagram"))
        listItemArray.append(SWBookListItem(title: "3.1 有效的字母异位词(哈希映射,效率高) ",
                                            subTitle: "",
                                            funName: "isAnagram"))
        listItemArray.append(SWBookListItem(title: "4. 二叉树的所有路径 ",
                                            subTitle: "",
                                            funName: "myBinaryTreePaths"))
        
        
        
        
        
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
    
    
    // MARK: - 删除链表中的节点
    @objc func myDeleteNode()  {
        var listNode1 = ListNode.createNode([1,2,3,4,5,6])
        var listNode2 = ListNode.createNode([1,2,3,4,5,6])
        func deleteNode(_ node:inout ListNode?,_ deleleVal:Int) {
            //          如果要删除的节点为头结点
            if node?.val == deleleVal {
                node = node?.next
            }
            //          其它
            else {
                var headNode = node
                while headNode?.next != nil {
                    if headNode?.next?.val == deleleVal {
                        //                      把当前节点的next往后移动两位
                        headNode?.next = headNode?.next?.next
                    }
                    //                  继续往后自动
                    headNode = headNode?.next
                }
            }
        }
        deleteNode(&listNode1, 3)
        deleteNode(&listNode2, 1)
        
        print("listNode1:\(ListNode.transListNodeToListArray(listNode1))")
        print("listNode2:\(ListNode.transListNodeToListArray(listNode2))")
    }
    
    // MARK: - 有效的字母异位词
    @objc func myIsAnagram()  {
        /**
         给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。
         
         注意：若 s 和 t 中每个字符出现的次数都相同，则称 s 和 t 互为字母异位词。
         
         解法一:遍历法
         对s字符串按照字符进行遍历,每遍历一个字符,判断t中是否有,如果没有则为false,如果有则删除第一个出现该字符的,
         一直到最后判断s字符串是否为空字符串.
         */
        func isAnagram(_ s: String, _ t: String) -> Bool {
            var result = t
            for item in s {
                if let i = result.firstIndex(of: item) {
                    result.remove(at: i)
                } else {
                    return false
                }
            }
            return result.count == 0
        }
        
        let s = "anagram", t = "nagaram"
        let s1 = "rat", t1 = "car"
        print("test1:\(isAnagram(s, t))")
        print("test2:\(isAnagram(s1, t1))")
        
    }
    
    // MARK: -有效的字母异位词(哈希映射,效率高)
    @objc func isAnagram()  {
        /**
         s 和 t 仅包含小写字母
         解题思路
         标签：哈希映射
         首先判断两个字符串长度是否相等，不相等则直接返回 false
         若相等，则初始化 26 个字母哈希表，遍历字符串 s 和 t
         在对应的字符串遍历中,给对应的哈希表做修改,最后对比两个哈希表是否相同
       
         */
        func isAnagram(_ s: String, _ t: String) -> Bool {
//          使用26个字母进行初始化(每个数组有26个元素,每个元素对应的特定字符出现的次数)
            var sArr = [Int](repeating: 0, count: 26)
            var tArr = [Int](repeating: 0, count: 26)
            for c in s.unicodeScalars {
                let index = Int(c.value - 97)
                sArr[index] = sArr[index] + 1
            }
            
            for c in t.unicodeScalars {
                let index = Int(c.value - 97)
                tArr[index] = tArr[index] + 1
            }
            
            return (sArr == tArr)
            
        }
        
    }
    
    
    // MARK: - 二叉树的所有路径
    @objc func myBinaryTreePaths()  {
        /**
         给你一个二叉树的根节点 root ，按 任意顺序 ，返回所有从根节点到叶子节点的路径。

         叶子节点 是指没有子节点的节点。
         
         输入：root = [1,2,3,null,5]
         输出：["1->2->5","1->3"]
         */
        /**
         方法一：深度优先搜索
         思路与算法

         最直观的方法是使用深度优先搜索。在深度优先搜索遍历二叉树时，我们需要考虑当前的节点以及它的孩子节点。

         如果当前节点不是叶子节点，则在当前的路径末尾添加该节点，并继续递归遍历该节点的每一个孩子节点。
         如果当前节点是叶子节点，则在当前路径末尾添加该节点后我们就得到了一条从根节点到叶子节点的路径，将该路径加入到答案即可。

         链接：https://leetcode-cn.com/problems/binary-tree-paths/solution/er-cha-shu-de-suo-you-lu-jing-by-leetcode-solution/
         */
        func caculatePath(_ node:TreeNode?,_ path:String,_ result : inout [String]) {
            if node != nil {
                let letNode   = node?.left
                let rightNode = node?.right
                var path = path
                path += "\(node!.val)"
                // 当前节点是叶子节点
                if letNode == nil && rightNode == nil {
                    result.append(path)
                }
                // 当前节点不是叶子节点，继续递归遍历
                else {
                    path += "->"
                    caculatePath(letNode, path, &result)
                    caculatePath(rightNode, path, &result)
                }
            }
        }
        func binaryTreePaths(_ root: TreeNode?) -> [String] {
            var result = [String]()
            caculatePath(root, "", &result)
            return result
        }
        
        let treeNode1 = TreeNode(1, TreeNode(2, nil, TreeNode(5)), TreeNode(3))
        let treeNode2 = TreeNode(1, TreeNode(2, TreeNode(3, TreeNode(5), TreeNode(6)), TreeNode(5)), TreeNode(3))
        
        print("treeNode1:\(binaryTreePaths(treeNode1))")
        print("treeNode2:\(binaryTreePaths(treeNode2))")
        
    }

    
    
    
}
