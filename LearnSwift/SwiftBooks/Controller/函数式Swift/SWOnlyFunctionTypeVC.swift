//
//  SWOnlyFunctionTypeVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/9/27.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

indirect  enum BinarySearchTree<Element:Comparable> {
    case leaf
    case node(left:BinarySearchTree<Element>,_ : Element,right:BinarySearchTree<Element>)
}

extension BinarySearchTree {
    init() {
        self = .leaf
    }
    
    init(_ value:Element) {
        self = .node(left: .leaf, value, right: .leaf)
    }
    
    //计算一棵树中存值的个数
    var count:Int {
        switch self {
        //枚举值为.leaf时,可以直接返回0
        case .leaf:
            return 0
            
        //在值为.node时,递归计算了两个子树存储的元素个数,然后+1,也就是当前节点储值的个数,再将他们的综合返回.
        case let .node(left, _, right):
            return 1 + left.count + right.count
        }
    }
    
    //再添加一个elements属性,用于计算树中所有元素组成的数组:
    var elements:[Element] {
        switch self {
        case .leaf:
            return []
        case let .node(left, x, right):
            return left.elements + [x] + right.elements
        }
    }
    
    func reduce<A>(leaf leafF:A,node nodeF:(A,Element,A)->A)->A  {
        switch self {
        case .leaf:
            return leafF
        case let .node(left,x, right):
            return nodeF(left.reduce(leaf: leafF, node: nodeF),x,right.reduce(leaf: leafF, node: nodeF))
        }
    }
    
    //使用reduce可以用很少的代码来编写elements和count
    var elementsR:[Element] {
        return reduce(leaf: [], node: {$0+[$1]+$2})
    }
    var countR:Int {
        return reduce(leaf: 0) { (left, value, right) -> Int in
            return 1 + left + right
        }
    }
    
    //检查一棵树是否为空
    var isEmpty:Bool {
        if case .leaf  = self {
            return true
        }
        return false
    }
    
    //低效率属性来检查BinarySearchTree 实际上是不是一棵二叉搜索树
    var isBST:Bool {
        switch self {
        case .leaf:
            return true
        case let .node(left, x, right):
            return left.elements.allSatisfy{y in y < x}
                && right.elements.allSatisfy{y in y > x}
                && left.isBST
                && right.isBST
        }
    }
    
    //查找一个元素是否在树中
    func contains(_ x:Element)->Bool  {
        switch self {
        case .leaf:
            return false
        case let .node(_, y, _) where x == y:
            return true
        case let .node(left, y, _) where x < y:
            return left.contains(x)
        case let .node( _, y, right) where x > y:
            return right.contains(x)
        default :
            fatalError("The impossible occurred")
        }
    }
    
    //插入操作
    mutating func insert(_ x:Element)  {
        switch self {
        case .leaf:
            self = BinarySearchTree(x)
        case .node(var left, let y, var right):
            if x < y {
                left.insert(x)
            }
            if x > y {
                right.insert(y)
            }
            self = .node(left: left, y, right: right)
        }
    }
}

extension Sequence {
    //方法all检查了一个数组中的元素是否都符合某个条件.它被定为为一个Sequence协议的扩展.
    func all(predicate:(Iterator.Element)->Bool)->Bool  {
        for x in self where !predicate(x) {
            return false
        }
        return true
    }
}


extension String {
    func complete(history:[String])->[String]  {
        return history.filter({$0.hasPrefix(self)})
    }
}

// MARK: - 字典树
struct Trie <Element:Hashable> {
    let isElement :Bool
    let children:[Element:Trie<Element>]
}

extension Trie {
    init() {
        isElement = false
        children = [:]
    }
    
    var elements:[[Element]] {
        var result:[[Element]] = isElement ? [[]]:[]
        for (key,value) in children {
            result += value.elements.map({[key] + $0})
        }
        return result
    }
    
    func lookup(key:ArraySlice<Element>)->Bool  {
        guard let (head,tail) = key.decomposed else {
           return isElement
        }
        guard let subscribe = children[head] else {
            return false
        }
        return subscribe.lookup(key: tail)
    }
}

extension Array {
    var slice:ArraySlice <Element> {
        return ArraySlice(self)
    }
}

extension ArraySlice {
    //之所以为ArraySlice 而不是Array定义decomposed,是因为性能上的原因.
    //Array中的dropFirst方法的复杂度是O(n),而ArraySlice中的dropFirst的复杂度则为O(1),
    //因此,此处的decomposed也只具有O(1)的复杂度.
    var decomposed:(Element,ArraySlice<Element>)? {
        return isEmpty ? nil : (self[startIndex],self.dropFirst())
    }
}



class SWOnlyFunctionTypeVC: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Swift纯函数式结构"
        listArray.append("BinaryTreeSearch")
        listArray.append("AutoCompleteWithDictionaryTree")
        view.addSubview(tableView)
        tableView.reloadData()
    }
    
    // MARK: - BinaryTreeSearch 二叉树搜索
    @objc  func BinaryTreeSearch()  {
        //Binary Search Trees (二叉搜索树)
        //BinarySearchTree 定义规定了每一颗数
        //一个没有关联值的叶子leaf,要么是一个带有三个关联值的结点node,关联值分别是左子树,存储在该节点的值有右子树.
        
        let leaf:BinarySearchTree <Int> = .leaf
        let five:BinarySearchTree <Int> = .node(left: leaf, 5, right: leaf)
        //leaf树是空的;five树在节点上存储了值5,但两颗子树都是空.我们可以编写两个构造方法来生成这种树:
        //一个会创建一棵空树,而另一个则创建含有某个单独值的数:
        
        //count属性与elements非常相似.对于leaf的情况,会有一个基础值.而在node的情况下,它将递归地调用子节点,然后将结果
        //与当前节点中的元素合并起来.这个被抽象出来的过程,有时候被称作fold,或reduce:
        
        //现在,我们利用属性结构编写一个高效的无序集合库.对于检查一棵树是否为空,有一个现成的方案.
        //参照:isEmpty 属性
        
        //2.如果一棵(非空)树符合以下几点,就可以被视为一棵二叉搜索树
        /*
         2.1 所有存储在左子树的值都小于其根结点的值.
         2.2 所有存储在右子树的值都大于其根结点的值
         2.3 其左右子树都是二叉搜索树
         */
        //现在可以编写一个(低效率)属性来检查BinarySearchTree 实际上是不是一棵二叉搜索树.
        //二叉搜索树的关键在于它们支持高效的查找操作,类似于在一个数组中做二分查找.当我们需要遍历一棵树类查找某个元素
        //是否在树种时,我们可以在每一步都排除一半元素.
        
        //例如:写一个contains函数来,来查找一个元素是否在树中:
        //contains 函数现在被分为四种可能的情况:
        /*
         1.如果树是空的,则X不再树中,返回false
         2.如果树不为空,则存储在根结点的值与X相等,返回true
         3.如果树不为空,且存储在根结点的值大于x,那么如果X在树种的话,它一定是在左子树中,所以我们在左子树中递归搜索x
         4.类似地,如果根结点的值小于x,我们就在右子树中继续搜索.
         */
        
        //同样,插入操作也是用同样的方式对二叉树进行搜索:
    }
    
    // MARK: - AutoCompleteWithDictionaryTree 基于字典树的自动补全
    @objc  func AutoCompleteWithDictionaryTree()  {
        /* 我们现在需要自己实现一个自动补全算法---在给定一组搜索的历史记录和一个现在待搜索字符串的前缀时,
         计算出一个与之相匹配的补全列表.
         
         很遗憾,这个函数依旧不是很高效.在历史记录很多,或者是前缀很长的情况下,运算会慢的离谱.此时,运用到一个专门用于解决类似检索
         问题的自定义数据结构.
         
         字典树(tries),也被称为数字搜索树(digitial search trees),是一种特定类型的有序树,通常被用于
         搜索由一连串字符串组成的字符串.不同于一组字符串存储在一棵二叉树中,字典树把构成这些字符窜的字符逐渐分解开来,
         存储在了一个更高效的数据结构中.
         
         上文中,BinarySearchTree 类型的每个节点处都存在两棵子树.对于字典树来说,则是每一个字符串都(潜在地)对应着一棵子树,不过也
         因此,其每个节点的子树个数都是不确定的.
         
         */
        
        //为了区分这些前缀是不是也作为一个元素储存在字典树中,我们会在每个节点添加一个额外的布尔值isElement.这个布尔值会
        //标记截止于当前节点的字符串是否在树中.此外,可以定义一棵泛型字典树,去掉只能存储字符的限制.
        //1.简单的定义
        //2.定义一个属性,用于将字典树展平(flatten)为一个包含全部元素的数组:
        
        //比如,我们可以抛开for循环或者reduce函数,而是用decompose函数递归地对一个数组的元素求和:
        func sum(_ integers:ArraySlice<Int>)->Int  {
            guard let (head,tail) = integers.decomposed  else {
                return 0
            }
            return head + sum(tail)
        }
        printLog(sum([1,2,3,4,5].slice))
        
        //现在可以使用ArraySlice 的辅助方法decomposed 来为数组切片编写一个查询函数:给定一个由一些Element组成的键组,遍历
        //一棵字典树,来逐一确定对应的键是否存储在树种:
        //参照:lookup(_:) 函数
        //查询可以被分为三种情况:
        /*
         1.键组是一个空数组--在这种情况下,我们返回当前节点的isElement,即字典树中用于描述这个字符串是否存在于
         树种的布尔值.
         2.键组不为空,但是不存在对应的子树,在这种情况下,我们返回flase就可以了,因为字典树中没有存储这个键组.
         3.键组不为空,在这种情况下,我们会查询键组中第一个键对应的子树.如果子树存在,我们就递归地调用该函数,
         来查询剩余的键是否在这棵子树中.
         */
        
        
    }
    
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
    
    
    
}

