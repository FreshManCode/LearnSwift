import UIKit
// MARK: - 函数和闭包
//Functions and Closures
func greet(person:String,day:String)->String {
    return "Hello \(person),today is\(day)."
}
//通常函数使用它们的参数名作为参数的标签.
greet(person: "LiMing", day: "星期四");
//可以使用"_"不给参数标签名
func greet2(_ person:String,day:String) -> String {
    return "Hello\(person),today is\(day)"
}
//该函数在调用的时候,person参数没有标签名
greet2("John", day: "星期四")

//使用元组(tuple)返回多个值
func caculateStatistics(scores:[Int]) -> (min:Int,max:Int,sum:Int) {
    var min = scores[0];
    var max = scores[0];
    var sum = 0;
    for score in scores {
        if score > max {
            max = score;
        } else if score < min {
            min = score;
        }
        sum += score;
    }
    return (min,max,sum);
}
let statistics = caculateStatistics(scores: [5,3,100,23,3])
//134
print(statistics.sum);
//100
print(statistics.max);

//2.1函数可以嵌套.
func returnFifTeen() -> Int {
    var y = 10;
    func add () {
        y += 5;
    }
    add();
    return y;
}
//15
print(returnFifTeen());
//2.2函数的返回值也可以是另外一个函数
func makeIncrementer() -> ((Int)->Int) {
    func addOne(number:Int)->Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer();
//8
print(increment(7));

//2.3 一个函数可以作为另个函数的参数
func hasAnyMatchs(list:[Int],condiction:(Int)->Bool) -> Bool {
    for item in list {
        if condiction(item) {
            return true;
        }
    }
    return false;
}
func lessThanTen(number:Int)->Bool {
    return number < 10;
}
var numbers = [20,19,7,12]
hasAnyMatchs(list: numbers, condiction: lessThanTen);


//2.4 闭包 写一个用{}包起来的匿名函数,使用in 来区别参数和函数的返回值
var numbers2 = [20,19,7,12]
let result = numbers2.map({(number:Int)->Int in
    let result = 3 * number;
    return result;
})
//[60, 57, 21, 36]
print(result);

//可以通过数字而不是名字引用参数.如果闭包作为一个函数的最后参数,可以紧跟着大括号之后,当闭包是这个函数的
//唯一参数时,可以完全用大括号包裹.
let sortedNumebrs = numbers2.sorted{$0 > $1}
//[20, 19, 12, 7]
print(sortedNumebrs);


//3.Object and Classes
//使用class后面紧跟着class 名称创建一个class.
//在class中声明的属性像声明一个常量或者变量一样的写法.
class Shape {
    var numberOfSides = 0;
    func simpleDescription() -> String {
        return "A shape with\(numberOfSides) sides."
    }
}
var shape = Shape();
shape.numberOfSides = 7;
//A shape with7 sides.
print(shape.simpleDescription());

//上面的class缺少了重要的初始化函数,新的class如下
class NamedShape{
    var numberOfSide : Int = 0;
    var name:String;
    init(name:String) {
        self.name = name;
    }
    func simpleDescription() -> String {
        return "A shape with\(numberOfSide) sides."
    }
    deinit {
        print("this class has been released")
    }
}

//class的继承,在子类中重写父类中声明的方法需要使用override关键词,不然会报错.
class ASquare: NamedShape {
    var sideLength:Double;
    init(sideLength:Double,name:String) {
        self.sideLength = sideLength;
//如果直接使用 self.name = name; 会报如下错误
//'self' used in property access 'name' before 'super.init' call,
        super.init(name: name);
    }
    func area() -> Double {
        return sideLength * sideLength;
    }
    override func simpleDescription() -> String {
        print("my name is:\(self.name)");
        return "A square with sides of length\(sideLength) sides."
    }
}
let test = ASquare.init(sideLength: 5.2, name: "my test square");
test.area();
test.simpleDescription();

let test2 = ASquare(sideLength: 5.3, name: "another init method");
test2.simpleDescription();

//为了简单化属性的存储,还有setter和getter方法
class EquilateralTriangle: NamedShape {
    var sideLength:Double = 0.0;
    init(sideLenth:Double,name:String) {
        self.sideLength = sideLenth;
        super.init(name: name);
        numberOfSide = 3;
    }
    var perimeter:Double {
        get {
            return 3.0 * sideLength;
        }
        set {
//newValue 是一个隐式参数名
            print("new value is:\(newValue)");
            sideLength = newValue / 3.0;
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length\(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLenth: 3.1, name: "a triangle")
//9.3
print(triangle.perimeter);
triangle.perimeter = 9.9;
//new value is:9.9
//3.3000000000000003
print(triangle.sideLength);

//3.4 willSet 和didSet
//下面方法确保square和triangle的边长相等
class TriandleAndSquare {
    var triangle : EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength;
        }
    }
    var square : ASquare {
        willSet {
            triangle.sideLength = newValue.sideLength;
        }
    }
    init(size:Double,name:String) {
        square = ASquare(sideLength: size, name: name);
        triangle = EquilateralTriangle(sideLenth: size, name: name);
    }
}
var trianlgeAndSquare = TriandleAndSquare(size: 10, name: "anothre test shape");
//10.0
print(trianlgeAndSquare.square.sideLength);
//10.0
print(trianlgeAndSquare.triangle.sideLength);

//3.4 当遇到可选类型值的时候,如果在?之前的值为nil,那么在?之后的所有都会被忽略并且整个表达式的
//值为nil;而且,可选型的值是未解包的,并且在?之后的所有都是一个未解包的值.在这种情况下,整个表达式的值
//都是一个可选类型.

let optionalSquare:ASquare? = ASquare(sideLength: 2.5, name: "optional square")
let sideLenth = optionalSquare?.sideLength;
//Optional(2.5)
print(sideLenth);



