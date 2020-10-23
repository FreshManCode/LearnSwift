//
//  SWDrawChartVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/10/9.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

//在我们的库中将绘制三种类型的元素:椭圆,矩形与文字.利用枚举,可以为这三种情况定义一个数据类型:
enum Primitive {
    case ellipse
    case rectangle
    case text(String)
}

//用来描述图表各类样式属性的数据结构.目前只支持fillColor
enum Attribute {
    case fillColor(UIColor)
}

//图标会用另一个枚举来定义.首先,一个图表可以是一个有确定尺寸的Primitive,即椭圆,矩形或者文字其中之一:
//接着,可以用两个枚举成员来表示一对左右相邻(水平方向)或者上下相邻(垂直方向)的图表.注意一个.beside图表是如何
//被递归定义的---它包含了两个相邻的图表
indirect enum Diagram {
    case primitive(CGSize,Primitive)
    case beside(Diagram,Diagram)
    case below(Diagram,Diagram)
    case attributed(Attribute,Diagram)
    case align(CGPoint,Diagram)
}

//计算与绘制
extension Diagram {
    //除了枚举值beside,below 相对复杂一些,计算数据类型Diagram 的尺寸其实并不难.
    //在值为.beside时,宽度等于两个(被关联的)图表宽度之和,而高度则等于左右图表中较高者的高度.
    var size:CGSize {
        switch self {
        case .primitive(let size, _):
            return size
        case .attributed(_, let x):
            return x.size
        case let .beside(l, r):
            let sizeL = l.size
            let sizeR = r.size
            return CGSize(width: sizeL.width + sizeR.width, height: max(sizeL.height, sizeR.height))
        case let .below(l, r):
            return CGSize(width: max(l.size.width, r.size.width), height: l.size.height + r.size.height)
        case .align(_, let r):
            return r.size
            
        }
    }
    //在开始绘制之前,我们还需要再定义一个fit方法,这个方法确保在某尺寸值(比如某个图表的尺寸)长宽比不变的情况下,将它依据传入的
    //矩形进行缩放.被等比修正的尺寸值在目标矩形中的坐标值则由一个类型为CGPoint的参数alignment传入:如果该CGPoint的X位0表示
    //左对齐,为1则表示右对齐.类似,y为0表示上对齐,为1则表示下对齐
    
    func filled(_ color:UIColor) -> Diagram {
        return .attributed(.fillColor(color), self)
    }
    func aligned(to pisition:CGPoint) -> Diagram {
        return .align(pisition, self)
    }
    
    init() {
        self = rect(width: 0, height: 0)
    }
}

extension Sequence where Iterator.Element == Diagram {
    var hcat:Diagram {
        return reduce(Diagram(), |||)
    }
}

extension CGPoint {
    var size:CGSize {
        return CGSize(width: x, height: y)
    }
    
    static let bottom = CGPoint(x: 0.5, y: 1)
    static let top    = CGPoint(x: 0.5, y: 1)
    static let center = CGPoint(x: 0.5, y: 0.5)
}

extension CGSize {
    var point:CGPoint {
        return CGPoint(x: self.width, y: self.height)
    }
    func fit(into rect:CGRect,alignment:CGPoint)->CGRect  {
        let scale = min(rect.width/width, rect.height / height)
        let targetSize = scale * self
        let spacerSize = alignment.size * (rect.size - targetSize)
        return CGRect(origin: rect.origin + spacerSize.point, size: targetSize)
    }
}

extension CGContext {
    func draw(_ primitive:Primitive,in frame:CGRect)  {
        switch primitive {
        case .rectangle:
            fill(frame)
        case .ellipse:
            fillEllipse(in: frame)
        case .text(let textStr):
            let font = UIFont.systemFont(ofSize: 12)
            let textColor = UIColor.red
            let attributes = [NSAttributedString.Key.font:font,
                              NSAttributedString.Key.foregroundColor:textColor]
            let attributesdText = NSAttributedString(string: textStr, attributes: attributes)
            attributesdText.draw(in: frame)
        }
    }
    
    func draw(_ diagram:Diagram,in bounds:CGRect)  {
        switch diagram {
        case let .primitive(size, primitive):
            let bounds = size.fit(into: bounds, alignment: .center)
            draw(primitive, in: bounds)
        case let .align(alignment, diagram):
            let bounds = diagram.size.fit(into: bounds, alignment: alignment)
            draw(diagram, in: bounds)
        case let .beside(left, right):
            let (lBounds,rBounds) = bounds.split(ratio: left.size.width / diagram.size.width, edge: .minXEdge)
            draw(left, in: lBounds)
            draw(right, in: rBounds)
        case .below(let top, let bottom):
            let (tBounds,bBounds) = bounds.split(ratio: top.size.height/diagram.size.height, edge: .minYEdge)
            draw(top, in: tBounds)
            draw(bottom, in: bBounds)
        case let .attributed(.fillColor(color), diagram):
            saveGState()
            color.set()
            draw(diagram, in: bounds)
            restoreGState()
            
        }
    }
}

extension CGRect {
    func split(ratio:CGFloat,edge:CGRectEdge)->(CGRect,CGRect)  {
        let length = edge.isHorizontal ? width : height
        return divided(atDistance: length * ratio, from: edge)
    }
}

extension CGRectEdge {
    var isHorizontal:Bool {
        return self == .maxXEdge || self == .minXEdge
    }
}



class SWDrawChartVC: SWBaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "图标绘制"
        listArray.append("RemoveImageView")
        listArray.append("DrawSquareAndCircle")
        listArray.append("DrawSquareAndCircleWithFitMethod")
        view.addSubview(tableView)
        tableView.reloadData()
    }
    
    @objc  func RemoveImageView()  {
        imageView.removeFromSuperview()
    }
    
    // MARK: - 绘制正方形和圆
    @objc  func DrawSquareAndCircle()  {
        self.view.addSubview(imageView)
        let bounds = CGRect(origin: .zero, size: CGSize(width: 300, height: 200))
        let render = UIGraphicsImageRenderer(bounds: bounds)
        let image  = render.image { (context) in
            UIColor.blue.setFill()
            context.fill(CGRect(x: 10.0, y: 37.5, width: 15.0, height: 75.0))
            UIColor.red.setFill()
            context.fill(CGRect(x: 25.0, y: 0.0, width: 150.0, height: 150.0))
            UIColor.green.setFill()
            context.cgContext.fillEllipse(in: CGRect(x: 175.0, y: 37.5, width: 75.0, height: 75.0))
        }
        //以上这段代码虽然短小,但是却难以维护.如果想额外再添加一个圆进去呢?
        imageView.image = image
        
    }
    
    

    
    // MARK: - DrawSquareAndCircleWithFitMethod (使用fit方法)
    @objc  func DrawSquareAndCircleWithFitMethod()  {
        let center = CGPoint(x: 0.5, y: 0.5)
        let target = CGRect(x: 0, y: 0, width: 200, height: 100)
        let result = CGSize(width: 1, height: 1).fit(into: target, alignment: center)
        print(result)
        //(50.0, 0.0, 100.0, 100.0)
        
        //如果要与矩形左对齐
        let topLeft = CGPoint(x: 0, y: 0)
        let result2 = CGSize(width: 1, height: 1).fit(into: target, alignment: topLeft)
        print(result2)
        //(0.0, 0.0, 100.0, 100.0)
        
        //既然我们既可以表示图表,又能计算出它们的尺寸,将它们绘制出来也就不成问题了.
        //鉴于绘制总是在相同的上下文中进行,所以我们在CGContext的扩展中定义一个方法draw.
        
        let rect = CGRect(x: 100, y: 100, width: 100, height: 100)
        let textRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        
        UIGraphicsBeginImageContextWithOptions(result.size, true, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.blue.cgColor)
        context?.draw(Primitive.text("ABCDCCCD"), in: textRect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = image
        self.view.addSubview(imageView)
        
        
        
        
        //
    }
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
    lazy var imageView:UIImageView = {
        let view = UIImageView()
        view.center = self.view.center
        view.bounds = CGRect(x: 0, y: 0, width: ScreenW - 10, height: ScreenW - 10)
        return view
    }()
    
}

func *(l:CGFloat,r:CGSize)->CGSize  {
    return CGSize(width: l * r.width, height: l * r.height)
}

func *(l:CGSize,r:CGSize)->CGSize  {
    return CGSize(width: l.width * r.width, height: l.height * r.height)
}

func -(l:CGSize,r:CGSize) -> CGSize {
    return CGSize(width: l.width - r.width, height: l.height - r.height)
}

func +(l:CGPoint,r:CGPoint)->CGPoint {
    return CGPoint(x: l.x + r.x, y: l.y + r.y)
}

func rect(width:CGFloat,height:CGFloat)->Diagram  {
    return .primitive(CGSize(width: width, height: height), .rectangle)
}
func circle(diameter:CGFloat)->Diagram  {
    return .primitive(CGSize(width: diameter, height: diameter), .ellipse)
}
func text(_ theText:String,width:CGFloat,height:CGFloat)->Diagram  {
    return .primitive(CGSize(width: width, height: height), .text(theText))
}
func square(side:CGFloat)->Diagram  {
    return rect(width: side, height: side)
}

precedencegroup HorizontalCombination {
    higherThan:VerticalCombination
    associativity:left
}
precedencegroup VerticalCombination {
    associativity:left
}

infix operator ||| : HorizontalCombination
func  ||| (l:Diagram,r:Diagram)->Diagram  {
    return .beside(l, r)
}

infix operator ---:VerticalCombination
func ---(l:Diagram,r:Diagram) -> Diagram {
    return .below(l, r)
}
