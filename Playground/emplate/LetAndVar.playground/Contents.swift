import UIKit

//1.基本量

var str  = "Hello, playground";
//在'='两边必须有空格
let name = "LiMing";
print(str)

//使用\() 来进行字符串格式化操作
print("str is:\(str) and name is:\(name)")
//str is:Hello, playground and name is:LiMing
let quotation = """
I said "I have\(str)."
And then I said "I have 10 prices of friut".
"""
//quotation is:I said "I haveHello, playground."
//And then I said "I have 10 prices of friut".
print("quotation is:\(quotation)");


//2.字典和Array
//使用[]来创建字典/数组,使用索引或者key来访问数组/字典
var shoppingList=["catfish","water","tulips"];
shoppingList[1] = "bottle of water";
var occupation = [
    "name":"李明",
    "age":"23",
];

occupation["name"] = "胡扯";
shoppingList.append("blue Point")
//数组长度随着你添加的元素自动增加
print(shoppingList)
//["catfish", "bottle of water", "tulips", "blue Point"]

//如果想创建一个空的数组/字典,使用初始化方法
let emptyArray = [String]();
let emptyDic = [String:Float]();

//如果类型信息可以推断,可以像如下方法一样创建一个空数组/字典
//空数组
shoppingList=[];
//空字典
occupation=[:];

//3.控制流
//使用if/switch 来创建控制条件 (控制条件两边的括号可以省略不写,循环体的{}不能省略)
//使用for-in,while和repeat-while循环来创建循环体

let individualScores = [75,43,103,87,12];
var temScore = 0;
for score in individualScores {
    if score > 50 {
        temScore += 3;
    }
    else {
        temScore += 1;
    }
}
//temScore is: 11
print("temScore is:",temScore);

//注意:如果if条件里面的是布尔类型的表达式,就如下面的代码一样  if temScore { ***}
//这样的表达式是错误的,不是对0的隐式比较,可以使用if 和 let结合对于这些值可能为空的情况.
//这些可能为空的值就是可选型的.如下:
var optionalString : String? = "Hello";
//false
print(optionalString == nil);

var optionalName:String? = "John Applessed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello,\(name)"
}
//Hello,John Applessed
print(greeting);

optionalName=nil;
if let name = optionalName {
    greeting = "Hello,\(name)"
} else {
    greeting = "Hi,\(name)"
}
//Hi,LiMing
print(greeting);

//1.如果可选值为nil,则条件语句为false,否则可选值解包之后赋值给let之后的声明的常量

//2.另一种处理可选值的方法是使用"??"操作符赋值默认值
let nickName:String? = nil
let fullName:String  = "John Appleseed"
//HiJohn Appleseed
let informalGreeting="Hi\(nickName ?? fullName)"

// MARK: - Switch Case
//switch 语句支持很多的数据比较语句,而不仅仅局限于整型
let vegetable = "Red pepper"
switch vegetable {
case "celery":
    print("vegetable is:","celery");
case "cucumber","watercress":
    print("That would make a good tea sandwitch")
// 注意:怎样在匹配模式中使用let常量赋值
case let x where x.hasSuffix("pepper"):
    print("It is a spicy\(x)?")
default:
    print("Everything tastes good in soup");
}
//It is a spicyRed pepper?

//2.可以使用for -in 来遍历一个dic,因为字典是无序的,所以每次遍历的顺序都是任意的
let testDic=["Prime":[2,3,5,7,11,13],
             "Fibonacci":[1,1,2,3,5,8],
             "Square":[1,4,9,16,25],];
var largest = 0;
for (kind,numbers ) in testDic {
    for number in numbers {
        if number > largest {
            largest = number;
        }
    }
}
//largest is : 25
print("largest is :",largest);

//3.使用while循环来执行一段代码直到条件改变.循环条件也可以放在最后,确保循环至少执行一次
var n = 2;
while n < 100 {
    n *= 2;
}
//128
print(n);

var m = 2;
repeat {
    m *= 2;
}while m <  100
//128
print(m)

//4.可以使用0..<index 来创建一个范围的索引
var toal = 0;
for i  in 0..<5 {
    toal += i;
}
//10
print(toal)

//使用..< 不包含最大值,使用...最大小和最小值都包含


//对于每种不同的数据类型所拥有的的存储空间是不同的如下:
//一个Int8类型的常量或者变量的存储值的范围是-128 -> 127
//一个Unit8 类型的常量或者变量的存储值的范围是 0->255

//negative integer '-1' overflows when stored into unsigned type 'UInt8'
//let cannotBeNegative:UInt8 = -1;

//error: arithmetic operation '127 + 1' (on type 'Int8') results in an overflow
//let tooBig:Int8 = Int8.max + 1;

//按情况选择合适的类型进行转换
//为了把一个已经声明的数值类型转换为另一种类型,需要初始化一个想要的数据类型,如下事例:
//常量:twoThouand是一个UInt16类型的,one:是一个UInt8类型的,二者不能直接进行加法操作,因为它们的数据类型不同
//,因此该例使用UInt16(one)又初始化了一个UInt16类型的One,并且使用这个值代替原始值进行操作.
//SomeType(ofInitialValue)Swift使用一个初始值进行初始化的默认方法,
let twoThouand :UInt16 = 2_000;
let one:UInt8 = 1;
let twoThouandAndOne = twoThouand + UInt16(one);

//整型和浮点型的转换
//整型和浮点型的数据转换必须是显示转换;如下:
let three = 3;
let pointOne = 0.1;
let pi = Double(three) + pointOne;
//Double(three) 用来创建一个Double类型的数据,加号两边的数据类型一致,可以进行加法操作,否则就会报错.
//浮点型数据转换为整型也必须要显示进行.一个整型的类型可以使用一个Double或者Float类型的值进行初始化
let integerPI = Int(pi); //3
let integer2 = Int(4.9); //4
//注意:浮点型的数据转换为整型时,浮点总是会被截断,意味着4.75变成4,-3.9变成-3



@objc func EscapingClosures () {
       // 闭包可以逃逸的一种方式是存储一个变量在函数之外.如下:
       var completionHandlers :[()->Void] = []
       func someFunctionWithEscapingClosure(completionHandler:@escaping ()->Void) {
           completionHandlers.append(completionHandler)
       }
       
       /*如果不使用 @escaping 来标记函数中的参数,会报错.
        使用 @escaping 来标记闭包,意味着必须显示使用self在闭包内进行引用.如下事例:
        */
       func someFunctionWithNoEscapingClosure(closure:()-> Void) {
           closure()
       }
       class SomeClass {
           var x = 10
           func doSomething()  {
            someFunctionWithNoEscapingClosure {
                x = 10
            }
            someFunctionWithEscapingClosure {
                self.x = 1
            }
           }
           
       }
   }
