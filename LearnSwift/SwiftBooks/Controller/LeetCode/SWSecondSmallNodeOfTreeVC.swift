//
//  SWSecondSmallNodeOfTreeVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/7/27.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWSecondSmallNodeOfTreeVC: SWBaseViewController {
    
    var rootValue:Int?
    var answer = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData();
        // Do any additional setup after loading the view.
    }
    
    /*
     题目描述:二叉树中第二小的节点
     
     给定一个非空特殊的二叉树,每个节点都是正数,并且每个节点的子节点数量只能为2或0.如果一个节点有两个子节点的话,
     那么该节点的值等于两个子节点中较小的一个.
     更正式地说，root.val = min(root.left.val, root.right.val) 总成立。
     给出这样的一个二叉树，你需要输出所有节点中的第二小的值。如果第二小的值不存在的话，输出 -1 。
     
     输入：root = [2,2,5,null,null,5,7]
     输出：5
     解释：最小的值是 2 ，第二小的值是 5 。
     
     
     来源：力扣（LeetCode）
     链接：https://leetcode-cn.com/problems/second-minimum-node-in-a-binary-tree
     */
    
    func p_initDefautData()  {
        title = "二叉树中第二小的节点"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.二叉树中第二小的节点 ",
                                            subTitle: "",
                                            funName: "findSecondSmallNode"))
        
        
        tableView.reloadData()
        
        
        
    }
    
    @objc func findSecondSmallNode() {
        let rightNode = TreeNode(5, TreeNode(5), TreeNode(7))
        let leftNode  = TreeNode(2);
        let rootNode  = TreeNode(2, leftNode, rightNode);
        print("answer is:",findSecondMinimumValue(rootNode));
    }
    
    func findSecondMinimumValue(_ root:TreeNode?) -> Int {
        guard let myRoot = root else {
            return answer
        }
        rootValue = myRoot.val
        return findAnswer(myRoot)
    }
    func findAnswer(_ node:TreeNode?) -> Int {
        guard let tempNode = node else {
            return answer
        }
        if (answer != -1 && answer < tempNode.val) {
            return answer
        }
        if (tempNode.val > rootValue!) {
            answer = tempNode.val
        }
        findAnswer(tempNode.left)
        findAnswer(tempNode.right)
        return answer
    }
    
}

class TreeNode  {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}
