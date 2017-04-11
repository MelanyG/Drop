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
//    var moonEdge = 1.0
    var sunPoint: Double = 50
    var sunPosition: Double  {
        get {
            return sunPoint * 0.7 / 100
        }
    }
    
    var moonPhase: CALayer!
    var timer: Timer?
    var moonTimer: Timer?
    let bigMill = WindmillLayer()
    let smallMill = WindmillLayer()
    let sizeWindMill = CGSize(width: 200.0, height: 200.0)
    let sizeWindMillSmall = CGSize(width: 150.0, height: 150.0)
    override func draw(_ rect: CGRect) {
        
        
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        drawMountains(inRect: rect, inContext: context!, withColorSpace: colorSpace)
        drawSlice(rect: rect, startPercent: 0, endPercent: 50, color: UIColor.white.withAlphaComponent(0.5), inContext: context!, withColorSpace: colorSpace)
        drawSunLayer(rect: rect, inContext: context!, withColorSpace: colorSpace)
        drawVerticalLines(rect: rect, inContext: context!, withColor: UIColor.white.withAlphaComponent(0.5), withColorSpace: colorSpace)
        
        addWindMill(inRect: CGRect(x: 220, y: rect.height, width: 250, height: 250), inContext: context!, withColorSpace: colorSpace)
        
        drawMoonPhase(inRect:  CGRect(x: rect.width - rect.width / 3, y: 100, width: 70, height: 70), inContext: context!)
        
//        drawMoon(inRect:  CGRect(x: rect.width - rect.width / 3, y: 100, width: 70, height: 70), inContext: context!)
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
        firstHill.addQuadCurve(to: CGPoint(x: width - space - 10 - 2, y: height), control:  CGPoint(x:currentPoint + space * 6 / 2, y: 220))
        firstHill.addLine(to: CGPoint(x: width - space - 10 + 2, y: height))
        firstHill.addQuadCurve(to: CGPoint(x: width - 10, y: height), control:  CGPoint(x:width - space + space * 0.3, y: height * 0.95))
        firstHill.addLine(to: CGPoint(x: width, y: height))
        firstHill.addLine(to: CGPoint(x: width, y: height + 1))
        firstHill.addLine(to: CGPoint(x: 0, y: height + 1))
        firstHill.addLine(to: CGPoint(x: 0, y: height))
        
        let myImage = UIImage(named: "sheep")
        let sheepSize = CGSize(width: 30, height: 30)
        let frame = CGRect(x: currentPoint + space * 6 / 2 - 15, y: 364 - sheepSize.height * 1.2, width: sheepSize.width, height: sheepSize.width)
        
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
        context.addEllipse(in: CGRect(x: inset - radius, y: rect.height - radius, width: radius, height: radius))
        context.addEllipse(in: CGRect(x: rect.width - inset, y: rect.height - radius, width: radius, height: radius))
        context.fillPath()
        context.setFillColorSpace(colorSpace)
        context.closePath()
        context.saveGState()
        
        
    }
    
    func drawSunLayer(rect: CGRect, inContext context: CGContext, withColorSpace colorSpace:CGColorSpace) {
        if sun == nil {
            let radius: CGFloat = 60
            sun = SunLayer(CGRect(x: inset - radius / 2 - 5, y: bounds.height - radius * 0.6, width: radius, height: radius))
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
        let start = CGFloat(Double.pi)
        
        let endYellow = start + CGFloat(3 * Double.pi * decimalInputX * endEngle)
        
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
//            moonTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateMoonPhase), userInfo: nil, repeats: true)
        }
        
    }
    
    func drawVerticalLines(rect: CGRect, inContext context: CGContext, withColor color: UIColor, withColorSpace colorSpace:CGColorSpace) {
        
        let yPoint = rect.height - rect.height / 14 * 3
        
        
        
        for i in 1...10 {
            let yPoint1 = rect.height - rect.height / 14 * CGFloat(i)
            let path1 = CGMutablePath()
            path1.move(to: CGPoint(x: 0, y: yPoint1))
            path1.addLine(to: CGPoint(x: 12, y: yPoint1))
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
    
    func addWindMill(inRect rect: CGRect, inContext ctx:CGContext, withColorSpace colorSpace:CGColorSpace) {
        
        ctx.restoreGState()
        let bottomWidth: CGFloat = 14
        
        let bottom = CGMutablePath()
        bottom.move(to: CGPoint(x:rect.origin.x - bottomWidth / 2, y: rect.origin.y - 6))
        bottom.addLine(to: CGPoint(x:rect.origin.x + bottomWidth / 2, y: rect.origin.y - 6))
        bottom.addLine(to: CGPoint(x:rect.origin.x + bottomWidth / 3, y: rect.origin.y - sizeWindMill.height + 100))
        bottom.addLine(to: CGPoint(x:rect.origin.x, y: rect.origin.y - sizeWindMill.height + 50))
        bottom.addLine(to: CGPoint(x:rect.origin.x - bottomWidth / 3 , y: rect.origin.y - sizeWindMill.height + 100))
        bottom.addLine(to: CGPoint(x:rect.origin.x - bottomWidth / 2, y: rect.origin.y - 6))
        
        ctx.addPath(bottom)
        
        
        let smallWidth: CGFloat = 10
        
        let small = CGMutablePath()
        small.move(to: CGPoint(x:rect.origin.x + sizeWindMillSmall.width * 1.2 - smallWidth / 2, y: rect.origin.y - 6))
        small.addLine(to: CGPoint(x:rect.origin.x  + sizeWindMillSmall.width * 1.2 + smallWidth / 2, y: rect.origin.y - 6))
        small.addLine(to: CGPoint(x:rect.origin.x + sizeWindMillSmall.width * 1.2 + smallWidth / 3, y: rect.origin.y - sizeWindMillSmall.height + 80))
        small.addLine(to: CGPoint(x:rect.origin.x + sizeWindMillSmall.width * 1.2, y: rect.origin.y - sizeWindMillSmall.height + 30))
        small.addLine(to: CGPoint(x:rect.origin.x + sizeWindMillSmall.width * 1.2 - smallWidth / 3 , y: rect.origin.y - sizeWindMillSmall.height + 80))
        small.addLine(to: CGPoint(x:rect.origin.x + sizeWindMillSmall.width * 1.2 - smallWidth / 2, y: rect.origin.y - 6))
        
        ctx.addPath(small)
        
        ctx.setLineWidth(4.0)
        ctx.setLineCap(.round)
        ctx.setLineJoin(.round)
        ctx.setStrokeColor(UIColor.white.cgColor)
        
        ctx.strokePath()
        if (bigMill.animation(forKey: "transform.rotation.z") == nil) {
            addWindAnimation(inRect: rect)
        }
        
        
    }
    
    func updateMoonPhase() {
//        moonEdge -= 0.1
        moonPhase = moonMask(in: CGRect(x: bounds.width - bounds.width / 3, y: 100, width: 70, height: 70), forProgress: 0.9)
//        if moonEdge < 0 {
            moonTimer?.invalidate()
//        }
    }

    
    
    func drawMoonPhase(inRect rect:CGRect, inContext context: CGContext) {
        let moonLayer = CAShapeLayer()
        moonLayer.path = UIBezierPath(ovalIn: rect).cgPath
        moonLayer.fillColor = UIColor.clear.cgColor
        moonLayer.strokeColor = UIColor.white.cgColor
        moonLayer.lineWidth = 2
//        moonLayer.shadowColor = UIColor.white.cgColor
//        moonLayer.shadowOpacity = 1
//        moonLayer.shadowRadius = 10
//        moonLayer.shadowPath = moonLayer.path
//        moonLayer.shadowOffset = .zero
        
        layer.addSublayer(moonLayer)
        
        moonPhase = moonMask(in: rect, forProgress: 0.9)
//        moonPhase.shadowColor = UIColor.white.cgColor
//        moonPhase.shadowOpacity = 1
//        moonPhase.shadowRadius = 10
//        moonPhase.shadowPath = moonLayer.path
//        moonPhase.shadowOffset = .zero

        moonLayer.addSublayer(moonPhase)
//
//        moonLayer.mask = circleShape
//        let animation =  CABasicAnimation(keyPath: "transform.rotation.z")
//        //        animation.fromValue = @(0);
//        animation.toValue = 2 * Double.pi
//        animation.repeatCount = Float(CGFloat.infinity)
//        animation.duration = 5.0
//        
//        moonPhase.add(animation, forKey:"rotation")
        
//        var transform = CATransform3DIdentity
//        transform.m34 = 1.0 / 500.0
//        view.layer.transform = transform

//        let offcet: CGFloat = 50
//        let animation = CABasicAnimation(keyPath: "transform")
//        animation.toValue = transform
//        animation.duration = 3
//        
//        circleShape.add(animation, forKey: "transform")
        
        //        let moon = CGMutablePath()
//        moon.addEllipse(in: rect)
//        context.addPath(moon)
//        context.setStrokeColor(UIColor.white.cgColor)
//        context.setLineWidth(3.0)
//        context .strokePath()
//        context.closePath()
//        let offcet: CGFloat = 50
//        moonLayer.addSublayer(circleShape)
        
        //        circlePath.move(to: CGPoint(x: rect.midX, y: rect.origin.y))
//        circlePath.addCurve(to: CGPoint(x: rect.midX, y: rect.origin.y + rect.height),
//                            controlPoint1: CGPoint(x: rect.midX + offcet * 0.3, y:  rect.midY - 32),
//                            controlPoint2: CGPoint(x: rect.midX + offcet * 0.3, y:  rect.midY + 32))
//        circlePath.addCurve(to: CGPoint(x: rect.midX, y: rect.origin.y),
//                            controlPoint1: CGPoint(x: rect.midX - 50 , y:  rect.midY - 32),
//                            controlPoint2: CGPoint(x: rect.midX - 50, y:  rect.midY + 32))
//        circlePath.fill()
//        let moonChange = CGMutablePath()
//        moonChange.move(to: CGPoint(x:rect.width / 2, y: 0) )
//        moonChange.addQuadCurve(to: CGPoint(x:rect.width / 2, y: rect.height), control: CGPoint(x: rect.width * 2, y:rect.height / 2))
//        context.addPath(moonChange)
//        context.setStrokeColor(UIColor.white.cgColor)
//        context.setLineWidth(3.0)
//        context .strokePath()
//        context.closePath()
//        let moon = CAShapeLayer()
//        moon.frame = rect
//        moon.backgroundColor = UIColor.white.cgColor
//        moon.cornerRadius = 50
//        
//        self.layer.addSublayer(moon)
//        
//        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
//        scaleAnimation.duration = 0.2
//        scaleAnimation.repeatCount = HUGE
//        scaleAnimation.autoreverses = true
//        scaleAnimation.fromValue = 1.2
//        scaleAnimation.toValue = 0.8
//        
//        moon.add(scaleAnimation, forKey: scaleAnimation.keyPath)
        
        
    }
    
    func moonMask(in rect: CGRect, forProgress progress: CGFloat)->CALayer {
        let path = CGMutablePath()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        
        let relativeProgress = (max(min(progress, 1), 0) - 0.5) * 2
        let radius = rect.width/2
        
        let tgX = rect.midX+(relativeProgress * (radius*4/3))
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY), control1: CGPoint(x: tgX, y: rect.minY), control2: CGPoint(x: tgX, y: rect.maxY))
        path.addArc(center: center, radius: rect.width/2, startAngle: .pi/2, endAngle: .pi*3/2, clockwise: false)
        //path.closeSubpath()
        
        let mask = CAShapeLayer()
        mask.path = path
        mask.fillColor = UIColor.white.cgColor
        
        return mask
    }
    
    func addWindAnimation(inRect rect: CGRect) {
        
        
        bigMill.frame = CGRect(origin:CGPoint(x:rect.origin.x - sizeWindMill.width / 2, y: rect.origin.y - sizeWindMill.height * 1.35),size: sizeWindMill)
        bigMill.setNeedsDisplay()
        self.layer.addSublayer(bigMill)
        
        
        smallMill.frame = CGRect(origin:CGPoint(x:rect.origin.x + sizeWindMillSmall.width * 0.7, y: rect.origin.y - sizeWindMillSmall.height * 1.4),size: sizeWindMillSmall)
        smallMill.setNeedsDisplay()
        self.layer.addSublayer(smallMill)
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = Double.pi * 2.0
        
        rotationAnimation.duration = 10
        
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = Float.infinity
        
        bigMill.add(rotationAnimation, forKey: rotationAnimation.keyPath)
        
        smallMill.add(rotationAnimation, forKey: rotationAnimation.keyPath)
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
