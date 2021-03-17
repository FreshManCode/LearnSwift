//
//  SWCollectionTypesViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/6/18.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWCollectionTypesViewController: SWBaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "容器类型";
        self.p_initDefaultData();
    }
    
    func p_initDefaultData() -> Void {
        /*1. 在Swift中有3种用来储值的基本的容器类型,分别是:数组,集合和字典.
         集合是无序且有唯一值的容器;
         字典是用键值对来关联起来的无序容器;
         
         Swift中的数组,字典,集合对于能存储什么样的数据类型是清楚的.也就是说你可能往一个容器中插入一个错误的类型.
         这样也能确保一个集合遍历的正确性.
         */
        
        /* 2.Mutability of Collections (容器的可变性)
         如果在创建容器类型的时候,其实例是一个变量,那么该容器是可变的,也就是,可以对该容器进行增加,删除,修改操作.如果容器的实例是一个
         let修饰的常量,该容器就是不可变的,其大小和内容都无法改变.
         
         注意:建议把容器类型声明为可变的类型,及时在某些情况下不需要改变.这样可以使代码更易理解,并且Swift的编译器能对写的代码进行
         性能上的优化.
         */
        
        
        self.view.addSubview(self.tableView);
        listArray.append("Arrays");
        listArray.append("IteratingOverAnArray");
        listArray.append("Sets");
        listArray.append("Dictionaries");
        listArray.append("IteratingOverADictionaries");
//        listArray.append("UTF16Representation");
//        listArray.append("UnicodeScalarRepresentation");
        self.tableView.reloadData();
    }
    
    // MARK: - Arrays
    @objc func Arrays() {
        /* Arrays (数组)
         数组有序的存储一些列相同类型的值.同一个值可以在数组中的不同位置出现.
         Swift中的Array类型可以与Foundation中的NSArray类进行桥接.
         */
        /*1.Array Type Shorthand Syntax (数组类型的简写形式)
         数组的完整类型如下:Array<Element>,其中Element是数组要存储的数据类型;也可以通过如下的简写方法来表示一个数组:
         [Element].虽然两种形式功能上是相同的,但是简写形式更容易让人喜欢,并且本文都是简写形式,当涉及到数组类型的时候;
         */
        //1.1创建一个空数组
        var someInts = [Int]()
        print("someInts is of type [Int] with\(someInts.count) items.")
        
        //1.2 另外,如果上下文已经提供了类型信息,比如一个函数的参数或者一个已经声明的常量/变量,我们可以通过字面量语法来创建一个空数组
        //,创建空数组的方法如:[]
        someInts.append(3)
        someInts = []
        //someInts 现在虽然是空数组,但是其类型仍然是[Int]
        
        //2.Creating an Array with a Default Value (创建一个带默认值的数组)
        //Swift数组提供了一个创建指定数量相同默认值的初始化方法.通过传递一个合适类型的默认值,以及数组中的个数:
        var threeDoubles = Array.init(repeating: 0.0, count: 3);
        //现在 threeDoubles 是[Double],并且等于 [0.0,0.0,0.0]
        
        //3.Creating an Array by adding two arrays together(通过把两个数组合并到一起来创建一个新数组)
        //可以把两个有相同类型数组的数组使用"+"运算符来创建一个新数组.新的数据类型和操作的两个数组的类型相同]
        var anotherThreeDouble = Array.init(repeating: 2.5, count: 3)
        
        var sixDoubles = threeDoubles + anotherThreeDouble
        print("sixDoubles is:\(sixDoubles)")
        
        //4.Creating an array with an array literal (使用数组字面量来创建数组)
        //可以使用数组字面量方法来初始化数组,是一个通过填入一个或者多个值作为一个数组容器的简写方法.其中的值,通过","分隔开.
        var shoppingList:[String] = ["Egg","Milk"]
        //由于Swift的类型检查机制,如果你初始化数组的时候,使用的初始值有相同的类型,比用声明数组的类型
        var newShoppingList = ["Egg","Milk"]
        
        
        //5.Accessing and modifying an Array (访问和修改数组)
        //通过属性或者方法来访问或者修改数组,也可以通过下标语法:
        
        //5.1 使用可读count的属性来获得数组中的条目数
        print("the soppingList contains\(newShoppingList.count) items");
        
        //使用isEmpty属性来区别count是不是为0
        if newShoppingList.isEmpty {
            print("newShoppingList is a empty array")
        } else {
            print("newShoppingList is a valid array")
        }
        //5.2 使用append(_:)方法来往数组的尾部添加元素
        newShoppingList.append("Pear")
        //另外,也可以使用+= 操作符来添加包含一个或者多个元素的数组
        newShoppingList += ["Apple",]
        newShoppingList += ["Orange","Cheese","Juice"]
        
        //5.3通过使用下标语法来获取你想获取数组中对应索引的值.
        var firstItem = shoppingList[0];
        //Egg
        //也可以通过下标语法来修改制定索引的数组中对应位置的值
        newShoppingList[0] = "Two eggs"
        
        //5.4 也可以使用下标语法来立即改变一个范围的值,即使取代的值与被取代的值有不同的范围.如下事例:
        newShoppingList[4...6] = ["Bananas","Apples"]
        //["Two eggs", "Milk", "Pear", "Apple", "Bananas", "Apples"]
        print("\(newShoppingList)");
        
        //5.4 在Arrary中的指定位置插入值,调用数组的insert(_:at:)方法;
        shoppingList.insert("Inset", at: 0)
        
        //5.5 使用remove(at:)方法来移除指定索引的元素.该方法移除指定位置的元素,并且返回移除的元素.
    }
    
    @objc func IteratingOverAnArray() {
        /* Iterating Over an array (数组的遍历)
         */
        //1.可以使用for循环来遍历数组
        var newShoppingList = ["Orange","Cheese","Juice"]
        for item in newShoppingList {
            print("item is:\(item)")
        }
        
        
        //2.如果想在遍历元素的同时获取对应值的索引,使用enumerated()方法来遍历数组.该方法对于数组中的每个元素而言,返回了一个包含
        //整数和元素的一个元素.整数从0开始,每次遍历一个元素.
        for (index,value) in newShoppingList.enumerated() {
            print("index is:\(index) value is:\(value)")
        }
    }
    
    
    // MARK: - Sets
    @objc func Sets() {
        /* 集合容器以一个无序的状态存储了相同类型不同的值.当对于元素的顺序无要求时,可以使用集合代替,
         或者需要确保一个元素仅仅只能出现一次时,也可以使用集合.
         可以和Foundation中的NSSet进行桥接.
         
         Hash Values for Set Types (集合存储类型的Hash值)
         存储在集合中的类型,必须是可哈希化的,因为类型提供了一个计算本身hash值的方法.
         Hash值是一个整数,对于所有的对象来说,如果它们比较是相等的,那么两者的哈希值相等.比如:
         a==b,那么a.hashValue == b.hashValue.
         
         Swift中的基本类型(String,Int,Double,Bool)默认都是可哈希化的.可以用来储值或者作为字典的key类型.
         */
        
        /* Set Type Syntax (集合类型语法)
         集合类型的语法如下:Set<Element>,其中表示存储的类型.和数组不同的是,集合没有等价的简写形式
         */
        //1.创建和初始化一个空集合
        var letters = Set<Character>();
        
        //2.使用数组的字面量来创建一个字典
        var favoriteGenres : Set<String> = ["Rock","Classical","Hip hop"];
        
        //注意:一个集合的存储类型并不能从一个字面量数组推算出来,因此,集合必须显示声明存储类型.
        //然而,因为Swift的类型推断功能,如果你使用数组初始化的时候,数组的元素的类型都相同,没有必要指明Set的类型.
        //上例可以按照下面来写:
        var newFavoriteGenres : Set = ["Rock","Classical","Hip hop"]
        //因为数组中的数据都是同一种String类型,所以可以正确推断出newFavoriteGenres变量的存储类型.
        
        //3.(Accessing and Modifying a Set) 访问和修改集合
        //3.1 可以通过其属性和方法来访问/修改集合,使用count属性来获取集合包含了多少元素
        print("favoriteGenres contain \(favoriteGenres) items")
        
        //3.2 使用isEmpty属性来检查count是否为0
        if favoriteGenres.isEmpty {
            print("这是一个空集合")
        } else {
            print("这不是一个空集合")
        }
        
        //3.3 使用insert(_:)方法来往一个集合中增加元素,使用remove(_:)方法来删除集合中的元素,并且返回值为删除的元素
        //使用removeAll()方法删除所有的元素
        favoriteGenres.insert("Jazz")
        
        if let removedGenre = favoriteGenres.remove("Rock") {
            print("\(removedGenre)? I'm over it.")
        } else {
            print("I never much cared for that.")
        }
        
        //3.4 使用contains(_:)方法来检查是否包含指定的元素
        if favoriteGenres.contains("Funk") {
            print("I get up on the good foot.")
        } else {
            print("It's to funky in here.")
        }
        
        

        //4.Iteraing Over a Set (集合的遍历)
        //4.1 使用for-in 循环来遍历集合
        for item in favoriteGenres {
            print("item is:\(item)")
        }
        
        //4.2 Swift的集合遍历没有特定的顺序,如果想指定遍历的顺序,使用sorted()方法,该方法返回一个有序的array
        for item in favoriteGenres.sorted() {
            print("item is:\(item)")
        }
        
        //5.Preforming Set Operations (执行集合操作)
        //可以高效率的执行集合的基本操作,例如把两个集合整合到一起,查看两个集合是否有相同的值,或者两个集合包含的值是否相等...
        //5.1 Fundamental Set Options (集合的基本操作),如下事例,集合a和集合b执行相关的基本集合操作
        let a : Set = [1,2,3,4,5,6,7]
        let b : Set = [1,3,5,7,9,10,8]
        
        //a.intersection(b),集合a与集合b的交集
        let intersection = a.intersection(b);
        print("intersection is:\(intersection)")
        //intersection is:[7, 1, 5, 3]
        
        //a.symmetricDifference(b) 除了a与b交集之外的元素
        let difference = a.symmetricDifference(b);
        print("difference is:\(difference)")
        //difference is:[6, 9, 2, 4, 10, 8]
        
        //a.union(b) a与b的并集
        let union = a.union(b);
        print("union is:\(union)")
        //union is:[6, 1, 9, 2, 4, 5, 7, 3, 10, 8]
        
        //a.subtracting(b) 集合a中不包含集合b中的元素
        let subtracting = a.subtracting(b);
        print("subtracting is:\(subtracting)")
        //subtracting is:[6, 2, 4]
    }
    
    // MARK: - Dictionaries 字典
    @objc func Dictionaries() {
        //1.Dictionary Type Shorthand Syntax
        //Swift中字典的完整写法是Dictionary<Key,Value>,其中key是可以在字典中作为键的值,value是字典中用来保存对应键的值
        //注意:字典的键必须遵循了Hashbale协议,像字典的value一样
        //可以简写字典形式为[Key:Value],两种方法的功能是一样的,通常我们多使用简写形式;
        
        //2.Creating an Empty Dictionay (创建一个空字典)
        //2.1 可以像Array一样使用初始化方法创建一个包含指定类型key和value的字典,
        var namesOfIntegers = [Int:String]()
        namesOfIntegers[16] = "sixteen"
        
        //2.2 使用字典字面量语法创建一个字典
        //可以像数组那样使用字典字面量语法来创建一个字典.字典字面量语法是一种创建一个或者多个键值对的集合容器的简写方法.
        var airports:[String:String] = ["YYZ":"Toronto Pearson","DUB":"Dublin"]
        
        //2.3 像数组一样,如果你使用字面量语法初始化一个字典,其中所有的key以及value都是同一种类型,可以不用声明字典的相关类型如下:
        let ports = ["acc":"ac","ccd":"dd"]
        
        //2.4 访问以及修改字典
        //和Array一样,字典也有count和isEmpty属性
        
        //2.4.1 使用下标语法来添加新的元素.使用适当类型的key作为下标索引,赋值适当类型的value
        airports["LHR"] = "London"
        
        //2.4.2 也可以使用下标语法来修改与key相关联的值
        airports["LHR"] = "London1"
        
        //2.4.3 也可以使用updateValue(_:forKey:)方法来设置或者更新指定key的value.
        //updateValue(_:forKey:)方法返回该key对应的未修改之前的值,该返回值是一个可选型的值,如果key之前存在就有值,否则就是nil
        if let oldValue = airports.updateValue("Double Airport", forKey: "DUB") {
            print("the old value is :\(oldValue)")
        }
        
        //2.4.4 可以使用下标语法使用key来获取字典中对应的value,因为有可能访问的是一个字典中不存在的key,所以下标语法返回的是一个
        //字典的值类型的一个可选型的值.如果字典中的key存在,那么返回的可选型就包含该key对应的value,否则就是nil
        if let airportName = airports["DUB"] {
            print("The name of the airport is\(airportName)")
        } else {
            print("That airport is not in the airports dictionary")
        }
        
        //2.4.5 可以使用下标语法来出一个键值对,通过把nil赋值给该key对应的value
        airports["APL"] = "Apple International"
        airports["APL"] = nil
        
        //2.4.6 同时也可以使用removeValue(forKey:)方法.如果该key存在则返回删除的value,否则就返回nil
        if let removedValue = airports.removeValue(forKey: "DUB") {
            print("The removed airport's name is \(removedValue)")
        } else {
            print("The airports dictionary does not contain a value for DUB.")
        }
    }
    
    // MARK: - Iterating Over a Dictionary
    @objc func IteratingOverADictionaries() {
        //1.使用for-in 循环来遍历字典,每一个遍历的条目是(key,value)这样形式的一个元组.
        var info = ["name":"Liming","age":"35"]
        info["address"] = "北京"
        
        for (key,value) in info {
            print("key is:\(key) value is:\(value)")
        }
        
        //2.也可以通过遍历字典所有key或者value的集合,来访问它的key或者value
        for key in info.keys {
            let value :String = info[key] ?? "no value"
            print("<keys method>:key is:\(key) value is:\(value)")
        }
        
        for value in info.values {
            print("<values method>:value is:\(value)")
        }
        
    }
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    

    
}
