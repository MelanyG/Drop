//
//  SunLayer.swift
//  Drop
//
//  Created by Melaniia Hulianovych on 4/4/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class SunLayer: CALayer {
    

    var sunCircle = CGMutablePath()
    
    
    init(_ rect:CGRect) {
        super.init()
        self.frame = rect
        
        setNeedsDisplay()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(in ctx: CGContext) {

        //Draw with context
        contentsScale = UIScreen.main.scale
        sunCircle.addArc(center: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: bounds.width / 2 * 0.3, startAngle: degree2radian(270), endAngle: degree2radian(-100), clockwise: false)
        ctx.addPath(sunCircle)
        drawRayBezier(x: bounds.width / 2, y: bounds.height / 2, radius: bounds.width / 2 * 0.5, sides: 8, pointyness: 2, angleAdjustment: -50, withContext: ctx)
        ctx.setLineWidth(3.0)
        ctx.setLineCap(.round)
        ctx.setStrokeColor(UIColor(colorLiteralRed: 253/255, green: 206/255, blue: 84/255, alpha: 1.0).cgColor)

        ctx.strokePath()
    }
    
    func drawRayBezier(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, pointyness:CGFloat, angleAdjustment:Int=0, withContext ctx:CGContext) {
        rayPath(x: x, y: y, radius: radius, sides: sides, pointyness:pointyness, angleAdjustment:angleAdjustment, withContext: ctx)

    }
    
    private final func rayPath(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, pointyness:CGFloat, angleAdjustment:Int=0, withContext ctx:CGContext) {
        let adjustment = (360 / sides / 2) + angleAdjustment

        let points = polygonPointArray(sides, x:x, y:y, radius:radius, adjustment:CGFloat(angleAdjustment))
        let points2 = polygonPointArray(sides, x:x, y:y, radius:radius * 0.75 * pointyness, adjustment:CGFloat(adjustment))
        var i = 0
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(1)
        shadow.shadowOffset = CGSize(width: 1, height: 1)
        shadow.shadowBlurRadius = 2

        for p in points {
            let path = CGMutablePath()
            path.move(to: CGPoint(x: points2[i].x, y: points2[i].y))
            path.addLine(to: CGPoint(x: p.x, y: p.y))
            ctx.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            ctx.addPath(path)
            ctx.closePath()
            i += 1
        }

    }
    
    private final func polygonPointArray(_ sides:Int, x:CGFloat, y:CGFloat, radius:CGFloat, adjustment:CGFloat=0) -> [CGPoint] {
        let angle = degree2radian(360/CGFloat(sides))
        let cx = x // x origin
        let cy = y // y origin
        let r = radius // radius of circle
        var i = sides
        var points = [CGPoint]()
        while points.count <= sides {
            let xpo = cx - r * cos(angle * CGFloat(i) )
            let ypo = cy - r * sin(angle * CGFloat(i))
            points.append(CGPoint(x: xpo, y: ypo))
            i -= 1
        }
        return points
    }
    
    private final func degree2radian(_ degree:CGFloat) -> CGFloat {
        return CGFloat(M_PI) * degree/180.0
    }
}
