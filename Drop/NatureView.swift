//
//  NatureView.swift
//  Drop
//
//  Created by Melaniia Hulianovych on 3/31/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class NatureView: UIView, CAAnimationDelegate {
    let inset: CGFloat = 60
    var sun: SunLayer?
    var endEngle: Double = 0.01
    var sunPoint: Double = 50
    var sunPosition: Double  {
        get {
            return sunPoint * 0.7 / 100
        }
    }
    var timer: Timer?
    

    override func draw(_ rect: CGRect) {

        
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()

        drawMountains(inRect: rect, inContext: context!, withColorSpace: colorSpace)
        drawSlice(rect: rect, startPercent: 0, endPercent: 50, color: UIColor.white.withAlphaComponent(0.5), inContext: context!, withColorSpace: colorSpace)
        drawSunLayer(rect: rect, inContext: context!, withColorSpace: colorSpace)
        drawVerticalLines(rect: rect, inContext: context!, withColor: UIColor.white.withAlphaComponent(0.5), withColorSpace: colorSpace)
        
    }
    
    func drawMountains(inRect rect:CGRect, inContext context:CGContext, withColorSpace colorSpace:CGColorSpace) {
        
        let space: CGFloat = 50
        let spaceBetweenHills: CGFloat = 3
        let rightPart: CGFloat = 510
        
        let width = rect.width
        let height = rect.height - 5
        let firstHill = CGMutablePath()
        firstHill.move(to: CGPoint(x: 0, y: height))
        firstHill.addLine(to: CGPoint(x: inset, y: height))
        var currentPoint = space
        
        firstHill.addQuadCurve(to: CGPoint(x: space * 2, y: height), control:  CGPoint(x: space + 10 + space / 2, y: height * 0.95))
        firstHill.addLine(to: CGPoint(x: space * 2 + spaceBetweenHills, y: height))
        
        firstHill.addLine(to: CGPoint(x: space * 2 + spaceBetweenHills + 1 - space / 3.8, y: height * 0.975))
        firstHill.addQuadCurve(to: CGPoint(x: space * 4, y: height), control:  CGPoint(x: space * 2 + space * 0.8, y: height * 0.90))
        currentPoint = width - rightPart
        firstHill.addLine(to: CGPoint(x: currentPoint, y: height))
        
        
        firstHill.addQuadCurve(to: CGPoint(x: currentPoint + space * 3 - 12, y: height * 0.95), control:  CGPoint(x:currentPoint + (space * 3) * 0.6, y: height * 0.85))
        currentPoint = currentPoint + space * 3
        firstHill.addLine(to: CGPoint(x: currentPoint - space / 2, y: height))
        firstHill.addLine(to: CGPoint(x: currentPoint - space / 2 + spaceBetweenHills, y: height))
        currentPoint = currentPoint - space / 2 + spaceBetweenHills
        firstHill.addQuadCurve(to: CGPoint(x: width - space - 10 - 2, y: height), control:  CGPoint(x:currentPoint + space * 6 / 2, y: height * 0.44))
        firstHill.addLine(to: CGPoint(x: width - space - 10 + 2, y: height))
        firstHill.addQuadCurve(to: CGPoint(x: width - 10, y: height), control:  CGPoint(x:width - space + space * 0.3, y: height * 0.95))
        firstHill.addLine(to: CGPoint(x: width, y: height))
        firstHill.addLine(to: CGPoint(x: width, y: height + 1))
        firstHill.addLine(to: CGPoint(x: 0, y: height + 1))
        firstHill.addLine(to: CGPoint(x: 0, y: height))

        let myImage = UIImage(named: "sheep")
        let sheepSize = CGSize(width: 30, height: 30)
        let frame = CGRect(x: currentPoint + space * 6 / 2 - 15, y: rect.height - rect.height / 11 * 3 - sheepSize.height * 1.2, width: sheepSize.width, height: sheepSize.width)
        
        UIGraphicsPushContext(context)
        
        let newImage = myImage?.imageWithColor(color1: UIColor.white.withAlphaComponent(0.5))
        newImage?.draw(in: frame)
        UIGraphicsPopContext()

        context.addPath(firstHill)
        
        context.setFillColor(UIColor.white.withAlphaComponent(0.5).cgColor)
        context.fillPath()
        
        context.setFillColorSpace(colorSpace)
        
        context.saveGState()
    }
    
    
    private func drawSlice(rect: CGRect, startPercent: CGFloat, endPercent: CGFloat, color: UIColor, inContext context: CGContext, withColorSpace colorSpace:CGColorSpace) {
        
        color.setStroke()
        
        let circleCenter = CGPoint(x: rect.width / 2, y: rect.height * 1)
        let circleRadius = (rect.width - 110) / 2
        let decimalInput = 0.5
        let start = CGFloat(2 * M_PI_2)
        let end = start + CGFloat(3 * M_PI * decimalInput)
        let circlePath = UIBezierPath(arcCenter: circleCenter, radius: circleRadius, startAngle: start, endAngle: end, clockwise: true)
        circlePath.close()
        circlePath.lineWidth = 2
        let pattern: [CGFloat] = [6.0, 6.0]
        circlePath.setLineDash(pattern, count: 2, phase: 0.0)
        circlePath.stroke()
        
        //        let circleCenter = CGPoint(x: bounds.width / 2, y: bounds.height * 1.1)
        //        let circleRadius = (bounds.width - 110) / 2
        //        let decimalInput = 0.4
        //        let start = CGFloat(2 * M_PI_2)
        
        
        //        context.restoreGState()
        //        let rectone = CGRect(x: inset, y: rect.height / 2, width: rect.width - inset * 2, height: rect.height)
        //        context.addEllipse(in: rectone)
        //        context.setLineWidth(2)
        //        context.setLineDash(phase: 0.0, lengths: [6.0, 6.0])
        //        context.setStrokeColor(UIColor.white.withAlphaComponent(0.5).cgColor)
        //        context.strokePath()
        //        context.saveGState()
        //        context.closePath()
        //        context.setFillColorSpace(colorSpace)
        
        
        context.restoreGState()
        
        let radius: CGFloat = 10
        
        
        context.setFillColor(UIColor(colorLiteralRed: 253/255, green: 206/255, blue: 84/255, alpha: 1.0).cgColor)
        context.addEllipse(in: CGRect(x: inset - radius / 2, y: rect.height - radius, width: radius, height: radius))
        context.addEllipse(in: CGRect(x: rect.width - inset - radius / 2, y: rect.height - radius, width: radius, height: radius))
        context.fillPath()
        context.setFillColorSpace(colorSpace)
        context.closePath()
        context.saveGState()
        
        
    }
    
    func drawSunLayer(rect: CGRect, inContext context: CGContext, withColorSpace colorSpace:CGColorSpace) {
        if sun == nil {
            let radius: CGFloat = 60
            sun = SunLayer(CGRect(x: inset - radius / 2, y: bounds.height - radius * 0.6, width: radius, height: radius))
            self.layer.addSublayer(sun!)
        }
        else {
            update(rect: rect, inContext: context, withColorSpace: colorSpace)
        }
        
    }
    
    func update(rect: CGRect, inContext context: CGContext, withColorSpace colorSpace:CGColorSpace) {
        
        let circleCenterX = CGPoint(x: bounds.width / 2, y: bounds.height * 1)
        let circleRadiusX = (bounds.width - 110) / 2
        let decimalInputX = 0.5
        let start = CGFloat(2 * M_PI_2)
        
        let endYellow = start + CGFloat(3 * M_PI * decimalInputX * endEngle)
        
        UIColor(colorLiteralRed: 253/255, green: 206/255, blue: 84/255, alpha: 1.0).setStroke()

        let circlePathYellow = UIBezierPath(arcCenter: circleCenterX, radius: circleRadiusX, startAngle: start, endAngle: endYellow, clockwise: true)
        circlePathYellow.lineWidth = 2.0
        let pattern: [CGFloat] = [6.0, 6.0]
        
        circlePathYellow.setLineDash(pattern, count: 2, phase: 0.0)
        
        endEngle += 0.02


        circlePathYellow.stroke()
        if endEngle > sunPosition {
            print("invalidate - \(endEngle)")
            endEngle = 0.0
            timer?.invalidate()
            return
        }
        
//                        let anim1 = CAKeyframeAnimation(keyPath:#keyPath(CALayer.position))
//                anim1.path = circlePathYellow.cgPath
//                anim1.calculationMode = kCAAnimationPaced
//                anim1.duration = 0.1
//                anim1.delegate = self
//                anim1.fillMode = kCAFillModeForwards
//                anim1.isRemovedOnCompletion = false
//                sun?.add(anim1, forKey: anim1.keyPath)
        
        sun?.position = CGPoint(x: circlePathYellow.currentPoint.x, y: circlePathYellow.currentPoint.y)
        if timer == nil || !(timer?.isValid)! {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(addSunAnimation), userInfo: nil, repeats: true)
        }
       
    }
    
    func drawVerticalLines(rect: CGRect, inContext context: CGContext, withColor color: UIColor, withColorSpace colorSpace:CGColorSpace) {
        
        let yPoint = rect.height - rect.height / 14 * 3


        
        for i in 1...10 {
            let yPoint1 = rect.height - rect.height / 14 * CGFloat(i)
            let path1 = CGMutablePath()
            path1.move(to: CGPoint(x: 0, y: yPoint1))
            path1.addLine(to: CGPoint(x: 10, y: yPoint1))
            context.addPath(path1)
        }
   context.setLineWidth(2)
        context.setStrokeColor(UIColor.white.withAlphaComponent(0.5).cgColor)
        context.strokePath()
        context.saveGState()
        
        
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: yPoint))
        path.addLine(to: CGPoint(x: rect.width, y: yPoint))
        context.addPath(path)
        
      
        context.setLineDash(phase: 0.0, lengths: [2.0, 4.0])
        context.strokePath()
        context.closePath()
    }
    
    func addSunAnimation() {
        setNeedsDisplay()
    }

    
//    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//        guard let newPoint = sun?.presentation()?.position else { sun?.removeAllAnimations(); return }
//        sun?.position = newPoint
//        sun?.removeAllAnimations()
//        

    
}
