//
//  SWLevelMeterView.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/22.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWLevelMeterView: UIView {

    var level:CGFloat?
    var peakLevel:CGFloat?
    
    private var ledCount:Int?
    private var ledBackgroundcolor:UIColor?
    private var ledBordercolor:UIColor?
    private var colorThresHolds:[THLevelMeterColorThreshold]?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetLevelMeter()  {
        self.level = 0.0
        self.peakLevel = 0.0
        self.setNeedsDisplay()
    }
    
    private func initUI () {
        self.backgroundColor = .clear
        self.ledCount = 20
        self.ledBackgroundcolor = UIColor.init(white: 0.0, alpha: 0.35)
        self.ledBordercolor = .black
        
        let greenColor = UIColor(red: 0.458, green: 1.0, blue: 0.396, alpha: 1.0)
        let yellowColor = UIColor(red:1.0, green: 0.93, blue: 0.316, alpha: 1.0)
        let redColor = UIColor(red: 1.0, green:0.325, blue: 0.326, alpha: 1.0)
        self.colorThresHolds = [
            THLevelMeterColorThreshold(maxValue: 0.5, color: greenColor, name: "green"),
            THLevelMeterColorThreshold(maxValue: 0.8, color: yellowColor, name: "yellow"),
            THLevelMeterColorThreshold(maxValue: 1.0, color: redColor, name: "red"),
        ]
    }
    
    override func draw(_ rect: CGRect) {
        guard let _ = self.ledCount else {return}
        guard let _ = self.peakLevel else { return }
        guard let _ = self.colorThresHolds else {return}
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: self.height);
        context.rotate(by: -(.pi/2))
        let bounds = CGRect(x: 0, y: 0, width: self.height, height: self.width)
        var lightMinValue:CGFloat = 0.0
        var peakLED = -1
        if self.peakLevel! > 0.0 {
            peakLED = Int (self.peakLevel! * CGFloat(self.ledCount!))
            if peakLED >= self.ledCount! {
                peakLED = self.ledCount! - 1
            }
        }
        
        
        for ledIndex in 0 ..< ledCount! {
            var ledColor = colorThresHolds![0].color
            let ledMaxValue : CGFloat = CGFloat(ledIndex + 1) / CGFloat(self.ledCount!)
            for colorIndex in 0 ..< colorThresHolds!.count - 1 {
                let currentThresold = colorThresHolds![colorIndex]
                let nextThresold = colorThresHolds![colorIndex + 1]
                if currentThresold.maxValue! <= ledMaxValue  {
                    ledColor = nextThresold.color
                }
            }
            
            let height = bounds.size.height
            let width = bounds.size.width
            
            let ledRect = CGRect(x: 0,
                                 y: height * CGFloat(ledIndex) / CGFloat(ledCount!),
                                 width: width,
                                 height: height * 1.0/CGFloat(ledCount!))
            context.setFillColor(ledBackgroundcolor!.cgColor)
            context.fill(ledRect)
            
            var lightIntensity:CGFloat
            if ledIndex == peakLED {
                lightIntensity = 1.0
            } else {
                lightIntensity = clamp(intensity: (level! - lightMinValue)/(ledMaxValue - lightMinValue))
            }
            
            var fillcolor:UIColor?
            if lightIntensity == 1.0 {
                fillcolor = ledColor!
            } else if (lightIntensity >= 0.0) {
                let color = ledColor!.cgColor.copy(alpha: lightIntensity);
                fillcolor = UIColor.init(cgColor: color!)
            }
            context.setFillColor(fillcolor!.cgColor)
            let bezierPath = UIBezierPath.init(roundedRect: ledRect, cornerRadius: 2.0)
            context.addPath(bezierPath.cgPath)
            
            context.setStrokeColor(ledBordercolor!.cgColor)
            let rect = ledRect.insetBy(dx: 0.5, dy: 0.5)
            let strokePath = UIBezierPath(roundedRect:rect , cornerRadius: 2.0)
            context.addPath(strokePath.cgPath)
            
            context.drawPath(using: .fillStroke)
            lightMinValue = ledMaxValue
        }
       

    }
    
    func clamp(intensity:CGFloat) -> CGFloat {
        if intensity < 0.0 {
            return 0.0
        }
        else if intensity >= 1.0 {
            return intensity
        }
        return intensity
    }

}
