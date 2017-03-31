//
//  NatureView.swift
//  Drop
//
//  Created by Melaniia Hulianovych on 3/31/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class NatureView: UIView {
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        drawMountains(inRect: rect, inContext: context!, withColorSpace: colorSpace)
        
    }
    
    func drawMountains(inRect rect:CGRect, inContext context:CGContext, withColorSpace colorSpace:CGColorSpace) {

        let space: CGFloat = 50
        
        let width = rect.width
        let height = rect.height
        
        let firstHill = CGMutablePath()
        firstHill.move(to: CGPoint(x: 0, y: height))
        firstHill.addLine(to: CGPoint(x: space, y: height))
        var currentPoint = space
        firstHill.addQuadCurve(to: CGPoint(x: space + space, y: height), control:  CGPoint(x: space + space / 2, y: height * 0.95))
        currentPoint += space
        firstHill.addLine(to: CGPoint(x: space * 2 + 3, y: height))
        firstHill.addLine(to: CGPoint(x: space * 2  - space / 4, y: height * 0.975))
        firstHill.addQuadCurve(to: CGPoint(x: space * 5, y: height), control:  CGPoint(x: space * 2 + space, y: height * 0.90))
        currentPoint = space * 5
        firstHill.addLine(to: CGPoint(x: currentPoint + space, y: height))
        currentPoint  += space
        firstHill.addQuadCurve(to: CGPoint(x: currentPoint + space * 5, y: height * 0.95), control:  CGPoint(x:currentPoint + (space * 5) * 0.7, y: height * 0.80))
        currentPoint += space * 4.4
        firstHill.addLine(to: CGPoint(x: currentPoint, y: height))
        firstHill.addLine(to: CGPoint(x: currentPoint + 3, y: height))
        currentPoint += 3
        firstHill.addQuadCurve(to: CGPoint(x: width, y: height), control:  CGPoint(x:width - space, y: height * 0.70))
        
        
        context.addPath(firstHill)
//        context.setLineWidth(5.0)
        context.setFillColor(UIColor.white.withAlphaComponent(0.5).cgColor)
        context.fillPath()
        context.setFillColorSpace(colorSpace)
    }
    
}
