//
//  CircleLayer.swift
//  Drop
//
//  Created by Melaniia Hulianovych on 4/10/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class CircleLayer: CALayer {

    override func draw(in ctx: CGContext) {
 
        let moonShape = UIBezierPath(ovalIn: bounds)
        moonShape.lineWidth = 4.0
        UIColor.white.setStroke()
        moonShape.stroke()
        moonShape.close()

        
    }
    
}
