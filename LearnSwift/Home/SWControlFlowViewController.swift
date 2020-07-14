//
//  SWControlFlowViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/6/19.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

protocol TestProtocol {
    func ClickSwitchStatements()
}


class SWControlFlowViewController: SWBaseViewController {
    
    //  设置代理
    public var delegate:TestProtocol?
    
    //  定义Block
    typealias TestBlock = ()->(Void)
    //  创建Block变量
    var BlockCall:TestBlock!
    //  声明并创建一个有参无返回的Block
    var blockTwo:((String)->(Void))!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "控制流";
        p_initDefaultData();
    }
    
    func p_initDefaultData() -> Void {
        self.view.addSubview(self.tableView);
        listArray.append("ForInLoops")
        listArray.append("WhileLoops")
        listArray.append("SwitchStatements")
        listArray.append("BlockCallBack")
        listArray.append("ControlTransferStaments")
        listArray.append("LabeledStatements")
        listArray.append("EarlyExit")
        listArray.append("CheckingAPIAvailability")
        tableView.reloadData()
    }
    
    // MARK: - For-In Loops
    @objc func ForInLoops() {
        let names = ["1","2","3","4"]
        for number in names {
            print("numberi is:\(number)")
        }
        
        let numberOfLegs = ["spider":"8","ant":"6","cat":"4"]
        for (key,value) in numberOfLegs {
            print("key is:\(key) and value is:\(value)")
        }
        let base = 3
        let power = 10
        var answer = 1
        
        //2.如果不需要循环的值,可以使用下划线来忽略该循环变量
        for _ in  1...power{
            answer *= base
        }
        print("\(base) to power of \(power) is\(answer)")
        
        //3.使用stirde(from:to:by:)函数来忽略一些不想要的标记,如下:半开区间
        let minutes = 60
        //tickMark is:0 tickMark is:5 tickMark is:10.... tickMark is:55
        for tickMark in stride(from: 0, to: minutes, by: 5) {
            print("tickMark is:\(tickMark)")
        }
        
        //4.使用stride(from:through:by) 来包含可闭区间
        let hours = 12
        let hourInterval = 3
        for tickMark in  stride(from: 0, through: hours, by: hourInterval) {
            print("tickMark is:\(tickMark)")
        }
    }
    
    // MARK: - WhileLoops (while循环)
    @objc func WhileLoops() {
        /** While循环执行一系列语句,直到条件为false.这种循环适用于在第一次迭代开始前无法确定迭代次数的.
         Swift有两种while循环语句.
         1.while 语句在刚开始的时候就判断语句条件.
         2.repeat-while每次循环完成之后判断条件.
         */
        //1.while 循环
        
        var index = 0
        while index < 10 {
            index += 1;
            print("index is valid:\(index)")
        }
        
        //2.repeat while .在判断条件之前,先执行一次循环,然后去检测条件是否满足
        //注意:Swift中的repear-while循环类似于其它语言的do-while循环
        //repear {'statements'} while 'condition'
        repeat {
            print("repeat while's index is:\(index)")
        }while index > 10
        //repeat while's idnex is:10 即使条件不满足,依然执行一次函数语句
    }
    // MARK: - SwitchStatements 语句
    @objc func SwitchStatements() {
        
        if delegate != nil {
            delegate?.ClickSwitchStatements()
        }
        
        let someCharacter : Character = "Z"
        switch someCharacter {
        case "1":
            print("a")
        case "z","Z":
            print("Z")
        default:
            print("default")
        }
        
        //2.No  Implicit FallThrough (没有隐含的跳转)
        /*与C语言和OC语言中的Switch语句相比,Swift中的每个case语句之后,默认不要到下一个条件的过渡.相反,在switch中第一个匹配的case语句
         执行完成之后,整个switch语句也就完成了,不需要在每个case语句之后加上break语句.这使得相对于C语言的switch语句更加安全,并且更
         容易使用,避免了执行多个case语句的错误.
         */
        
        //3.Where 语句 ,在switch语句中可以使用where语句来检查额外的条件 如下示例:
        let yetAnotherPoint = (1,-1)
        switch yetAnotherPoint {
        case let(x,y) where x == y:
            print("(\(x),\(y)) is on the line x==y")
        case let(x,y) where x == -y:
            print("(\(x),\(y)) is on the line x==-y")
        case let (x,y):
            print("(\(x),\(y)) is just some arbritrary point")
            
        }
    }
    
    // MARK: - Block回调
    @objc func BlockCallBack() {
        if let _ = BlockCall {
            BlockCall()
        }
        if let _ = blockTwo {
            blockTwo("TestString")
        }
    }
    
    // MARK: - Control Transfer Statments(控制转换语句)
    @objc func ControlTransferStaments() {
        //控制转换语句改变了代码片段的执行书按需,通过控制转换从一段代码跳转到另一段代码.Swift有5种控制转换语句:
        
        //1.Contiune
        //Contiune 语句告诉一个循环停止当前正在做的事情并且从下一个迭代开始循环.
        //以下的例子从一个小写的字符串中移除所有的元音字母和空格并且创建一个句子:
        let puzzleInput = "great minds think alike"
        var puzzleOutput = ""
        let charactersToRemove:[Character] = ["a","e","i","o","u"," "]
        for charachter in puzzleInput {
            if charactersToRemove.contains(charachter) {
                continue
            }
            puzzleOutput.append(charachter)
        }
        //以上的代码循环遇到元音字母或者空格就执行continue语句,结束当前循环,直接跳转到下次循环的开始
        //puzzleOutput
        print("puzzleOutput")
        
        //2.Break
        //break语句立即结束整个控制流语句的循环.可以用来停止while或者for循环,如果想要结束循环的时候.
        //Switch case中使用break.
        let numberSymbol : Character = "三"
        var possibleIntegerValue:Int?
        switch numberSymbol {
        case "1","一":
            possibleIntegerValue = 1
        case "2","二":
            possibleIntegerValue = 2
        case "3","三":
            possibleIntegerValue = 3
        default:
            break
        }
        if let integerValue = possibleIntegerValue {
            print("The integer value of\(numberSymbol) is\(integerValue).")
        } else {
            print("An integer value could not be found for\(numberSymbol).")
        }
        
        //当执行到有匹配的case项时,执行对应的内容,没有匹配项的时候,执行defaut,因为是break语句,跳转循环直接完成.
        
        //3.Fallthrough
        //如果需要C语言风格的过渡行为(在C语言的Switch case中,如果每个case中的尾部没有显式加上break关键词,
        //那么会在一个case执行到底部之后过渡到下一个case中),需要在case中加上fallthrough关键词
        //如下例:
        let integerToDescribe = 5
        var description = "The number \(integerToDescribe) is"
        switch integerToDescribe {
        case 2,3,5,7,11,13,17,19:
            description += " a prime number,and aslo"
            fallthrough
        default:
            description += " an integer."
        }
        //The number 5 is a prime number,and aslo an integer.
        print(description)
        
    }
    
    // MARK: - Labeled Statements (标签语句)
    @objc func LabeledStatements() {
        //在Swift中为了创建复杂的控制流结构,可以在别的循环体或者控制语句中嵌套循环体以及控制语句.
        /*
         "label name": while "condition" {
         "statement"
         }
         如下事例:
         */
        let finalSquare = 25
        var board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08;
        var square = 0
        var diceRoll = 0
        
        gameLoop : while square != finalSquare {
            diceRoll += 1
            if diceRoll == 7 {
                diceRoll = 1
            }
            switch square + diceRoll {
            //达到目标值结束当前循环
            case finalSquare:
                break gameLoop
            //>目标值,continue结束当前循环,从下一次迭代开始
            case let newSquare where newSquare > finalSquare :
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        print("Game Over")
        
        var sumValue  = 0
        var increment = 0
        var times = 0
        
        let maxValue = 100
        testLoop : while sumValue != maxValue {
            print("sumValue:\(sumValue) increment:\(increment) ")
            increment = Int.init(arc4random() % 10) + 1;
            switch increment + sumValue  {
            case maxValue:
                break testLoop
            case let newValue where  newValue > maxValue :
                times += 1
                //              重新开始,把初始值重置
                sumValue = 0
                continue testLoop
            default:
                sumValue += increment
            }
        }
        /*注意:
         如果break 语句后面没有加上testLoop标签,那么执行该语句的时候,结束的只是当前的switch case语句,并不是整个带标签的while循环.
         使用"testLoop"标签对于结束哪个控制流语句很清晰明了.
         
         */
        
        print("times is:\(times)")
    }
    
    // MARK: - Early Exit 提前退出
    @objc func EarlyExit() {
        /* guard 语句像if语句一样,执行语句取决于表达式值的真伪.使用guard语句为了确保guard语句后的代码能够执行,需要确保该
         条件为真.不像if语句,guard语句总会有一个else语句,如果条件为假的时候执行else语句中的代码.
         */
        func greet(person:[String:String]) {
            guard let name = person["name"]
                else {
                    return
            }
            print("Hello\(name)!")
            
            guard let location = person["location"] else {
                print("I hope the weather is nice near you.")
                return
            }
            print("I hope the weather is nice in \(location)")
        }
        /** 如果guard语句的条件满足,代码继续执行guard语句右大括号后面的代码.
         
         */
        
        //HelloJohn!
        //I hope the weather is nice near you.
        greet(person: ["name":"John"])
        
        //什么都没输出 因为没有满足guard的条件,所以guard语句右大括号后面的代码不执行;执行了else语句之后就return了
        greet(person: ["location":"ShangHai"])
        
        //HelloJane!
        //I hope the weather is nice in China
        greet(person: ["location":"China","name":"Jane"])
    }
    
    // MARK: - Checking API Availability (检查API的可用性)
    @objc func CheckingAPIAvailability() {
        
        if #available(iOS 10, macOS 10.12, *) {
            print("iOS10及其以上的系统")
        } else {
            print("iOS 10一下的系统")
        }
    }
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
    
    
}
