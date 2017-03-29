//
//  WavesLayer.swift
//  Drop
//
//  Created by Melaniia Hulianovych on 3/29/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class WavesLayer: CAShapeLayer {
    
    let animationDuration: CFTimeInterval = 1.18
    
    override init() {
        super.init()
        fillColor = UIColor(red: 46.0 / 255.0, green: 117.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0).cgColor
        path = arcPathStarting.cgPath
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(in ctx: CGContext) {

        contentsScale = UIScreen.main.scale


//        let path = CGMutablePath()

        ctx.addPath(seashelfStart)
        
        ctx.setLineWidth(2.0)
        ctx.setLineCap(.round)
        ctx.setStrokeColor(UIColor.white.cgColor)
        ctx.setFillColor(UIColor(colorLiteralRed: 161/255, green: 218/255, blue: 253/255, alpha: 1.0).cgColor)
        ctx.strokePath()

            
            ctx.fillPath()

        
        
        ctx.setStrokeColorSpace(CGColorSpaceCreateDeviceRGB())
    }
    var width: CGFloat {
    return bounds.size.width / 8
    }
    var height: CGFloat {
        return bounds.size.height / 8
    }
    var seashelfStart: CGPath {
        let arcPath = CGMutablePath()
        arcPath.move(to: CGPoint(x: 0, y: 0))
        arcPath.addQuadCurve(to: CGPoint(x:width, y:0), control: CGPoint(x:width / 2, y: height))
        arcPath.addQuadCurve(to: CGPoint(x:width * 2, y:0), control: CGPoint(x: width + width / 2, y: height))
        arcPath.addQuadCurve(to: CGPoint(x:width * 3, y:0), control: CGPoint(x: width * 2 + width / 2, y: height))
        arcPath.addQuadCurve(to: CGPoint(x:width * 4, y:0), control: CGPoint(x: width * 3 + width / 2, y: height))
        arcPath.addQuadCurve(to: CGPoint(x:width * 5, y:0), control: CGPoint(x: width * 4 + width / 2, y: height))
        arcPath.addQuadCurve(to: CGPoint(x:width * 6, y:0), control: CGPoint(x: width * 5 + width / 2, y: height))
        arcPath.addQuadCurve(to: CGPoint(x:width * 7, y:0), control: CGPoint(x: width * 6 + width / 2, y: height))
        arcPath.addQuadCurve(to: CGPoint(x:bounds.size.width, y:0), control: CGPoint(x: width * 7 + width / 2, y: height))
        return arcPath
    }
    
    var arcPathPre: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 99.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 99.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        return arcPath
    }
    
    var arcPathStarting: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 80.0))
        arcPath.addCurve(to: CGPoint(x: 100.0, y: 80.0), controlPoint1: CGPoint(x: 30.0, y: 70.0), controlPoint2: CGPoint(x: 40.0, y: 90.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        return arcPath
    }
    
    var arcPathLow: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 60.0))
        arcPath.addCurve(to: CGPoint(x: 100.0, y: 60.0), controlPoint1: CGPoint(x: 30.0, y: 65.0), controlPoint2: CGPoint(x: 40.0, y: 50.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        return arcPath
    }
    
    var arcPathMid: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 40.0))
        arcPath.addCurve(to: CGPoint(x: 100.0, y: 40.0), controlPoint1: CGPoint(x: 30.0, y: 30.0), controlPoint2: CGPoint(x: 40.0, y: 50.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        return arcPath
    }
    
    var arcPathHigh: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 20.0))
        arcPath.addCurve(to: CGPoint(x: 100.0, y: 20.0), controlPoint1: CGPoint(x: 30.0, y: 25.0), controlPoint2: CGPoint(x: 40.0, y: 10.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        return arcPath
    }
    
    var arcPathComplete: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: -5.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: -5.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        return arcPath
    }
    
    func animate() {
        let arcAnimationPre: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationPre.fromValue = arcPathPre.cgPath
        arcAnimationPre.toValue = arcPathStarting.cgPath
        arcAnimationPre.beginTime = 5.8
        arcAnimationPre.duration = animationDuration
        
        let arcAnimationLow: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationLow.fromValue = arcPathStarting.cgPath
        arcAnimationLow.toValue = arcPathLow.cgPath
        arcAnimationLow.beginTime = arcAnimationPre.beginTime + arcAnimationPre.duration
        arcAnimationLow.duration = animationDuration
        
        let arcAnimationMid: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationMid.fromValue = arcPathLow.cgPath
        arcAnimationMid.toValue = arcPathMid.cgPath
        arcAnimationMid.beginTime = arcAnimationLow.beginTime + arcAnimationLow.duration
        arcAnimationMid.duration = animationDuration
        
        let arcAnimationHigh: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationHigh.fromValue = arcPathMid.cgPath
        arcAnimationHigh.toValue = arcPathHigh.cgPath
        arcAnimationHigh.beginTime = arcAnimationMid.beginTime + arcAnimationMid.duration
        arcAnimationHigh.duration = animationDuration
        
        let arcAnimationComplete: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationComplete.fromValue = arcPathHigh.cgPath
        arcAnimationComplete.toValue = arcPathComplete.cgPath
        arcAnimationComplete.beginTime = arcAnimationHigh.beginTime + arcAnimationHigh.duration
        arcAnimationComplete.duration = animationDuration
        
        let arcAnimationGroup: CAAnimationGroup = CAAnimationGroup()
        arcAnimationGroup.animations = [arcAnimationPre, arcAnimationLow, arcAnimationMid,
                                        arcAnimationHigh, arcAnimationComplete]
        arcAnimationGroup.duration = arcAnimationComplete.beginTime + arcAnimationComplete.duration
        arcAnimationGroup.fillMode = kCAFillModeForwards
        arcAnimationGroup.isRemovedOnCompletion = false
        add(arcAnimationGroup, forKey: nil)
    }

}
