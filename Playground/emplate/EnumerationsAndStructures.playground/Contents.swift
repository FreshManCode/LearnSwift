import UIKit
//枚举和结构体
//1.使用Enum来创建一个枚举
enum Rank:Int {
    case ace = 1;
    case two,three,four,five,six,seven,eight,nine,ten;
    case jack,queen,king;
    func simpleDescrption() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        default:
            return String(self.rawValue);
        }
    }
}

//ace
let ace = Rank.ace;
//1
let aceRawValue = ace.rawValue;
let jack = Rank.jack;
//11
jack.rawValue;
//通常,swift分配原始值从0开始,并且每次+1,但是你可以通过显示赋值来更改这个行为

//1.2 使用init?初始化方法根据rawValue来创建一个枚举实例.该实例的返回值要么就是与原始值匹配的
//要么就是返回nil,也就是没有匹配
if let convertedRank = Rank(rawValue: 3){
    //  "3"
    let threeDescrption = convertedRank.simpleDescrption();
}

enum Suit {
    case spades,hearts,diamonds,clubs
    
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades";
        case .hearts:
            return "hearts";
        case .diamonds:
            return "diamonds";
        case .clubs:
            return "clubs";
        }
    }
}
//hearts
let hearts = Suit.hearts;
//"hearts"
let heartsDescrption = hearts.simpleDescription();

//1.3 枚举类型的另一种选择就是让值与case 关联起来,这些值在创建实例的时候决定.如下事例:
enum ServerResponse {
    case result(String,String)
    case failre(String)
}
let success = ServerResponse.result("6:00 am", "8.09 pm");
let failure = ServerResponse.failre("Out of cheese");

switch failure {
//Sunrise is at6:00 am and sunset is at:8.09 pm.
case let.result(sunrise, sunset):
    print("Sunrise is at:\(sunrise) and sunset is at:\(sunset).")
    
//Failure...Out of cheese
case let.failre(message):
    print("Failure...\(message)")
}

//注意:sunrise和sunset 是怎样从ServerResponse中提取出来的,根据值的匹配

//2.结构体
//结构体有许多像Class的行为,包括方法和构造方法;二者最重要的区别是:结构体总是在代码传递时被拷贝
//class通过引用传递
struct Card {
    var rank:Rank
    var suit:Suit
    func simpleDescription() -> String {
        return "The\(rank.simpleDescrption()) of \(suit.simpleDescription())"
    }
}
let threeOfSpades = Card(rank: .three, suit: .spades);
// "The3 of spades"
let threeOfSpadesDescription = threeOfSpades.simpleDescription()


//3.协议和扩展(Protocol and Extensions)
//3.1 使用protocol声明一个协议
protocol ExampleProtocol {
    var simpleDescription:String{get}
    mutating func adjust()
}
//class,枚举和结构体都可以遵从协议
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty:Int = 69105
    func adjust() {
        simpleDescription += " Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
//"A very simple class. Now 100% adjusted."
let aDescription = a.simpleDescription

//注意:结构体和枚举中的方法默认情况下是不能修改属性的.如果需要修改要将方法声明为可变的(mutating)
//不然会报如下错误:note: mark method 'mutating' to make 'self' mutable
struct SimpleStructure:ExampleProtocol {
    var simpleDescription: String = "A simple structure."
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
//"A simple structure. (adjusted)"
let bDescrpition = b.simpleDescription

// MARK: - 3.2 协议
//使用extension 给一个已知的类型添加额外的功能,例如新方法或者属性.
//可以使用扩展添加在任意地方声明协议的行为,或者你从libs导入的类型
extension Int:ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42;
    }
}
//The number 7
print(7.simpleDescription);

//可以使用协议名像其他命令类型一样;例如创建一个集合,虽然有不容的类型,但是都遵从同一个协议.
//当你处理这些协议类型值的时候,在协议范围之外的方法不可用
let protocolValue:ExampleProtocol = a;
print(protocolValue.simpleDescription)
//error: value of type 'ExampleProtocol' has no member 'anotherProperty'
//print(protocolValue.anotherProperty)
//即使anotherProperty变量有个运行时的SimpleClass类型,但是编译器把它当做ExampleProtocol类型对待
//这就意味着,你无法访问协议之外的属性或者方法.

// MARK: - 3.3 错误处理 (Error Handling)
// 可以把errors定义为各种类型,只要遵从Error协议
//3.3.1
enum PrinterError:Error {
    case outOfPaper
    case noToner
    case onFire
}
//使用throw 关键词抛出一个错误并且使用throws 关键词表示一个函数可以抛出错误.如果你在一个函数中
//抛出错误,函数立即返回调用你在处理错误中的函数
func send(job:Int,toPrinter printerName:String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner;
    }
    else if printerName == "OnFire" {
        throw PrinterError.onFire;
    }
    return "Job sent"
}

//有许多处理错误的方法,其中一种方法就是使用do-catch,在do模块中,你写可能抛出错误的代码通过在其它
//之前使用try关键词.在catch模块中,错误自动自动赋值给error,除非你给它一个别名
do {
    let printerResponse = try send(job: 1040, toPrinter:"Never Has Toner")
    print(printerResponse)
} catch {
    print(error);
}
//Job sent

//3.3.2
//可以使用多重catch模块用来处理特定的错误.在每一个catch模块之后写对应的case处理
do {
    let printerResponse = try send(job: 1040, toPrinter:"OnFire")
    print(printerResponse)
} catch PrinterError.onFire {
//  printerName 改为"OnFire",以下Log会输出
    print("T'll just put this over there,with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error:\(printerError).")
} catch {
    print(error)
}
//Job sent

//3.3.3 另一种处理错误的方法是使用try?把结果转为一个可选类型.如果函数抛出一个错误,特定的error被
//丢弃并且结果为nil,否则,结果是一个包含函数返回值的可选类型.
//Job sen
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
//nil
let printerFailure = try? send(job: 1885, toPrinter: "OnFire")

//3.3.4 使用defer关键词写一个块,该块中的代码在函数所有的代码执行完毕之后并且在函数返回之前执行,
//该代码无论函数是否抛出错误都会执行.可以是使用defer块,用来进行下一步或者清理的工作,
var fridgeIsOpen = false
var fridgeContent = ["milk","eggs","leftovers"]
//如果不想在函数调用的时候显示参数的标签名,使用_做标识,并且中间有空格
func fridgeContains(_ food:String) -> Bool {
    fridgeIsOpen = true;
    defer {
        fridgeIsOpen = false;
    }
    let result = fridgeContent.contains(food);
    return result;
}
//false
fridgeContains("banana");
//false
print(fridgeIsOpen);


// MARK: -4. 泛型 generics
// 4.1 在尖括号内写上名称,使其成为泛型类型或者泛型函数
func makeArray<Item>(repeating item:Item,numberOfTimes:Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item);
    }
    return result;
}
//["Knok", "Knok", "Knok", "Knok"]
makeArray(repeating: "Knok", numberOfTimes: 4);

//4.2 可以创建泛型的函数或者方法,甚至class,枚举和结构体;
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}
//none
var possileInteger:OptionalValue<Int> = .none
//some(100)
possileInteger = .some(100)

//4.3 右边使用where描述一系列要求,
func anyCommenElements<T:Sequence,U:Sequence>(_ lts:T,_ rhs: U)->Bool where
    T.Element:Equatable,T.Element == U.Element {
        for ltsItem in lts {
            for rhsItem in rhs {
                if ltsItem == rhsItem   {
                    return true;
                }
            }
        }
        return false;
}
//true
anyCommenElements([1,2,3], [3])



