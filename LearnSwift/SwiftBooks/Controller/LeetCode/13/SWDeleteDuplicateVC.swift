//
//  SWDeleteDuplicateVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/10.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWDeleteDuplicateVC: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    func p_initDefautData()  {
        title = "删除排序链表中的重复元素以及"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.删除排序链表中的重复元素(我自己实现) ",
                                            subTitle: "",
                                            funName: "myDeleteDuplicateElement"))
        listItemArray.append(SWBookListItem(title: "2.合并两个有序数组(我自己实现) ",
                                            subTitle: "",
                                            funName: "myMerge"))
        listItemArray.append(SWBookListItem(title: "3. 二叉树的中序遍历(我自己实现) ",
                                            subTitle: "",
                                            funName: "myInorderTraversal"))
        listItemArray.append(SWBookListItem(title: "4. 二叉树的中序遍历(高效) ",
                                            subTitle: "",
                                            funName: "highEfficiencyInorderTraversal"))
        
        
        
        
        
        tableView.reloadData()
    }
    
    // MARK: - 删除排序链表中的重复元素
    @objc func myDeleteDuplicateElement() {
        /**
         
         存在一个按升序排列的链表，给你这个链表的头节点 head ，请你删除所有重复的元素，使每个元素 只出现一次 。
         
         返回同样按升序排列的结果链表。
         
         输入：head = [1,1,2]
         输出：[1,2]
         
         输入：head = [1,1,2,3,3]
         输出：[1,2,3]
         
         题解:
         https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list/solution/dong-hua-yan-shi-83-shan-chu-pai-xu-lie-lhuvr/
         
         
         思路
         标签：链表
         指定 cur 指针指向头部 head
         当 cur 和 cur.next 的存在为循环结束条件，当二者有一个不存在时说明链表没有去重复的必要了
         当 cur.val 和 cur.next.val 相等时说明需要去重，则将 cur 的下一个指针指向下一个的下一个，这样就能达到去重复的效果
         如果不相等则 cur 移动到下一个位置继续循环
         
         
         链接：https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list/solution/hua-jie-suan-fa-83-shan-chu-pai-xu-lian-biao-zhong/
         
         */
        let nodeOne = ListNode.createNode([1,1,2,3])
        let nodeTwo = ListNode.createNode([1,1,2,3,3,4,4,5,5,5,5])
        
        let result1 = ListNode.transListNodeToListArray(myDeleteDuplicates(nodeOne))
        let result2 = ListNode.transListNodeToListArray(myDeleteDuplicates(nodeTwo))
        print("result1:\(result1)")
        print("result2:\(result2)")
        
        
        
    }
    
    
    func myDeleteDuplicates(_ head: ListNode?) -> ListNode? {
        guard let headNode = head else {
            return nil
        }
        var currentNode = headNode
        while currentNode.next != nil {
            if currentNode.val == currentNode.next!.val {
                if currentNode.next!.next != nil {
                    currentNode.next = currentNode.next!.next!
                } else {
                    currentNode.next = nil
                }
            } else {
                currentNode = currentNode.next!
            }
        }
        return headNode
    }
    
    // MARK: - 合并两个有序数组
    @objc func myMerge() {
        /**
         合并两个有序数组
         双指针 解法:
         算法
         
         利用数组nums1以及nums2已经被排序的性质。为了利用这一性质，我们可以使用双指针方法。这一方法将两个数组看作队列，每次从两个数组头部取出比较小的数字放到结果中。
         
         链接：https://leetcode-cn.com/problems/merge-sorted-array/solution/he-bing-liang-ge-you-xu-shu-zu-by-leetco-rrb0/
         
         我们为两个数组分别设置一个指针indexP,indexQ来作为队列的头部指针。代码实现如下：
         */
        
        var arrayM = [1,2,3,0,0,0]
        let m = 3
        let arrayN = [2,5,6]
        let n = 3
        myMerge(&arrayM, m, arrayN, n)
        print("result:\(arrayM)")
        
        var arrayM1 = [1,2,3,0,0,0]
        let m1 = 3
        let arrayN1 = [2,5,6]
        let n1 = 3
        myMerge2(&arrayM1, m1, arrayN1, n1)
        print("result2:\(arrayM1)")
        
        
        
    }
    
    //  使用双指针方法进行排序
    func myMerge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        
        var indexP = 0,indexQ = 0;
        var result = [Int]()
        
        while (indexP < m || indexQ < n) {
            var currentValue = 0
            
            if indexP == m {
                currentValue = nums2[indexQ]
                indexQ += 1
            }
            else if (indexQ == n) {
                currentValue = nums1[indexP]
                indexP += 1
            }
            else if (nums1[indexP] < nums2[indexQ]) {
                currentValue = nums1[indexP]
                indexP += 1
            }
            else {
                currentValue = nums2[indexQ]
                indexQ += 1
            }
            result.append(currentValue)
        }
        nums1 = result
    }
    
    func myMerge2(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var indexN = 0
        //      先全部合并到num1数组中,然后再进行冒泡排序
        while indexN < n {
            nums1[ m + indexN] = nums2[indexN]
            indexN += 1
        }
        
        for _ in 0 ..< nums1.count {
            for j in 0 ..< nums1.count - 1 {
                if nums1[j] >= nums1[j + 1] {
                    let value = nums1[j]
                    nums1[j] = nums1[j + 1]
                    nums1[j + 1] = value
                }
            }
        }
        
    }
    
    
    // MARK: - 二叉树的中序遍历
    @objc func myInorderTraversal()  {
        /**
         二叉树的中序遍历
         方法一：递归
         思路与算法
         
         首先我们需要了解什么是二叉树的中序遍历：按照访问左子树——根节点——右子树的方式遍历这棵树，而在访问左子树或者右子树的时候我们按照同样的方式遍历，直到遍历完整棵树。因此整个遍历过程天然具有递归的性质，我们可以直接用递归函数来模拟这一过程。
         
         定义 inorder(root) 表示当前遍历到 root 节点的答案，那么按照定义，我们只要递归调用 inorder(root.left) 来遍历root 节点的左子树，然后将 root 节点的值加入答案，再递归调用inorder(root.right) 来遍历 root 节点的右子树即可，递归终止的条件为碰到空节点。
         
         链接：https://leetcode-cn.com/problems/binary-tree-inorder-traversal/solution/er-cha-shu-de-zhong-xu-bian-li-by-leetcode-solutio/
         
         
         */
        let rightNode = MyTreeNode(2, MyTreeNode.init(3), nil)
        let rootNode = MyTreeNode(1, nil, rightNode)
        print("result1: \(myInorderTraversal(rootNode))")
        
    }
    
    func myInorderTraversal(_ root: MyTreeNode?) -> [Int] {
        var result = [Int]()
        orderTravese(root, &result)
        return result
    }
    
    func orderTravese(_ node:MyTreeNode? ,_ result :inout [Int] )  {
        if node != nil {
            //          先遍历左子树
            orderTravese(node!.left, &result)
            //          根节点
            result.append(node!.val)
            //          遍历右子树
            orderTravese(node!.right, &result)
        }
    }
    
    
    @objc func highEfficiencyInorderTraversal()  {
        /**
         我在这里介绍一种“颜色标记法”（瞎起的名字……），兼具栈迭代方法的高效，又像递归方法一样简洁易懂，更重要的是，
         这种方法对于前序、中序、后序遍历，能够写出完全一致的代码。

         其核心思想如下：

         使用颜色标记节点的状态，新节点为白色，已访问的节点为灰色。
         如果遇到的节点为白色，则将其标记为灰色，然后将其右子节点、自身、左子节点依次入栈。
         如果遇到的节点为灰色，则将节点的值输出。
         
         前序遍历：中，左，右
         中序遍历：左，中，右
         后序遍历：左，右，中
         
         栈是一种 先进后出的结构，出栈顺序为左，中，右
         那么入栈顺序必须调整为倒序，也就是右，中，左

         
         链接：https://leetcode-cn.com/problems/binary-tree-inorder-traversal/solution/yan-se-biao-ji-fa-yi-chong-tong-yong-qie-jian-ming/
         */
        let rightNode = MyColorTreeNode(2, MyColorTreeNode.init(3), nil)
        let rootNode = MyColorTreeNode(1, nil, rightNode)
        print("result1: \(inorderTraversal(rootNode))")

    }

    
    
    func inorderTraversal(_ root: MyColorTreeNode?) -> [Int] {
        var result = [Int]()
        var nodeStack = Stack<MyColorTreeNode>()
        if root != nil {
            nodeStack.push(root!)
        }
        while !(nodeStack.isEmpty)  {
            let popNode = nodeStack.pop()
            if popNode == nil {
                continue
            }
            let colorNode = popNode!
//          第一次为white时是入栈
            if colorNode.nodeColor == NodeColor.White {
                if colorNode.right != nil {
                    nodeStack.push(colorNode.right!)
                }
                colorNode.nodeColor = NodeColor.Gray
                nodeStack.push(colorNode)
                if colorNode.left != nil {
                    nodeStack.push(colorNode.left!)
                }
            }
            else {
                result.append(colorNode.val)
            }
        }
        return result
    }
    
    
    
    
    
    
    
    
    
}
