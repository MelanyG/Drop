//
//  WindmillLayer.swift
//  Drop
//
//  Created by Melaniia Hulianovych on 4/6/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class WindmillLayer: CALayer {
    
    let sizeWindMill = CGSize(width: 100.0, height: 100.0)

    override func draw(in ctx: CGContext) {
        
        //Draw with context
        contentsScale = UIScreen.main.scale

        drawMillBezier(x: bounds.width / 2, y: bounds.height / 2, radius: 10, sides: 3, pointyness: 2, withContext: ctx)
        
        ctx.setLineWidth(5.0)
        ctx.setLineCap(.round)
        ctx.setLineJoin(.round)
        ctx.setStrokeColor(UIColor.white.cgColor)
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.drawPath(using: .fillStroke)

    }
    
    func drawMillBezier(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, pointyness:CGFloat, angleAdjustment:Int=0, withContext ctx:CGContext) {
        millPath(x: x, y: y, radius: radius, sides: sides, pointyness:pointyness, angleAdjustment:angleAdjustment, withContext: ctx)
        
    }
    
    private final func millPath(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, pointyness:CGFloat, angleAdjustment:Int=0, withContext ctx:CGContext) {

        
        let points = polygonPointArray(sides, x:x, y:y, radius:bounds.height / 2 * 0.8, adjustment:CGFloat(angleAdjustment))
        let points2 = polygonPointArray(sides, x:x, y:y, radius:radius, adjustment:CGFloat(bounds.height / 2 * 0.2))
        let points3 = polygonPointArray(sides, x:x, y:y, radius:radius, adjustment:CGFloat(-1 * bounds.height / 2 * 0.2))
        var i = 0
        
        for p in points {
            let path = CGMutablePath()
            
            path.move(to: CGPoint(x: p.x, y: p.y))
            path.addLine(to: CGPoint(x: points2[i].x, y: points2[i].y))
            path.addQuadCurve(to: CGPoint(x: points3[i].x, y: points3[i].y), control: CGPoint(x: x, y: y))
            path.addLine(to: CGPoint(x: p.x, y: p.y))
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
            if adjustment != 0 {
                let xpo1 = cx - r * cos(angle * CGFloat(i) + degree2radian(adjustment))
                let ypo1 = cy - r * sin(angle * CGFloat(i) + degree2radian(adjustment))
                points.append(CGPoint(x: xpo1, y: ypo1))
            } else {
            let xpo = cx - r * cos(angle * CGFloat(i))
            let ypo = cy - r * sin(angle * CGFloat(i))
                points.append(CGPoint(x: xpo, y: ypo))
            }

            i -= 1
        }
        return points
    }
    
    private final func degree2radian(_ degree:CGFloat) -> CGFloat {
        return CGFloat(M_PI) * degree/180.0
    }

    
}
