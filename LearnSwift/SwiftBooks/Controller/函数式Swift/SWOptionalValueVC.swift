//
//  SWOptionalValueVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/9/21.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWOptionalValueVC: SWBaseViewController {
    
    let content1 = "闲暇之余，开启全栈业余生活。先给老家做个信息发布的APP。第一版着急上线还有待完善，以后有时间持续更新，感谢关注。"
    let content2 = "9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》（以下简称《办法》）正式发布。在《办法》中明确提出，将之前“以北京大学、清华大学为试点，探索建立对本科阶段为国内高水平大学的应届毕业生，符合基本申报条件可直接落户”的政策，范围扩大至在沪“世界一流大学建设高校”。"
    let content3 = "9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》（以下简称《办法》）正式发布。在《办法》中明确提出，将之前“以北京大学、清华大学为试点，探索建立对本科阶段为国内高水平大学的应届毕业生，符合基本申报条件可直接落户”的政策，范围扩大至在沪“世界一流大学建设高校”。9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》"
    let content4 = "9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》（以下简称《办法》）正式发布。在《办法》中明确提出，将之前“以北京大学、清华大学为试点，探索建立对本科阶段为国内高水平大学的应届毕业生，符合基本申报条件可直接落户”的政策，范围扩大至在沪“世界一流大学建设高校”。9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》"
    let content5 = "9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》（以下简称《办法》）正式发布。在《办法》中明确提出，将之前“以北京大学、清华大学为试点，探索建立对本科阶段为国内高水平大学的应届毕业生，符合基本申报条件可直接落户”的政策，范围扩大至在沪“世界一流大学建设高校”。9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》"
    let content6 = "9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》（以下简称《办法》）正式发布。在《办法》中明确提出，将之前“以北京大学、清华大学为试点，探索建立对本科阶段为国内高水平大学的应届毕业生，符合基本申报条件可直接落户”的政策，范围扩大至在沪“世界一流大学建设高校”。9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》"
    let content7 = "9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》（以下简称《办法》）正式发布。在《办法》中明确提出，将之前“以北京大学、清华大学为试点，探索建立对本科阶段为国内高水平大学的应届毕业生，符合基本申报条件可直接落户”的政策，范围扩大至在沪“世界一流大学建设高校”。9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》"
    let content8 = "9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》（以下简称《办法》）正式发布。在《办法》中明确提出，将之前“以北京大学、清华大学为试点，探索建立对本科阶段为国内高水平大学的应届毕业生，符合基本申报条件可直接落户”的政策，范围扩大至在沪“世界一流大学建设高校”。9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》"
    let content9 = "9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》（以下简称《办法》）正式发布。在《办法》中明确提出，将之前“以北京大学、清华大学为试点，探索建立对本科阶段为国内高水平大学的应届毕业生，符合基本申报条件可直接落户”的政策，范围扩大至在沪“世界一流大学建设高校”。9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》"
    let content10 = "9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》（以下简称《办法》）正式发布。在《办法》中明确提出，将之前“以北京大学、清华大学为试点，探索建立对本科阶段为国内高水平大学的应届毕业生，符合基本申报条件可直接落户”的政策，范围扩大至在沪“世界一流大学建设高校”。9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》"
    let content11 = "9月23日，《2020年非上海生源应届普通高校毕业生进沪就业申请本市户籍评分办法》（以下简称《办法》）正式发布。在《办法》中明确提出，将之前“以北京大学、清华大学为试点，探索建立对本科阶段为国内高水平大学的应届毕业生，符合基本申报条件可直接落户”的政策，范围扩大至在沪“世界一流大学建设高校”。"
    
    var contentArray = [String]()
    
    override func viewDidLoad() {
        contentArray.append(content1)
        contentArray.append(content2)
        contentArray.append(content3)
        contentArray.append(content4)
        contentArray.append(content5)
        contentArray.append(content6)
        contentArray.append(content7)
        contentArray.append(content8)
        contentArray.append(content9)
        contentArray.append(content10)
        contentArray.append(content11)
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SWOptionalValueCell", bundle: nil),
                           forCellReuseIdentifier: "SWOptionalValueCell")
        self.title = "可选值"
        view.addSubview(tableView)
        listArray.append("Sample")
        listArray.append("OpenWexWalletHome")
        listArray.append("OpenWexWalletAsset")
        tableView.reloadData()
    }
    
    
    // MARK: - Sample 案例研究
    @objc  func Sample()  {
        //案例研究:字典
        //字典是键值对的集合,它提供了一个有效的方法来查询与某个关联的值.
        let cities = ["Paris":2241,"Madrid":3165,"Amsterdam":827,"Berlin":356]
        //Swift 给!运算符提供了一个更安全的替代,?? 运算符.使用这个运算符时,需要额外提供一个默认值,当运算符被运用于nil时
        //这个默认值将作为返回值.
        
        //2.玩转可选值
        //2.1 可选链
        struct Order {
            let orderNumber :Int
            let person :Person?
        }
        
        struct Person {
            let name:String
            let address:Address?
        }
        
        struct Address {
            let streetName:String
            let city : String
            let state: String?
        }
        
        let order = Order(orderNumber: 42, person: nil)
        //给定一个order,如何才能知道客户地址中的state为何值呢?
        if let myState = order.person?.address?.state {
            print("This order will be shipped to \(myState)")
        } else {
            print("Unknown person,address,or state")
        }
        
        //3.分支上的可选值
        //Switch,guard
        func populationDescription(for city:String)->String?  {
            guard let population = cities[city] else { return nil }
            return "The population of Madrid is \(population)"
        }
        
        func increment(optional:Int?)->Int?  {
            guard let x = optional else { return nil }
            return x + 1
        }
        //可以使用map函数来重写increment(optional:),如下:
        func increment2(optional:Int?)->Int?  {
            return optional.map({$0 + 1})
        }
        
        let capitals = [
        "France": "Paris",
        "Spain": "Madrid",
        "The Netherlands": "Amsterdam",
        "Belgium": "Brussels"
        ]
        //为了编写一个能返回给定国家首都人口数量的函数,我们将Capitals字典与之前定义的cities字典结合.对于
        //每一次字典查询,我们必须确保它返回一个结果:
        func populationOfCaptial(country:String)->Int?  {
            guard let captial = capitals[country],let population = cities[captial] else { return nil }
            return population * 1000
        }
        
    }
    
    @objc  func OpenWexWalletHome()  {
        let URLScheme = "WexSinaPayInsurance://WexSinaPayInsuranceHome"
        openURL(url: URLScheme)
    }
    
    @objc  func OpenWexWalletAsset()  {
        let URLScheme = "WexSinaPayInsurance://WexSinaPayInsuranceAsset"
        openURL(url: URLScheme)
    }
    
    func openURL(url:String)  {
        let url = NSURL(string: url) as URL?
        if let myURL = url {
            UIApplication.shared.open(myURL, options: [:]) { (isSuccess) in
                printLog(isSuccess ? "openURLSuccess" : "openURLFailure", logError: isSuccess)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count + contentArray.count
    }
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let count = listArray.count
        
        if indexPath.row >= count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SWOptionalValueCell",
                                                     for: indexPath) as! SWOptionalValueCell;
            cell.set(name: "王伟", sex: "男", content: contentArray[indexPath.row - count])
            return cell
        }
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
}

extension Optional {
    //map函数接受一个类型为(Wrapped)->U的transform函数作为参数.如果可选值不是nil,map将会将其作为参数来调用transform
    func map<U>(_ transform:(Wrapped)->U) ->U? {
        guard let x = self else { return nil }
        return transform(x)
    }
}
