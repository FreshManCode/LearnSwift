//
//  SWEncapsulateCoreImageVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/9/15.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

//将Filter类型定义为一个函数,该函数接受一个图像作为参数并返回一个新的图像
typealias Filter = (CIImage)->CIImage

typealias MyString = (String)->String

//为组合滤镜自定义运算符.
infix operator >>>

class SWEncapsulateCoreImageVC: SWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "封装CoreImage"
        view.addSubview(tableView)
        listArray.append("CombineBlur")
        listArray.append("KeLiHua")
        tableView.reloadData()
    }
    
    func p_introduce()  {
        /* Core Image 的API 是弱类型的,我们通过键值编码(KVC)来配置图像滤镜(Filter).在使用参数的类型或者名字时,我们都使用
         字符串来进行表示,这十分容易出错.
         
         1.滤镜类型:CIFilter是Core Image的核心类之一,用于创建图像滤镜.如上定义了一个名为Filter 的函数.
         2.构建滤镜:定义好Filter类型之后,接着可以开始定义函数来构建特定的滤镜了.这些函数在接受特定滤镜所需的参数之后,构造
         并返回一个Filter类型的值.它们的基本形态大概都是下面这样:
         func myFilter(...)->Filter
         
         注意:这里的返回值Filter也是一个函数.
         事例1:高斯滤镜
         
         事例2:颜色叠层
         使用两个基础控件:颜色生成滤镜(CIConstantColorGenerator)和图像覆盖合成滤镜(CISourceOcerCompositing).
         */
        let _ = blur(radius: 10)
    }
    
    
    // MARK: - 组合滤镜
    @objc  func CombineBlur()  {
        let image = CIImage(image: UIImage(named: "500x500")!)!
        
        
        //现在我们可以链式将两个滤镜应用到载入的图像上:
        let radius = 5.0
        let color = UIColor.red.withAlphaComponent(0.2)
//      现将图片模糊
        let blurredImage = blur(radius: radius)(image)
//      覆盖红色叠层
        let overaidImage = overlay(color: color)(blurredImage)
        let imagesArray:[UIImage] = [UIImage(ciImage: image),
                                     UIImage(ciImage: blurredImage),
                                     UIImage(ciImage: overaidImage)];
        var imageViewsArray = [UIImageView]()
        
        for image in imagesArray {
            let imageView = UIImageView()
            if imageViewsArray.count > 0 {
                let lastImageView = imageViewsArray.last
                imageView.frame = CGRect(x: 50, y: lastImageView?.frame.maxY ?? 20, width: 150, height: 150)
                
            } else {
                imageView.frame = CGRect(x: 50, y: 100, width: 150, height: 150)
            }
            imageView.image = image
            imageViewsArray.append(imageView)
            tableView.addSubview(imageView)
        }
        
        let name = "liming"
        let greetingLiMing = testGreeting(word: "你好")(name)
        //你好 liming
        print(greetingLiMing)
        
        let named = "liming2"
        let greetingLiMing2 = testGreeting(word: "你好")(named)
        //你好 liming2
        print(greetingLiMing2)
        
        //(Function)
        let greetingTwo = testGreeting(word: "你好")
        print(greetingTwo)
        
        
        //3.复合函数
        //可以将上面的两段代码调用滤镜的表达式简单合为1体
        let result = overlay(color: color)(blur(radius: radius)(image))
        
        //但是由于括号错综复杂,代码不易读.更好的解决方式是构建一个可以将滤镜合二为一的函数:
        let blurAndOverlay = compose(filter: blur(radius: radius), withFilter: overlay(color: color))
        let result1 = blurAndOverlay(image)
        
        //3.1 为了让代码更具可读性,还可以进一步为组合滤镜自定义运算符.
        //现在可以使用 >>> 运算符达到与之前使用compose相同的目的
        let blurAndOverlay2 = blur(radius: radius) >>> overlay(color: color)
        let result2 = blurAndOverlay2(image)
        //由于 >>> 运算符默认是左结合的,因此滤镜将从左到右的顺序被应用到图像上.
    }

    
    func testGreeting(word:String)->MyString  {
        return {
            name in let greeting = "\(word) \(name)"
            return greeting
        }
    }
    
    // MARK: - 柯里化
    @objc  func KeLiHua()  {
        /* 先调用一个函数,该函数返回新的函数(上例是Filter),然后传入另一个参数并调用之前返回的新函数.
         写一个函数返回另一函数,只是为了再次调用被返回的函数.如下两个add 函数:
         下面的add2函数接受第一个参数X之后,返回一个闭包,然后再接受第二个参数y.这与滤镜函数的结构一模一样.
         因为该函数的箭头向右结合,所以可以移除包围在结果函数类型周围的括号.如下add3.
         
         add1和add2的例子展示了如何将一个接受参数的函数变换为一些列只接受单个参数的函数,这个过程被称为柯里化(Currying)
         
         */
        func add1(_ x:Int,_ y:Int)->Int  {
            return x + y
        }
        
        func add2(_ x:Int)->((Int)->(Int))  {
            return {
                y in x + y
            }
        }
        func add3(_ x:Int)->(Int)->Int  {
            return {
                y in x + y
            }
        }
        
        //add1和add2的调用方式区别
        print(add1(2, 3))
        //首先向函数传递一个参数2,然后将返回的函数应用到第二个参数3
        print(add2(2)(3))
    }
   
    
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }

}

/// 定义一个简单的滤镜,高斯模糊滤镜,需要的是一个模糊的半径参数
/// - Parameter radius: 半径
/// - Returns: Filter函数
func blur(radius:Double)->Filter  {
    return {
        //调用的时候需要传递一个image参数
        image in let parameters:[String:Any] = [kCIInputRadiusKey:radius,kCIInputImageKey:image]
        guard let filter = CIFilter(name: "CIGaussianBlur",parameters: parameters) else {
            fatalError()
        }
        guard let outputImage = filter.outputImage else {
            fatalError()
        }
        return outputImage
    }
}

//定义一个生成固定颜色的滤镜
func generate(color:UIColor) ->Filter {
    return {
        _ in let parameters = [kCIInputColorKey:CIColor(cgColor: color.cgColor)]
        guard let filter = CIFilter(name: "CIConstantColorGenerator", parameters: parameters) else {
            fatalError()
        }
        guard let outImage = filter.outputImage else {
            fatalError()
        }
        return outImage
    }
}

//定义合成滤镜
func compositeSourceOver(overlay:CIImage)->Filter  {
    return {
        image in let parameters = [kCIInputBackgroundImageKey:image,kCIInputImageKey:overlay]
        guard let filter = CIFilter(name: "CISourceOverCompositing", parameters: parameters) else {
            fatalError()
        }
        guard let outputImage = filter.outputImage else {
            fatalError()
        }
        //将输出图像裁剪为与输入的图像尺寸一致
        return outputImage.cropped(to: image.extent)
    }
}

//组合两个滤镜来创建颜色叠层滤镜
func overlay(color:UIColor)->Filter  {
    return {
        image in let overlay = generate(color: color)(image).cropped(to: image.extent)
        return compositeSourceOver(overlay: overlay)(image)
    }
}

//将滤镜合二为一
func compose(filter filter1:@escaping Filter,withFilter filter2:@escaping Filter)->Filter  {
    return {
        image in filter2(filter1(image))
    }
}

func >>>(filter1:@escaping Filter,filter2:@escaping Filter) ->Filter  {
    return {
        image in  filter2(filter1(image))
    }
}
