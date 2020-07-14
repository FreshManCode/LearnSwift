//
//  SWOperatorViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/6/16.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWOperatorViewController: SWBaseViewController, TestProtocol {
    
//    let maxWidth :CGFloat = CGFloat(UIScreen.main.bounds.size.width);
//    let maxHeight:CGFloat = CGFloat(UIScreen.main.bounds.size.height);
    let buttonWidth:CGFloat  = 200;
    let buttonHeight:CGFloat = 30;
    
    let doString = "Dog!!🐶"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "运算符";
        self.p_initUI();
        self.p_StringsAndCharactersChapter();
    }
    
    
    func p_initUI() -> Void {
        let rangeButton = self.createButton(title: "范围运算符", selector: #selector(rangeEvent));
        self.view.addSubview(rangeButton);
        rangeButton.frame = .init(x: (maxWidth - buttonWidth)/2.0, y: 100, width: buttonWidth, height: buttonHeight);
        
    }
    
    // MARK: - Strings and Characters
    func p_StringsAndCharactersChapter() -> Void {
        //1.String Literals (字符串字面量)
        let someStr = "Some string literal value"
        
        //2.Multiline String Litersal 多行字符串字面量
        let quotation = """
The Whiete Rabbit on his spectacles."Where shall I begin,please your mejesty?"he asked.
"Begin at he beginning,"the king said gravely,"and go on till you come to the end;then stop."
"""
        print(quotation);
        
        let softWrappedQuotation =  """
        The White Rabbit put on his spectacles.  "Where shall I begin, \
        please your Majesty?" he asked.

        "Begin at the beginning," the King said gravely, "and go on \
        till you come to the end; then stop."

        """
        print(softWrappedQuotation);
        
        let rangeButton = self.createButton(title: "特殊运算符", selector: #selector(specialOperatorEvent));
        self.view.addSubview(rangeButton);
        rangeButton.frame = .init(x: (maxWidth - buttonWidth)/2.0, y: 100 + buttonHeight * self.scale(index: 1), width: buttonWidth, height: buttonHeight);
        
        let extendedStringDelimitersButton = self.createButton(title: "长字符串分割", selector: #selector(extendedStringDelimitersEvent));
        self.view.addSubview(extendedStringDelimitersButton);
        extendedStringDelimitersButton.frame = .init(x: (maxWidth - buttonWidth)/2.0, y: 100 + buttonHeight * self.scale(index: 2), width: buttonWidth, height: buttonHeight);
        
        let charButton = self.createButton(title: "字符", selector: #selector(workingWithCharactersEvent));
        self.view.addSubview(charButton);
        charButton.frame = .init(x: (maxWidth - buttonWidth)/2.0, y: 100 + buttonHeight * self.scale(index: 3), width: buttonWidth, height: buttonHeight);
        
        let stringInterpolationButton = self.createButton(title: "字符串插值", selector: #selector(stringInterpolationButtonEvent));
        self.view.addSubview(stringInterpolationButton);
        stringInterpolationButton.frame = .init(x: (maxWidth - buttonWidth)/2.0, y: 100 + buttonHeight * self.scale(index: 4), width: buttonWidth, height: buttonHeight);
        
        let countingCharactersButton = self.createButton(title: "计算字符的个数", selector: #selector(countingCharactersButtonEvent));
        self.view.addSubview(countingCharactersButton);
        countingCharactersButton.frame = .init(x: (maxWidth - buttonWidth)/2.0, y: 100 + buttonHeight * self.scale(index: 5), width: buttonWidth, height: buttonHeight);
        
        let substringsButton = self.createButton(title: "子字符串", selector: #selector(substringsButtonEvent));
        self.view.addSubview(substringsButton);
        substringsButton.frame = .init(x: (maxWidth - buttonWidth)/2.0, y: 100 + buttonHeight * self.scale(index: 6), width: buttonWidth, height: buttonHeight);
        
        let differentRepresentationButton = self.createButton(title: "子字符串的不同表示", selector: #selector(differentRepresentationButtonEvent));
        self.view.addSubview(differentRepresentationButton);
        differentRepresentationButton.frame = .init(x: (maxWidth - buttonWidth)/2.0, y: 100 + buttonHeight * self.scale(index: 7), width: buttonWidth, height: buttonHeight);
        
        let collectionTypesButton = self.createButton(title: "集合类型", selector: #selector(collectionTypesButtonEvent));
        self.view.addSubview(collectionTypesButton);
        collectionTypesButton.frame = .init(x: (maxWidth - buttonWidth)/2.0, y: 100 + buttonHeight * self.scale(index: 8), width: buttonWidth, height: buttonHeight);
        
        let controlFlowButton = self.createButton(title: "控制流", selector: #selector(controlFlowButtonEvent));
        self.view.addSubview(controlFlowButton);
        controlFlowButton.frame = .init(x: (maxWidth - buttonWidth)/2.0, y: 100 + buttonHeight * self.scale(index: 9), width: buttonWidth, height: buttonHeight);
        
    }
    
    
    @objc func rangeEvent()  {
        // MARK: - Closed Range Operator
        /*
         封闭范围运算符 a...b 定义了一个从a到b的范围,并且包含a和b;a的值必须要小于b的值
         如下实例:快速迭代一个范围使用for - in 循环
         */
        for index in 1...5 {
            print("index is\(index)")
        }
        
        // MARK: - Half-Open Range Operator 半开放范围运算符
        /**
         半开放范围运算符描述了一个从a到b的范围,但是不包含b;之说以称为半开放是因为它仅仅包含第一个值,不包含最终值,在这个元素符中,a一定不能大于b;如果a等于b,最终的结果为空;当你用到以0为起点的集合序列时,半开放运算符就很有用;
         如下事例:
         */
        let names = ["Anna","Alex","Brain","Jack"];
        let count = names.count;
        for i in 0..<count {
            print("Person\(i+1) is called\(names[i])")
        }
        
        // MARK: - One-Sides Ranges 一边范围
        /*  例如一个包含了索引从2开始一直到数组结束的范围,如下:
         */
        //name is:Brain
        //name is:Jack
        for name in names[2...] {
            print("name is:\(name)")
        }
        //Anna
        //Alex
        //Brain
        for name in names[...2] {
            print(name);
        }
        
        //半开放范围运算符也有这种形式
        //Anna
        //Alex
        for name in names[..<2] {
            print("\(name)")
        }
        /* 一边范围运算符可以用在不使用下标的其他语境;不应该在使用一边范围运算符的时候舍弃初始值,这样会导致从哪里开始迭代不明确
         */
    }
    
    
    // MARK: - 特殊运算符
    @objc func specialOperatorEvent() {
        //"Imagation is more important thnk knowlwdge"-Einstein
        let wiseWords = "\"Imagation is more important thnk knowlwdge\"-Einstein"
        //$
        let dollasSign = "\u{24}"
        //♥
        let blackHear = "\u{2665}"
        //💖
        let sparklingHear = "\u{1F496}"
        
        print("\(wiseWords)\n\(dollasSign)\n\(blackHear)\n\(sparklingHear)");
    }
    
    // MARK: Extended String Delimiters - 长字符串分割
    @objc func extendedStringDelimitersEvent() {
        /* 可以使用长字符分割在一个字符串中包含特殊的符号,但是却不涉及它们的影响.通过使用#".例如:
         #"Lien 1\n Line 2 "# 直接打印出\n,而不是自动换行为两行.
         */
        let testStr = #"Lien 1\n Line 2 "#
        //Lien 1\n Line 2
        print(testStr);
        
        //如果需要特殊字符的功能,需要让\之后的#的个数与字符串的相匹配如下:
        //        Line 1
        //        Line2
        let test2 = #"Line 1\#nLine2"#
        //也等同于下
        //        Line 1
        //        Line2
        let test3 = ###"Line 1\###nLine2"###
        print("\(test2)\n\(test3)")
        
        // MARK: Initializing an Empty String - 初始化一个空字符符传
        var emptryStr = ""
        var anotherEmptyString = String()
        
        if emptryStr == anotherEmptyString {
            print("这两个都是空字符串相等")
        } else {
            print("这两个字符串并不相等哦")
        }
        //这两个都是空字符串相等
        //通过isEmpty属性来判断一个字符串是不是空字符串
        //print("这是一个空字符串")
        if emptryStr.isEmpty {
            print("这是一个空字符串")
        }
        
        //3.(String Mutability) 字符串变量
        //通过使用var来描述一个字符串是否可变,let表述该支付串是一个常量
        var variableString = "Horse"
        variableString += "and carriage"
        
        let constString = "Highlander"
        //        会报编译错误,let声明的字符串是常量,不允许修改
        //        constString += "and another Highlander"
        
        //注意:这和OC中的可变string类型不同,在OC中使用NSString/NSMutableString来描述一个字符串是否可变
        
        
        //4.Strings Are Value Types(字符串是值类型)
        /**
         Swift中的string类型是一个值类型;如果你创建了一个字符穿,当它在函数或者方法中传递的时候,其实是它copy副本,并不是最初的string.
         
         Swift中的 默认传递的copy副本可以确保当一个函数传递字符串值的时候,你能清楚地知道字符串的值,不管它从哪来.你可以确保除非你自己修改
         它的值,否则在传递的过程中是不会变的.
         
         */
    }
    
    // MARK: - Wokring with Characters (使用字符工作)
    @objc func workingWithCharactersEvent() {
        //1.可以通过使用for..in 循环来获取字符串中的每个字符
        for character in "Dog!🐶" {
            print(character);
        }
        //逐一输出每个字符
        
        //2.或者使用一个单一的字符常量或者变量从一个提供Character类型的语法:
        let excalmationMark: Character = "!"
        
        //可以通过一系列的字符类型类组合成一个字符串烈性
        let catCharacters : [Character] = ["C","a","t"];
        let catString = String(catCharacters)
        print(catString)
        //Cat
        
        //3.Concatenating Strings and Characters (连接字符串或者字符)
        //字符串可以通过加号运算符来生成一个新的字符串
        let string1 = "hello"
        let string2 = " there"
        var welcome = string1 + string2
        //hello there
        print(welcome)
        
        //也可以使用+=对于一个已经存在的字符串操作
        welcome += "yes ok"
        //hello there yes ok
        
        //4.可以通过使用String类型的append()方法来添加一个字符
        let mark:Character = "!"
        welcome.append(mark)
        
        //注意:一定不能给一个已经存在的Character变量通过append()方法来添加字符或者字符串,因为一个字符值必须是包含一个单一的字符.
    }
    
    // MARK: String Interpolation - 字符串插值
    @objc func stringInterpolationButtonEvent()  {
        /* 字符串插值是一种通过许多变量,常量,字符或者表达值式的值构建一个新的字符串的方法.在想插入的条目中使用\()中包含需要的字符串字面量.
         */
        let multiplier = 3
        let message = "\(multiplier) times 2.5 is\(Double(multiplier) * 2.5)"
        //3 times 2.5 is 7.5
        print(message);
        
        // MARK: - Unicode Scalar Values (Unicode 标量值)
        let a = "\u{0061}"
        let chick = "\u{1F425}"
        //a
        //🐥
        print("\(a)\n\(chick)")
        
        // MARK: - Extended Grapheme Clusters (扩展字符集)
        /*
         Swift的每种字符类型实例都代表了一个单独的扩展字符集.一个扩展的字符集是由一个或者多个连续Unicode标量组成的,然后组合成人
         类可读的字符.
         */
        ///é
        let aAcute : Character = "\u{E9}"
        //é
        let combineEacute : Character = "\u{65}\u{301}"
        print("\(aAcute)\n \(combineEacute)")
        
        //2.扩展字符集灵活运用可以表示许多复杂的字符下标作为一个单一的字符值.如下:
        //使用扩展字符集来包围一个字符值:
        let enclosedEAcute : Character = "\u{E9}\u{20DD}"
        //é⃝
        print(enclosedEAcute);
        
        let enclosedEAcute2 : Character = "李\u{20DD}"
        //李⃝
        print(enclosedEAcute2);
        
        //3.Unicode标量值可以成对组合成一个单一的字符来表示区域的符号,如下:
        let regionalIndicatorForUS : Character = "\u{1F1FA}\u{1F1F8}"
        //🇺🇸
        print(regionalIndicatorForUS);
    }
    
    // MARK: - Counting Characters 计算字符个数
    @objc func countingCharactersButtonEvent() {
        //1.可以使用count属性来计算一个string中的字符个数,如下:
        let unusalMessage = "Koala,Snail,Dog 🐶"
        //unusalMessage has 17 characters
        print("unusalMessage has \(unusalMessage.count) characters")
        //注意:因为Swift使用扩展字符集来表示字符,也就意味着字符串的粘贴或者修改有可能不影响字符串中字符的个数
        
        //例如:使用一个四个字符的cafe来初始化一个字符串,然后在字符串的尾部拼接一个(U+0301)的字符,字符串的字符个数的结果仍然是4,
        //但是第四个字符是é ,而不是e
        var word = "cafe"
        //the number of characters incafe is 4
        print("the number of characters in\(word) is \(word.count)");
        
        word += "\u{301}"
        //the number of characters incafé is 4
        print("the number of characters in\(word) is \(word.count)");
        /* 注意:
         扩展字符集可以由多个Unicode标量组成.这意味着,不同的字符甚至是相同字符的不同组成形式需要不同的存储空间.因此,在Swift中表示
         字符串的每个字符需要不同的存储空间.这就导致了,在一个字符串中的字符无法计算如果没有通过遍历字符串用来确定扩展字符集的边界.
         如果你处理的字符串特别长,请确保count属性一定是遍历了该字符串的所有unicode标量,用来决定该字符串的字符.
         **/
        
        // MARK: - Accessing and modifying a String
        //可以通过方法或者属性或者使用下标语法来获取修改一个字符串.
        
        //String Indices (字符串索引)
        //每个字符串的值都有一个相关联的索引类型,String.Index,也就是对应着该字符串位置中的字符.
        //使用startIndex属性获取该字符串中的第一个字符.endIndex属性是该字符串中最后一个字符的位置.因此,对于字符串下标来说
        //endIndex属性是一个无效的参数.如果是一个空字符串,startIndex和endIndex相同.
        //使用下标语法获取字符串中指定索引的字符
        let greeting = "Guten Tag!"
        
        print(greeting[greeting.startIndex]);
        //G
        print(greeting[greeting.index(before: greeting.endIndex)]);
        //!
        print(greeting[greeting.index(after: greeting.startIndex)]);
        //u
        let index = greeting.index(greeting.startIndex, offsetBy: 7);
        print(greeting[index])
        //a
        
        //注意:如果尝试获取一个字符串范围之外的索引字符,会抛出一个运行时错误.
        //使用indics属性获取字符串中所有对应索引的字符
        for index in greeting.indices {
            print("\(greeting[index]) ",terminator:"");
        }
        //G u t e n   T a g !
        //注意:任何遵循Collection 协议的类型都可以使用startIndex,endIndex,index(before:),index(after:)
        //等方法.这包含的类型有数组,字典和集合.
        
        
        // MARK: - Inserting and Removing (插入和删除)
        //使用insert(_:at:)方法来插入一个单独的字符,使用insert(contentOf:at:)方法在指定索引插入一段内容
        var welcome = "hello"
        welcome.insert("!", at: welcome.endIndex)
        //hello!
        
        welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
        //hello there!
        
        //2.使用remove(at:)方法移除一个字符串中特定位置的字符;使用removeSubrange:(_:)方法来删除一定范围的子串.
        welcome.remove(at: welcome.index(before: welcome.endIndex));
        //hello there
        
        let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
        welcome.removeSubrange(range)
        //hello
        //注意:任何遵循了RangeReplaceableCollection协议的类型,都 可以使用insert(_:at:),insert(contentOf:at:),remove(at:)以及removeSubrange(_:)方法.
        //这包括,String,Array,Dictionary以及Set
    }
    
    // MARK: - Substrings 子字符串
    @objc func substringsButtonEvent() {
        /* 当你使用下标或者类似于prefix(_:)的方法从一个字符串中获得一个子串,这个子串就是Substring的实例,不是一个string.
         Swift中子串和字符串都很多相同的方法,可以按照处理字符串的方法那样来处理子串.
         
         然而与字符串不同的是,当你在一个字符串上操作一个子串时,子串的使用时间很短.如果你想要长时间存储子串的结果,需要把
         子串转换为字符串的实例.如下:
         */
        let greeting = "Hello,wordld!"
        let index = greeting.firstIndex(of: ",") ?? greeting.endIndex;
        let beginning = greeting[..<index];
        //把结果转换为String类型用以长期存储
        let newString = String(beginning);
        print(newString);
        //Hello
        /* 像字符串一样,每个子字符串都是由储在内存区域中的字符组成的子串.二者之间的区别在于,性能上的优化.子字符串可以重用一部分原始
         字符串的内存区域或者存储其它字符串的内存区域.字符串有类似的优化,但是如果两个字符串共享内存区域,他们是等价的.
         这种性能优化意味着你不用关注在修改字符串或者字符串时的性能消耗.就像上面说的那样,因为子字符串重用原始字符串的存储空间,所以
         不适合长时间存储.只要它的字符串被使用,整个原始字符串必须保存在内存中.
         */
        
        // MARK: - Comparing Strings 字符串比较
        //Swift提供了三种比较文本值的方法:字符串和字符相等,前缀和后置相等
        
        //1.String and Character Equality
        //使用"=="操作符来比较字符串和字符是否相等,使用"!="操作符来判定不相等
        let qutation = "We're a lot alike,you and I."
        let sameQutation = "We're a lot alike,you and I."
        if qutation == sameQutation {
            print("These two strings are considered equal")
        }
        //These two strings are considered equal
        /* 如果两个字符串/两个字符的扩展字符集在规范上是相等的,那么就认为相等.如果它们有相同的语义和外观,即使它们背后由不同的
         Unicode标量组成,扩展字符集也是规范相等的.
         
         如下事例是由不同的Unicode标量组成:
         */
        let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
        let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
        
        //These two strings are considered equal!
        if eAcuteQuestion == combinedEAcuteQuestion {
            print("These two strings are considered equal!")
        }
        
        //相反,拉丁文中的"A",U+0041和俄语中的"A",U+0410 是不相等的.字符看起来一样,但是没有相同的语言含义
        let latinCA : Character = "\u{41}"
        let russiaA : Character = "\u{0410}"
        //These two strings are not equaliant!
        if latinCA != russiaA {
            print("\(latinCA) and \(russiaA) These two strings are not equaliant!")
        }
        
        //2.Prefix and suffix Equality
        //为了检查一个字符串是否有一个前缀或者后置的字符串,调用hasPrefix(_:)和hasSuffix(_:)方法,
        //这两个方法均需要一个字符串类型的参数,并且返回一个bool值
        
        let romeoAndJuliet = [
            "Act 1 Scene 1: Verona, A public place",
            "Act 1 Scene 2: Capulet's mansion",
            "Act 1 Scene 3: A room in Capulet's mansion",
            "Act 1 Scene 4: A street outside Capulet's mansion",
            "Act 1 Scene 5: The Great Hall in Capulet's mansion",
            "Act 2 Scene 1: Outside Capulet's mansion",
            "Act 2 Scene 2: Capulet's orchard",
            "Act 2 Scene 3: Outside Friar Lawrence's cell",
            "Act 2 Scene 4: A street in Verona",
            "Act 2 Scene 5: Capulet's mansion",
            "Act 2 Scene 6: Friar Lawrence's cell"
        ]
        
        var act1SceneCount = 0
        for scene in romeoAndJuliet {
            if scene.hasPrefix("Act 1") {
                act1SceneCount += 1
            }
        }
        //There are 5 scenes in Act 1
        print("There are \(act1SceneCount) scenes in Act 1")
    }
    
    @objc func differentRepresentationButtonEvent() {
        self.navigationController?.pushViewController(SWDifferentRepresentationVC.init(), animated: true);
    }
    
    @objc func collectionTypesButtonEvent() {
        self.navigationController?.pushViewController(SWCollectionTypesViewController.init(), animated: true);
    }
    
    @objc func controlFlowButtonEvent() {
        let controlFlowVC = SWControlFlowViewController.init()
        controlFlowVC.delegate = self;
        //无参数的block
        controlFlowVC.BlockCall = {
            print("This is no parameter block")
        }
        //有参数的Block
        controlFlowVC.blockTwo = { (parm) in
            print("This is Block with parameter :\(parm) ")
        }
        
        self.navigationController?.pushViewController(controlFlowVC, animated: true);
    }
    
    
    func createButton(title:String,selector:Selector) -> UIButton {
        let tempButton = UIButton.init(type:.custom);
        tempButton.setTitle(title, for: UIControl.State.normal);
        tempButton.backgroundColor = .red;
        tempButton.titleLabel?.font = UIFont.init(name: "Regular", size: 15);
        tempButton.addTarget(self, action:selector , for: .touchUpInside)
        self.view.addSubview(tempButton);
        return tempButton;
    }
    
    func getBottom(view:UIView) -> CGFloat {
        return view.frame.origin.y + view.frame.size.height;
    }
    
    func scale(index:Int) -> CGFloat {
        return CGFloat(Double(index) * 1.2);
    }
    
    // MARK: - TestProtocol
    func ClickSwitchStatements() {
        print("我点击了Switch语句哈哈")
    }

}
