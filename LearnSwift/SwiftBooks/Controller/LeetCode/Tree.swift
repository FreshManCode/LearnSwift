//
//  Tree.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/11.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import Foundation

public class MyTreeNode {
    public var val: Int
    public var left: MyTreeNode?
    public var right: MyTreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: MyTreeNode?, _ right: MyTreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

public class MyColorTreeNode {
    public var val: Int
    public var left: MyColorTreeNode?
    public var right: MyColorTreeNode?
    //  节点颜色,默认为White
    var nodeColor : NodeColor = NodeColor.White
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: MyColorTreeNode?, _ right: MyColorTreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

enum NodeColor {
    case White;
    case Gray;
}


class TreeNode:Equatable,Hashable  {
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
    public  init(_ val:Int, left:TreeNode?) {
        self.val = val
        self.left = left
    }
    
    public  init(_ val:Int,  right:TreeNode?) {
        self.val = val
        self.right = left
    }
    
    static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs === rhs
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}


class ListNode  {
    var val:Int
    var next:ListNode?
    init() {
        self.val = 0
        self.next = nil
    }
    init(_ val:Int) {
        self.val = val
        self.next = nil
    }
    init(_ val:Int,_ next:ListNode?) {
        self.val = val
        self.next = next
    }
}

extension ListNode:Equatable,Hashable {
    static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs === rhs
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

extension ListNode {
    
    
    /// 把数组转为ListNode
    /// - Parameter numbers: 数组
    /// - Returns: 链表
    class func createNode(_ numbers:[Int]) -> ListNode? {
        if numbers.count < 1 {
            return nil
        }
        let headNode = ListNode.init(numbers[0])
        var node:ListNode = headNode
        
        let length = numbers.count
        var index = 1
        
        while index < length {
            let my_node = ListNode.init(numbers[index])
            node.next = my_node
            node = node.next!
            index += 1
        }
        return headNode
    }
    
    
    class func transferNumberToReverseArray(_ number:Int) -> [Int] {
        
        let string = String(number)
        let length = string.count
        var result:[Int] = []
        for index in 0..<length {
            let resultStr = (string as NSString).substring(with: NSMakeRange(length - index - 1,1))
            result.append(Int(resultStr)!)
        }
        return result
    }
    
    
    /// 把链表打印为数组
    /// - Parameter number: 数组
    /// - Returns: 链表
    class func transListNodeToListArray(_ node:ListNode?) -> [Int] {
        if node != nil {
            var nextNode = node
            var result = [Int]()
            while nextNode != nil {
                result.append(nextNode!.val)
                nextNode = nextNode?.next
            }
            return result
        }
        return []
    }
    
    
    /// 创建循环链表
    /// - Parameters:
    ///   - numbers: 给定的节点数组
    ///   - cycleIndex: 循环链表的起始index(如果index的索引不在节点数组范围内,则无效)
    /// - Returns: 创建的链表
    class  func createCycleList(_ numbers:[Int],_ cycleIndex:Int) -> ListNode? {
        if numbers.count < 1 {
            return nil
        }
        var tempNodeArray = [ListNode]()
        
        let headNode = ListNode(numbers.first!)
        var curNode = headNode
        var tagIndex = -1
        if cycleIndex >= 0 && cycleIndex < numbers.count {
            tagIndex = cycleIndex
        }
        tempNodeArray.append(headNode)
        for (index,value) in numbers.enumerated() {
            if index > 0 {
                let node = ListNode(value)
                curNode.next = node
                curNode = curNode.next!
                tempNodeArray.append(node)
            }
        }
        if tagIndex >= 0 {
            let tailNode = tempNodeArray.last!
            let tagNode  = tempNodeArray[tagIndex]
            tailNode.next = tagNode
        }
        
        return headNode
    }
    
    
}

