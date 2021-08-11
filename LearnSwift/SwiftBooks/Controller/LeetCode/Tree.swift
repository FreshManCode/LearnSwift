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


