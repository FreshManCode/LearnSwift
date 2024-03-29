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
        listItemArray.append(SWBookListItem(title: "2. 二叉树的后序遍历",
                                            subTitle: "",
                                            funName: "myPostorderTraversal"))
        listItemArray.append(SWBookListItem(title: "2.1 二叉树的后序遍历(迭代)",
                                            subTitle: "",
                                            funName: "postorderTraversal"))
        
        listItemArray.append(SWBookListItem(title: "3 最小栈",
                                            subTitle: "",
                                            funName: "myMinStack"))
        listItemArray.append(SWBookListItem(title: "4 相交链表",
                                            subTitle: "",
                                            funName: "myIntersectionNode"))
        listItemArray.append(SWBookListItem(title: "4.1 相交链表(双指针)",
                                            subTitle: "",
                                            funName: "intersectionNode"))
        
        
        
        
        
        
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
        
        
        
        
        /// 二叉树前序遍历(迭代)方法2
        /// - Parameter root: 节点
        /// - Returns: 结果
        func preorderTraversal1(_ root: TreeNode?)->[Int] {
            /**
             核心思想为：
             
             1.每拿到一个 节点 就把它保存在 栈 中
             
             2.继续对这个节点的 左子树 重复 过程1，直到左子树为 空
             
             3.因为保存在 栈 中的节点都遍历了 左子树 但是没有遍历 右子树，所以对栈中节点 出栈 并对它的 右子树 重复 过程1
             
             4.直到遍历完所有节点
             链接：https://leetcode-cn.com/problems/binary-tree-postorder-traversal/solution/die-dai-jie-fa-shi-jian-fu-za-du-onkong-jian-fu-za/
             
             根->左->右
             */
            if root == nil {
                return []
            }
            var result = [Int]()
            var stackArray = [TreeNode?]()
            var node = root
            
            while (!stackArray.isEmpty || node != nil)  {
                if node != nil {
                    // 每遇到一个节点，就把它加入结果集，并把该节点保存到中间结果中
                    result.append(node!.val)
                    //  先遍历左子树，一直走到空
                    stackArray.append(node)
                    node = node?.left
                } else {
                    // 左子树走到空，就从获取已经遍历过左子树的中间结果，将它出栈，并遍历它的右子树
                    let popNode = stackArray.removeLast()
                    node = popNode?.right
                }
                
            }
            return result
        }
        
        
        print("1:\(preorderTraversal(treeNode1))_\(preorderTraversal1(treeNode1))")
        print("2:\(preorderTraversal(treeNode2))_\(preorderTraversal1(treeNode2))")
        print("3:\(preorderTraversal(treeNode3))_\(preorderTraversal1(treeNode3))")
        
        
        
    }
    
    
    // MARK: - 二叉树的后续遍历
    @objc func myPostorderTraversal()  {
        /**
         二叉树的后序遍历
         左->右->根
         给定一个二叉树，返回它的 后序 遍历。
         每次都是先遍历树的左子树，然后再遍历树的右子树，最后再遍历根节点，以此类推，直至遍历完整个树。
         */
        func iteratePostOrder(_ root:TreeNode?,_ result:inout [Int]) {
            if root != nil {
                iteratePostOrder(root?.left, &result)
                iteratePostOrder(root?.right, &result)
                result.append(root!.val)
            }
        }
        func my_postorderTraversal(_ root: TreeNode?) -> [Int] {
            if root == nil {
                return []
            }
            var result = [Int]()
            iteratePostOrder(root, &result)
            return result
        }
        
        
        print("1:\(my_postorderTraversal(treeNode1))")
        print("2:\(my_postorderTraversal(treeNode2))")
        print("3:\(my_postorderTraversal(treeNode3))")
    }
    
    // MARK: - 二叉树的后续遍历 (自己使用栈实现)
    @objc func postorderTraversal()  {
        /**
         https://leetcode-cn.com/problems/binary-tree-postorder-traversal/solution/die-dai-jie-fa-shi-jian-fu-za-du-onkong-jian-fu-za/
         
         如果1： 我们将前序遍历中节点插入结果链表尾部的逻辑，修改为将节点插入结果链表的头部
         
         那么结果链表就变为了：右 -> 左 -> 根
         
         如果2： 我们将遍历的顺序由从左到右修改为从右到左，配合如果1
         
         那么结果链表就变为了：左 -> 右 -> 根
         
         作者：18211010139
         链接：https://leetcode-cn.com/problems/binary-tree-postorder-traversal/solution/die-dai-jie-fa-shi-jian-fu-za-du-onkong-jian-fu-za/
         来源：力扣（LeetCode）
         著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
         
         */
        func postorderTraversal(_ root: TreeNode?) -> [Int] {
            if root == nil {
                return []
            }
            var result = [Int]()
            var stackArray = [TreeNode?]()
            var node = root
            while (!stackArray.isEmpty || node != nil){
                if node != nil {
                    // 对应处理1，每次后序遍历时，都将节点写入结果链表头，而不是尾
                    if result.count > 0 {
                        result.insert(node!.val, at: 0)
                    } else {
                        result.append(node!.val)
                    }
                    stackArray.append(node)
                    //  对应处理2，每次先遍历右节点，再遍历左节点
                    node = node?.right
                } else {
                    node = stackArray.removeLast()
                    // 对应处理2，每次先遍历右节点，再遍历左节点
                    node = node?.left
                }
            }
            return result
        }
        
        print("1:\(postorderTraversal(treeNode1))")
        print("2:\(postorderTraversal(treeNode2))")
        print("3:\(postorderTraversal(treeNode3))")
        
        
    }
    
    // MARK: - 最小栈
    @objc func myMinStack()  {
        /**
         设计一个支持 push ，pop ，top 操作，并能在常数时间内检索到最小元素的栈。
         
         push(x) —— 将元素 x 推入栈中。
         pop() —— 删除栈顶的元素。
         top() —— 获取栈顶元素。
         getMin() —— 检索栈中的最小元素。
         */
//       参考下面的MinStack 类
    }
    
    // MARK: - 相交链表
    @objc func myIntersectionNode()  {
        /**
         给你两个单链表的头节点 headA 和 headB ，请你找出并返回两个单链表相交的起始节点。如果两个链表没有交点，返回 null 。
         
         1.先对两个链表进行遍历,并保存所得的结点
         1. 2.对保存的两个结点进行倒序遍历,检测第一个不相等的结点索引位置,并进行是否为空判断
         
         */
        let tailNode = ListNode(8, ListNode(4, ListNode(5)))
        let headNode1 = ListNode(1, ListNode(1,tailNode ))
        let headNode2 = ListNode(5, ListNode(0, ListNode(1,tailNode)))

        func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
            var resultA = [ListNode]()
            var resultB = [ListNode]()
            var nodeA = headA
            var nodeB = headB
            if nodeA == nil || nodeB == nil {
                return nil
            }
            while (nodeA != nil || nodeB != nil) {
                if nodeA != nil {
                    resultA.append(nodeA!)
                    nodeA = nodeA?.next
                }
                if nodeB != nil {
                    resultB.append(nodeB!)
                    nodeB = nodeB?.next
                }
            }
            
            let aLength = resultA.count
            let bLength = resultB.count
            
            var index = 0
            while (index < aLength && index < bLength) {
                let a = resultA[aLength - index - 1]
                let b = resultB[bLength - index - 1]
                if a != b {
                    break
                }
                index += 1
            }
            if index == 0 {
                return nil
            }
            return resultA[aLength - index]
        }
        
        let node = getIntersectionNode(headNode1, headNode2)
        print("result:\(node),value:\(node?.val)")
        
    }
    
    // MARK: - 相交链表(双指针)
    @objc func intersectionNode()  {
        let tailNode = ListNode(8, ListNode(4, ListNode(5)))
        let headNode1 = ListNode(1, ListNode(1,tailNode ))
        let headNode2 = ListNode(5, ListNode(0, ListNode(1,tailNode)))
        /**
         如果两个链表相交，那么相交点之后的长度是相同的

         我们需要做的事情是，让两个链表从同距离末尾同等距离的位置开始遍历。这个位置只能是较短链表的头结点位置。
         为此，我们必须消除两个链表的长度差

         指针 pA 指向 A 链表，指针 pB 指向 B 链表，依次往后遍历
         如果 pA 到了末尾，则 pA = headB 继续遍历
         如果 pB 到了末尾，则 pB = headA 继续遍历
         比较长的链表指针指向较短链表head时，长度差就消除了
         如此，只需要将最短链表遍历两次即可找到位置


         链接：https://leetcode-cn.com/problems/intersection-of-two-linked-lists/solution/tu-jie-xiang-jiao-lian-biao-by-user7208t/
         */
        func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
            if headA == nil || headB == nil {
                return nil
            }
            var pointerA = headA
            var pointerB = headB
            while pointerA != pointerB {
                pointerA = ( pointerA == nil) ? headB : pointerA?.next
                pointerB =  (pointerB == nil) ? headA : pointerB?.next
            }
            return pointerA

        }
        let node = getIntersectionNode(headNode1, headNode2)
        print("result:\(node),value:\(node?.val)")
    }


    
    
    
    
    
    
    
    
}



/// 最小栈设计
class MinStack {
    
    var stackArray = [Int]()
    private var minValue:Int?
    /** initialize your data structure here. */
    init() {
        
    }
    
    func push(_ val: Int) {
        if minValue == nil {
            minValue = val
        } else {
            minValue = min(val, minValue!)
        }
        stackArray.append(val)
    }
    
    func pop() {
        if !stackArray.isEmpty {
            let popValue = stackArray.removeLast()
            if popValue == minValue! {
                minValue = stackArray.first
                for item in stackArray {
                    if item < minValue! {
                        minValue = item
                    }
                }
            }
        }
    }
    
    func top() -> Int {
        if stackArray.isEmpty {
            return 0
        }
        return stackArray.last!
    }
    
    func getMin() -> Int {
        return minValue ?? 0
    }
}
