//
//  SWHomeViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/6/8.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit



class SWHomeViewController: SWBaseViewController {
    
//    let maxWidth :CGFloat = CGFloat(UIScreen.main.bounds.size.width);
//    let maxHeight:CGFloat = CGFloat(UIScreen.main.bounds.size.height);
    let buttonWidth:CGFloat  = 150;
    let buttonHeight:CGFloat = 30;
    var buttonTextArray = Array<String >.init();
    var buttonArray = Array<UIButton >.init();
    var bgView = UIScrollView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.p_initUI();
    }
    
    func p_initUI() -> Void {
        
        self.title = "首页";
        buttonTextArray.append("类型别名");
        buttonTextArray.append("元组");

        
        self.view.addSubview(bgView)
        bgView.frame = CGRect(x: 0, y: 0, width: ScreenW, height: ScreenH - 49 - safaArea)
        
        
        let testButton = self.createButton(title: "类型别名", selector: #selector(typeAliases));
        testButton.frame = .init(x: (maxWidth - buttonWidth)/2.0, y: 100, width: buttonWidth, height: buttonHeight);
        
        let tupleButton = self.createButton(title: "元组", selector: #selector(tupleEelement));
        bgView.addSubview(tupleButton);
        tupleButton.frame = .init(x: (maxWidth - buttonWidth)/2.0,y:self.getBottom(view: testButton)+20 , width: buttonWidth, height: buttonHeight);
        
        let optionalButton = self.createButton(title: "可选型", selector: #selector(optionalButtonEvent(sender:)));
        bgView.addSubview(optionalButton);
        optionalButton.frame = .init(x: (maxWidth - buttonWidth)/2.0,y:self.getBottom(view: tupleButton)+20 , width: buttonWidth, height: buttonHeight);
        
        let optionalBindingButton = self.createButton(title: "可选型绑定", selector: #selector(optionalBindingButtonEvent(sender:)));
        bgView.addSubview(optionalBindingButton);
        optionalBindingButton.frame = .init(x: (maxWidth - buttonWidth)/2.0,y:self.getBottom(view: optionalButton)+20 , width: buttonWidth, height: buttonHeight);
        
        let implicitlyUnwrappButton = self.createButton(title: "隐式解包可选型", selector: #selector(implicitlyUnwrappButton(sender:)));
        bgView.addSubview(implicitlyUnwrappButton);
        implicitlyUnwrappButton.frame = .init(x: (maxWidth - buttonWidth)/2.0,y:self.getBottom(view: optionalBindingButton)+20 , width: buttonWidth, height: buttonHeight);
        
        let errorHandleButton = self.createButton(title: "错误处理", selector: #selector(errorHandleButton(sender:)));
        bgView.addSubview(errorHandleButton);
        errorHandleButton.frame = .init(x: (maxWidth - buttonWidth)/2.0,y:self.getBottom(view: implicitlyUnwrappButton)+20 , width: buttonWidth, height: buttonHeight);
        
        let assertionsAndPredoctions = self.createButton(title: "断言以及先决条件", selector: #selector(assertionsAndPredoctions(sender:)));
        bgView.addSubview(assertionsAndPredoctions);
        assertionsAndPredoctions.frame = .init(x: (maxWidth - buttonWidth)/2.0,y:self.getBottom(view: errorHandleButton)+20 , width: buttonWidth, height: buttonHeight);
        
        let operatorButtons = self.createButton(title: "运算符", selector: #selector(operatorButtonEvent(sender:)));
        bgView.addSubview(operatorButtons);
        operatorButtons.frame = .init(x: (maxWidth - buttonWidth)/2.0,y:self.getBottom(view: assertionsAndPredoctions)+20 , width: buttonWidth, height: buttonHeight);
        
        let loadingButton = self.createButton(title: "Loading", selector: #selector(testLoading));
        bgView.addSubview(loadingButton);
        loadingButton.frame = .init(x: (maxWidth - buttonWidth)/2.0,y:self.getBottom(view: operatorButtons)+20 , width: buttonWidth, height: buttonHeight);
        
        let alamofireButton = self.createButton(title: "Alamofire", selector: #selector(AlamofireStudy));
        bgView.addSubview(alamofireButton);
        alamofireButton.frame = .init(x: (maxWidth - buttonWidth)/2.0,y:self.getBottom(view: loadingButton)+20 , width: buttonWidth, height: buttonHeight);
        
        if alamofireButton.maxY > bgView.height - 50 {
            bgView.contentSize = CGSize(width: 0, height: alamofireButton.maxY + 50)
        }
        
    }
    
    
    /// 类型别名
    /// - Returns: Void
    @objc func typeAliases(){
        /* 类型别名对于一个已经存在的类型提供了一个可选的名字,使用typealias关键词来定义类型别名,
         一旦定义了类型别名,可以在任意地方使用这个别名
         */
        typealias AudioSample = UInt16
        var maxAmplitudeFound = AudioSample.min;
        print("maxAmplitudeFound is:\(maxAmplitudeFound)");
        
        //bool类型
        let orangesAreOrange = true
        if orangesAreOrange {
            print("this is real orange")
        }
        
        //swift 的类型安全机制阻止了在需要bool系列的值的时候使用非布尔系列的值如下:
        //Cannot convert value of type 'Int' to expected condition t
        //        let i = 1
        //        if i {
        //
        //        }
        //
    }
    
    @objc func tupleEelement()  {
        /* tuples 把许多值组合到一起,并且这些值的类型没有必要要相同,
         你可以使用分开的常量或者变量来解包元组,通常如下;
         */
        let  http404Error = (404,"Not Found")
        let (statusCode,StatusMessage) = http404Error;
        print("The status code is\(statusCode),statusMessage is:\(StatusMessage)")
        
        //2.如果你只需要元组中的部分值,忽略的那部分使用_,如下;
        let (justTheStatusCode,_) = http404Error;
        print("The status code is\(justTheStatusCode)")
        
        //3.也可使用索引来访问元组的元素值,index从0开始,
        print("The status code is\(http404Error.0)")
        
        //4.可以在元组定义的时候给元素命名,如果给元组中的元素命名了,可以使用元素名来取值
        let http200Status = (statusCode:200,description:"OK")
        print("The status code is:\(http200Status.statusCode)")
        
        /* 元组在函数返回多个值的时候很有用;
         注意:如果你的数据结构可能很复杂,一个model类或者结构体比元组更适合.
         */
    }
    
    // MARK: - Optionals 可选型
    @objc func optionalButtonEvent(sender:UIButton) {
        print("sender is:\(sender)");
        //下面是一个使用初始化函数把string转为int类型的例子:
        //convertedNumber 现在是一个 Int?类型,或者说是一个Int的可选型
        var possibleNumber   = "123"
        let convertedNumber   = Int(possibleNumber);
        var convertedNumber2  = Int(possibleNumber)!;
        
        //普通可选型 convertedNumber is:Optional(123)
        print("convertedNumber is:\(convertedNumber)");
        //隐式解包可选型 convertedNumber2 is:123
        print("convertedNumber2 is:\(convertedNumber2)");
        
        
        /* 因为初始化函数可能会失败,因此它返回了一个Int的可选型,而不是Int类型.一个Int的可选类型被标记为Int?.
         问号表明该值包含一个可选型,也就是可能有int 值,也可能什么都没有.它不可能包含其它类型的值,像Bool系列或者String系列的.
         要么就是一个Int类型的值,要么什么都没有.
         */
        
        //2.nil 给可选型的类型赋一个特殊的nil值
        /* 注意:不能给一个非可选型的常量或者变量使用nil.如果在执行的过程中有不确定的条件,把它声明为相应类型的可选型变量.
         如果声明了一个没有赋初值的可选类型,变量会自动赋值nil
         */
        var serverResponseCode: Int? = 404;
        print(serverResponseCode)
        serverResponseCode = nil;
        print(serverResponseCode)
        
        var surveyAnswer :String?
        //surveyAnswer is automaically set to nil
        /* 注意:
         Swift中的nil与OC中的nil不一样.在OC中,nil是一个指向不存在对象的指针.在Swift中,nil不是一个指针,其实质是一个确定类型的值,
         一个可能为任何类型的值,不仅仅是对象.
         */
        surveyAnswer = "LiMing";
        //3.if语句以及解包
        //使用if语句与把可选型的常量/变量与nil作比较.可以使用'=='或者'!='运算法.
        if surveyAnswer != nil {
            print("surveyAnswer contains some string value.")
        }
        //一旦可以确定一个可选型包含一个值,就可以通过在其后增加一个!来访问它包含的值.这意味着,这个可选型一定是有值的,使用强制解包.
        //surveyAnswer has an string value of:LiMing
        if surveyAnswer != nil {
            print("surveyAnswer has an string value of:\(surveyAnswer!)")
        }
        //注意:使用"!"进行强制解包的时候,一定要确保该可选型的值不是nil,否则会抛出一个运行时错误.
    }
    
    // MARK: - Optional Binding (可选型绑定)
    @objc func optionalBindingButtonEvent(sender:UIButton) {
        /* 可以使用可选型绑定来区分一个可选型是否有值,这样使得该值成为一个临时的常量或者变量.可选型绑定可以使用if或者while语句
         来检查可选型包含的值,并且把该值解包成一个常量或者变量.如下所示:
         if let constantName = someOptional {
                statements
            }
         使用该语句试着重写上述的例子
         */
        var servery : String? ;
        servery = "李白";
        //servery is a valid string:李白
        if let serveryValue = servery {
            print("servery is a valid string:\(serveryValue)");
        }
        
        //servery is nil
        servery = nil;
        if let serveryValue = servery {
            print("servery is a valid string:\(serveryValue)");
        } else {
            print("servery is nil")
        }
        
        servery = "李白"
        
        //声明为var类型,该可选型包含值的时候,可以对返回值进行相应的修改操作
        //servery is a valid string:李白今年18岁
        if var serveryValue = servery {
            serveryValue += "今年18岁"
            print("servery is a valid string:\(serveryValue)");
        } else {
            print("servery is nil")
        }
        
        /* 以上代码可理解为:如果可选型String,返回了一个值,设置一个新的名为serveryValue的常量来接受可选型的值,
         如果成功转换,serveryValue 常量对于if语句的第一个分支就是成立的.它已经使用可选型的值初始化了,因此没有不需要使用!
         来获得它的实际值.在该例中,仅仅是打印了转换后serveryValue的值.
         
         如果你想在if条件语句成立的时候,手动修改声明的常量的值,需要将其声明为var类型的.如果你将其声明为var类型的,那么获取
         可选型的值之后,可以把该临时变量当做一个变量使用
         */
        
        //3.如果需要,可以把许多可选型绑定或者bool条件通过","隔开放在一个if判断语句中,如果可选型中的任何一个值为nil或者
        //任何bool条件为false,那么整个if条件语句被认为不成立;
        if let firstNumber = Int("4"),let secondNumber = Int("34"),firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100");
        }
        //等于以下的if语句
        if let firstNumber = Int("4") {
            if let secondNumber = Int("42") {
                if firstNumber < secondNumber && secondNumber < 100 {
                    print("\(firstNumber) < \(secondNumber) < 100");
                }
            }
        }
        /* 注意:
        与可选型绑定声明的常量或者变量仅仅在if的语句内可用.相反,用guard 语句声明的常量或者变量仅仅可以在guard语句的作用域内可用.
         */
    }
    
    // MARK: - 隐式解包可选型 (Implicitly unwrapped optionals)
    @objc func implicitlyUnwrappButton(sender:UIButton)  {
        /*想声明一个隐式解包可选型的变量或者常量时,在声明的类型后面放置"!"而不是"?"
         一个隐式解包的可选型是特定情况下的正常可选型,但是可以像非可选型的值一样使用,也就是在每次取值的时候不必要去解包操作.
         请看下面的例子;可选型与隐式解包可选型的区别:
         */
        let possibleString : String? = "An optional string.";
        let forcedString : String = possibleString!;//需要感叹号
        //forcedString is:An optional string.
        print("forcedString is:\(forcedString)")
        
        let assumedString : String! = "An implicitly unwrapped optional string."
        let implicitString: String = assumedString;//不需要感叹号
        //implicitString is:An implicitly unwrapped optional string.
        print("implicitString is:\(implicitString)")
        
        /* 我们可以认为隐式解包可选型在需要时有对可选型进行强制解包的权限.当使用隐式解包可选型值的时候,swift首先把它当做一个普通的
         可选类型值;如果不能作为可选型使用,swift对值进行强制解包.在上面的代码中,assumedString在被赋值给implicitString之前
         进行了强制解包,因为implicitString 有一个显示的非可选的String类型.
         
         请观察下面的代码,optionalString没有显示声明类型,所以它是一个普通的可选型
         
         */
        let optionalString = assumedString;
        print(optionalString);
        //Optional("An implicitly unwrapped optional string.")
        
        //2.如果对一个值为nil的隐式解包可选型的值进行解包操作,会得到一个runtime error.
        //可以像对正常的可选型一样来对隐式解包可选型的值是不是nil来进行检查.
        //An implicitly unwrapped optional string.
        if optionalString != nil {
            print(optionalString!);
        }
        //2.1 也可以对隐式解包可选型使用选择绑定来检查以及解包操作,在一个单行语句中:
        if let definitedString = optionalString {
            print(definitedString);
        }
        /*注意:
         如果一个变量在后面的某一个点可能会变成nil的时候,不要使用隐式解包可选类型.如果在一个变量的声明周期中需要检查值是否为nil,总是
         把该变量声明为正常的可选类型.
         */
    }
    
    // MARK: - 错误处理 Error Handling
    @objc func errorHandleButton(sender:UIButton)  {
        /* 可选型可以使用一个值的存在或者不存在来表达一个函数的成功或者失败,错误处理与之相反,它允许你确定错误的原因,
         如果有需要传递错误到你项目的其他部分.
         当一个函数遇到错误条件时,它抛出一个错误.函数调用者可以获取错误并且合理的响应.
         
         一个函数表明在其声明的时候使用throws 关键词表明它可以抛出一个错误.当你调用的函数抛出一个错误时,考虑使用try关键词.
         
         swift自动把错误传递出它们当前的作用域,直到被catch语句处理.
         
         */
        do {
            try canThrowAnError()
        } catch  {
            print("error is:\(error)");
        }
    }
    
    // MARK: - Assertions And Predoctions 断言和先决条件
    @objc func assertionsAndPredoctions(sender:UIButton)  {
        /*断言和先决条件的检测发生在运行的时候.在执行更深层的代码之前确保满足条件.如果在断言或者先决条件为true,代码正常
         运行,否则当前项目的状态是无效的,代码终止,App也被终止.
         
         断言和先决条件的区别是它们什么时候被检测:断言仅在Debug模式下被检测,但是先决条件在Debug和production模式下都被检测.
         在生产模式,先决条件在一个不被执行的断言内.这意味着在你开发的时候可以使用很多断言,不会对生产环境产生影响.
         */
        
        //1.Debugging with Assertions (调试断言)
        /**通过像下面的方式调用一个断言函数:
         assert(_:_:file:line:).
         传递给该函数一个评判为true或者false的表达式,一个当条件为false时展示的message
         */
        var age = -3;
        //assert(age >= 0, "A person's age can't be less than zero.")
        //以上代码中,代码执行到age>=0该条件时,判断该条件是真是假,如果为真则继续执行,否则就结束App的进程.
        //也可以忽略断言message(omit message)
        let year = 200;
        assert(year >= 0)
        
        age = 2;
        //2.如果代码已经检查了条件,可以使用asserttionFailure(_:file:line:)函数来描述一个断言失败.如下:
        if age > 10 {
            print("You can ride the byecycle")
        } else if age >= 0 {
            print("You are a normal man")
        } else {
            assertionFailure("A person's age can't be less then zero.")
        }
        
        // MARK: - Enforcing Preconditions (执行先决条件)
        /* 当一个条件有可能为false的时候,使用先决条件,但是一定要确保代码执行的条件为真.
         比如使用一个先决条件检查一下下标是否越界或者函数是否传递了一个无效的值.
         
         先决条件通过调用(_:_:file:line)函数.给这个表达式传递一个true或者false以及当条件为false时的展示的message.
         如下事例:
         */
        let index = 0
        precondition(index > 1, "index must be greater than zero.")
        //也可以使用preconditionFailure(_:file:line:)函数来表述一个已经出现的错误.
    }
    
    // MARK: - 运算符
    @objc func operatorButtonEvent(sender:UIButton) {
        // MARK: - Nil-Coalesing Operator (nil聚合运算符)
        /** nil聚合运算符(a ?? b)如果可选型有值就对其解包,否则就返回默认值b.表达式a总是可选类型.表达式b必须与a类型的值所匹配.
         也可以用如下代码表示:
         a != nil ? a! : b
         也就是如果可选型a不为nil,就对其就行强制解包,否则就返回b.
         
         nil聚合运算符对于这种需要对可选型的值进行判断并需要解包的操作提供了一种简洁的命令;
         
         如下示例:
         */
        let defaultColorName = "red"
        //定义为String类型的可选型,默认为值nil
        var userDefinedColorName:String? //默认为nil
        //因为userDefinedColorName 是一个可选型类型的值,所以可以使用nil聚合运算符来获取它的值
        var colorNameUse = userDefinedColorName ?? defaultColorName;
        print("colorNameUse is:\(colorNameUse)");
        //colorNameUse is:red
        
        userDefinedColorName = "White";
        colorNameUse = userDefinedColorName ?? defaultColorName;
        print("colorNameUse is:\(colorNameUse)");
        //colorNameUse is:White
        
        self.navigationController?.pushViewController(SWOperatorViewController.init(), animated: true);
    }
    
    @objc  func testLoading()  {
//        testAsync()
        printLog("Appversion:",AppVersion)
        showLoading()
        dispatchAfter(3.0) {
            printLog("hideLoading")
            self.hideLoading()
        }
    }
    
    /// 研究Alamofire
    @objc  func AlamofireStudy()  {
        self.navigationController?.pushViewController(SWAlamofireViewController.init(), animated: true);
    }
    
    
    func testAsync()  {
        dispatchAsync {
            for index in 0...20000 {
                printLog("index is:",index)
            }
        }
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
    
    func canThrowAnError() throws {
        print("canThrowAnError")
    }
    
    
    
}
