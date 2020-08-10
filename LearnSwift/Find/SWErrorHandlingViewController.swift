//
//  SWErrorHandlingViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/8/10.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWErrorHandlingViewController: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefaultData()
    }
    
    
    
    func p_initDefaultData() -> Void {
        self.title = "ErrorHandling(错误处理)";
        listArray.append("RepresentingAndTheThrowingErrors")
        listArray.append("TypeCasting")
        listArray.append("NestedTypes")
        self.view.addSubview(self.tableView);
        tableView.reloadData()
    }
    
    // MARK: - RepresentingAndTheThrowingErrors
    @objc func RepresentingAndTheThrowingErrors() {
        enum VendingMachineError : Error {
            case invalidSelection
            case insufficientFunds(coinsNeeded:Int)
            case outOfStock
        }
        //当发生了意外的情况并且不能按照正常流程继续执行的时候,可以使用throw语句来抛出有个错误.如下:
        // throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
        
        //2.Propagating Erros Using Throwing Functions (使用函数来传递错误)
        //为了描述函数,方法或者构造函数可以抛出一个错误,在函数的参数声明之后使用throws 关键词.在返回箭头->之前
        //,表明这是一个throwing function ,抛出错误的函数
        //        func canThrowErros() throw -> String  {
        //
        //        }
        
        struct Item {
            var price : Int
            var count : Int
        }
        
        class VendingMachine  {
            var inventory = [
                "Candy Bar":Item(price: 12, count: 7),
                "Chips":Item(price: 10, count: 4),
                "Pretzels":Item(price: 7, count: 11),
            ]
            var coinsDeposited = 0
            //该函数传递它抛出的任何错误,任何调用该方法的代码必须使用do-catch语句,或者try?或者try!或者continue语句来错误错误.
            func vend(itemNamed name:String) throws  {
                guard let item = inventory[name] else {
                    throw VendingMachineError.invalidSelection
                }
                guard item.count > 0  else {
                    throw VendingMachineError.outOfStock
                }
                
                guard item.price <= coinsDeposited else {
                    throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
                }
                
                coinsDeposited -= item.price
                
                var newItem = item
                newItem.count -= 1
                inventory[name] = newItem
                print("Dispensing \(name)")
                
            }
        }
        
        
        let favoriteSnacks = ["Alice":"Chips","Bob":"Licorice","Eve":"Pretzels"]
        
        func buyFavoriteSnack(person:String,vendingMachine:VendingMachine) throws {
            let snackName = favoriteSnacks[person] ?? "Candy Bar"
            try vendingMachine.vend(itemNamed: snackName)
        }
        
        struct PurchasedSnack {
            let name : String
            init(name:String,vendingMachine:VendingMachine) throws {
                try vendingMachine.vend(itemNamed: name)
                self.name = name
            }
        }
        
        
        //3.Handling Erros Using Do-Catch
        var vendingMachine = VendingMachine()
        vendingMachine.coinsDeposited = 8
        do {
            //使用try 语句来调用,因为该函数有可能会抛出异常.如果该函数抛出异常,那么会立即转向catch语句
            //如果没有对应的catch语句,会执行最后一个catch语句,并且会绑定一个error常量.如果没有异常
            //会继续执行do语句中的.
            try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
            print("Success! Yum")
        } catch VendingMachineError.invalidSelection {
            print("Invalid Selection.")
        } catch VendingMachineError.outOfStock {
            print("Out of Stock")
        } catch VendingMachineError.insufficientFunds(coinsNeeded: let coinsNeed) {
            print("Insufficient funds.Please insert an additional\(coinsNeed) coins.")
        } catch {
            print("Unexpected error:\(error).")
        }
        
        
        //该函数抛出了VendingMachineError枚举中的其中一个选项,该函数通过打印一个message老处理该异常.
        func nourish(with item:String) throws  {
            do {
                try vendingMachine.vend(itemNamed: item)
            } catch is VendingMachineError {
                print("Invalid selection,out of stock,or not enouch money.")
            }
        }
        
        do {
            try nourish(with: "Beet-Flavored Chips")
        } catch  {
            print("Unexpected non-vending-machine-related error:\(error)")
        }
        
        
        //4.Converting Errors to Optional Values
        //可以使用try? 来把一个错误转成一个可选型.当执行表达式,如果抛出了异常,则表达式的值为nil如下:
        func someThrowingFunction() throws ->Int  {
            return 1
        }
        let x = try? someThrowingFunction()
        let y : Int?
        do {
            try y = try someThrowingFunction()
        } catch  {
            y = nil
        }
        print("x is:\(x ?? 0) y is:\(y ?? 0)")
        
        //5.Specifying Cleanup Actions (确定的回收行为)
        //使用defer 语句在代码执行完成当前的代码块之前来执行一系列的语句.该语句允许你做一些清理操作,不管代码执行的模块是出错了还是返回或者中断了.
        //例如,使用defer语句确保文件解释器关闭了并且手动释放了内存
        
        //延迟操作的执行顺序与它们在代码中的顺序相反,也就是先出现的延迟操作最后执行,最后出现的延迟操作最先执行.
        //        func processFile(fileName:String) throws  {
        //            if exists (fileName) {
        //                let file = open(fileName)
        //                defer {
        //                    close (file)
        //                }
        //                while let line = file.readline() {
        //
        //                }
        //              实际上defer语句在作用于的末尾执行
        
        //            }
        //        }
    }
    
    // MARK: - Type Casting (类型转换)
    @objc  func TypeCasting()  {
        //Swift提供了 "is","as" 两个类型转换操作符 .
        //1.Defining a Class Hierarchy for Type Casting
        class MediaItem  {
            var name:String
            init(name:String) {
                self.name = name
            }
        }
        
        class Movie : MediaItem {
            var director:String
            init(name:String,director:String) {
                self.director = director
                super.init(name: name)
            }
        }
        class Song : MediaItem {
            var artist:String
            init(name:String,artist:String) {
                self.artist = artist
                super.init(name: name)
            }
        }
        
        let library = [Movie(name: "Casablanca", director: "Michael Curtize"),
                       Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
                       Movie(name: "Citizen Kane", director: "Orson Wells"),
                       Song(name: "The One And Only", artist: "Chesney Hawkes"),
                       Song(name: "Never Gonna Give You up", artist: "Risk Astley")
        ]
        //library 由类型推断为 [MediaItem]
        
        //2.Checking Type
        //使用类型检查操作符 "is" 来检查一个实例是否是某个子类的类型.如果是某个子类型的实例,结果为true,否则为false
        
        var movieCount = 0
        var songCount = 0
        
        for item in library {
            if item is Movie {
                movieCount += 1
            } else if item is Song {
                songCount += 1
            }
        }
        print("Media libray contains \(movieCount) movies and \(songCount) songs ")
        //Media libray contains 2 movies and 3 songs
        
        
        //3.Downcasting
        for item in library {
            if let movie = item as? Movie {
                print("Movie:\(movie.name),dir. \(movie.director)")
            } else if let song = item as? Song {
                print("Song:\(song.name),by \(song.artist)")
            }
        }
        //因为item是MediaItem的实例,所以可能是Movie,也可能是Song,甚至也有可能是基类MediaItem.基于这种不确定性,
        //as? 形式的类型转换返回一个可选型的值,当试图转换成一个子类型.
        
        
        //4.Type Casting for Any and AnyObject
        //.Swift提供了两种特殊类型用来表示没有指定的类型
        //1.Any 可以表示任何类型的实例,包含函数类型
        //2.AnyObject 可以表示任何类的实例类型
        
        var things = [Any]()
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append("Hello")
        things.append((3.0,5.0))
        things.append(Movie(name: "Test", director: "Test"))
        //包含一个闭包,需要一个字符串类型的参数并且返回另一个字符串的值
        things.append({(name:String)->String in "Hello,\(name)"})
        
        //为了区分应用Any或者AnyObject 特定类型的变量或者常量,可以在Switch语句中使用is 或者as 匹配模式.如下
        for thing in things {
            switch thing {
            case 0 as Int:
                print("Zero as an Int")
            case 0 as Double:
                print("Zero as double")
            case let someInt as Int:
                print("An integer value of \(someInt)")
            case let someDouble as Double where someDouble > 0:
                print("a positive double value of \(someDouble)")
            case is Double:
                print("some other double value that I don't want to print")
            case let someString as String :
                print("a string value of \(someString)")
            case let (x,y) as (Double,Double):
                print("an (x,y) point ad \(x),\(y)")
            case let moveie as Movie:
                print("a movie called\(moveie.name),dir. \(moveie.director)")
            case let stringConvert as (String)->String:
                print(stringConvert("Micheal"))
            default:
                print("something else")
            }
        }
        /*
         Zero as an Int
         Zero as double
         An integer value of 42
         a string value of Hello
         an (x,y) point ad 3.0,5.0
         a movie calledTest,dir. Test
         Hello,Micheal
         */
        
        //注意:Any 类型表示着任何类型,包括可选型.如果在期望为Any类型的地方使用了可选型,将会得到一个警告.此时可以使用as 进行转换.如下:
        let optionalNumber: Int? = 3
        //会有警告
        things.append(optionalNumber)
        things.append(optionalNumber as Any)
    }
    
    // MARK: - Nested Types
    @objc  func NestedTypes()  {
        //1.Nested Types in Action
        struct BlackjackCard {
            //嵌套合适的枚举
            enum Suit:Character {
                case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
            }
            
            
            enum Rank:Int {
                case two = 2,three,four,five,six,seven,eight,nine,ten
                case jack,queen,king,ace
                struct Values {
                    let first :Int,second:Int?
                }
                
                var values:Values {
                    switch self {
                    case .ace:
                        return Values(first: 1, second: 11)
                    case .jack,.queen,.king:
                        return Values(first: 10, second: nil)
                    default:
                        return Values(first: self.rawValue, second: nil)
                    }
                }
            }
            
            let rank:Rank,suit:Suit
            var description:String {
                var outPut = "suit is\(suit.rawValue),"
                outPut += " value is \(rank.values.first)"
                if let second = rank.values.second {
                    outPut += " or \(second)"
                }
                return outPut
            }
        }
        
        let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
        print("the Ace of spades:\(theAceOfSpades.description)")
        //the Ace of spades:suit is♠, value is 1 or 11
        
        let heartSymbol = BlackjackCard.Suit.hearts.rawValue
        print("heartSymbol is: \(heartSymbol)")
        //heartSymbol is: ♡
        
        
        
        
        
   
    }
}
