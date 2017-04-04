//
//  ViewController.swift
//  Drop
//
//  Created by Melaniia Hulianovych on 3/27/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var x: UIView!
    var mainLayer: DropLayer!
    var bigHiddenDrop: DropLayer!
    var layers: [DropLayer]!
    var visible = false
    let distance:CGFloat = 300
    var fallingWaterLayer: CAShapeLayer!
    var seaMaskLayer: WavesLayer!
    var dropForSea: DropLayer!
    
    @IBOutlet weak var natureView: NatureView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       addHiddenDrops()
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height * 2.5)
        scrollView.isScrollEnabled = true
        fallingWaterLayer = CAShapeLayer()
        fallingWaterLayer.frame = x.bounds
        fallingWaterLayer.fillColor = UIColor.blue.cgColor
        let path = CGPath(rect:fallingWaterLayer.bounds, transform:nil)
        fallingWaterLayer.path = path
//        x.layer.addSublayer(fallingWaterLayer)
        mainLayer = DropLayer(x.bounds, shouldFillLayer:false)
        x.layer.addSublayer(mainLayer!)
        bigHiddenDrop.mask = fallingWaterLayer
        
//        let sun = SunLayer(CGRect(x: 0, y: 0, width: 50, height: 50))
//        self.view.layer.addSublayer(sun)
//        addwaves()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addwaves() {
        
        let ex = UIView(frame: CGRect(x: 400, y: 100, width: 200, height: 200))
        scrollView.addSubview(ex)
    let sea = WavesLayer()
        sea.frame = CGRect(x: -2 * x.bounds.width, y: 0, width: ex.bounds.width * 3, height: ex.bounds.height)
        sea.setNeedsDisplay()
        ex.layer.addSublayer(sea)
        
        let arcAnimationPre: CABasicAnimation = CABasicAnimation(keyPath: "position")
        //        arcAnimationPre.fromValue = 0
        arcAnimationPre.toValue = 100
        //        arcAnimationPre.beginTime = 5.8
        arcAnimationPre.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        arcAnimationPre.fillMode = kCAFillModeBoth
        arcAnimationPre.isRemovedOnCompletion = false
        arcAnimationPre.duration = 5
        //        arcAnimationPre.repeatCount = 5
        sea.add(arcAnimationPre, forKey: arcAnimationPre.keyPath)
    }
    
    
    func addHiddenDrops() {
        
        
        let width = x.bounds.size.width
        let mainWidth = x.bounds.size.width
        var xPosition = x.bounds.midX - width/2
        
        bigHiddenDrop = DropLayer(x.bounds,
                                      shouldFillLayer:true)
        bigHiddenDrop?.opacity = 1.0
//        bigHiddenDrop?.transform = CATransform3DMakeScale(0.5, 0.5, 1.0)
        bigHiddenDrop?.isHidden = true
        xPosition = x.bounds.midX - CGFloat(arc4random_uniform(UInt32(mainWidth / 2)))
        var yPosition = x.bounds.origin.y + CGFloat(arc4random_uniform(UInt32(mainWidth / 2)))
        let lay1 = DropLayer(CGRect(origin:CGPoint(x: xPosition, y: x.bounds.origin.y - distance + yPosition),
                                    size:x.frame.size),
                             shouldFillLayer:true)
        lay1.opacity = 0.3
        lay1.transform = CATransform3DMakeScale(0.5, 0.5, 1.0)
        lay1.isHidden = true
        
        xPosition = x.bounds.midX + CGFloat(arc4random_uniform(UInt32(mainWidth / 2)))
        yPosition = x.bounds.origin.y + CGFloat(arc4random_uniform(UInt32(mainWidth / 2)))
        let lay2 = DropLayer(CGRect(origin:CGPoint(x: xPosition, y: x.bounds.origin.y - distance + yPosition),
                                    size:x.frame.size),
                             shouldFillLayer:true)
        lay2.opacity = 0.2
        lay2.isHidden = true
        lay2.transform = CATransform3DMakeScale(0.4, 0.4, 1.0)
        x.layer.addSublayer(lay1)
        x.layer.addSublayer(bigHiddenDrop!)
        x.layer.addSublayer(lay2)
        layers = [lay1, bigHiddenDrop!, lay2]

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let bottomOffset = scrollView.contentOffset.y + scrollView.bounds.size.height
        print(scrollView.contentOffset)
        
        if bottomOffset < x.frame.midY && bottomOffset > x.frame.midY - distance {
            if visible {
                if scrollView.contentOffset.y < x.frame.midY {
                var realDistanceToCenter = x.frame.midY - bottomOffset
                var percent = realDistanceToCenter / distance
                    
//                    let animPosition = CABasicAnimation(keyPath: "position")
//                    animPosition.duration = 1
//                    animPosition.fillMode = kCAFillModeForwards
//                    animPosition.isRemovedOnCompletion = false
//                    //        anim.fromValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 0, height: 30))
//                    animPosition.toValue = NSValue(cgRect: CGRect(x:(mainLayer?.frame.midX)!, y:(mainLayer?.frame.midY)!, width: (mainLayer?.frame.size.width)!, height: (mainLayer?.frame.size.height)!))
//                    bigHiddenDrop?.add(animPosition, forKey: "position")
                    
                    
//                    for lay in layers! {
//                        let trans1 = CATransform3DMakeScale(0.5, 0.5, 1.0)
//                        bigHiddenDrop?.transform = CATransform3DMakeTranslation((mainLayer?.frame.midX)!, (mainLayer?.frame.midY)!, 0)
//                        lay.transform = CATransform3DConcat(trans1, trans2)
//                        lay.isHidden = false
                        visible = false
//                    bigHiddenDrop?.bounds.size = CGSize(width: (mainLayer?.bounds.size.width)!, height: (mainLayer?.bounds.size.height)!)
//                                let anim = CABasicAnimation(keyPath: "position")
//                                anim.duration = 10
//                                //        anim.fromValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 0, height: 30))
//                                anim.toValue = NSValue(cgRect: (mainLayer?.bounds)!)
//                                bigHiddenDrop?.add(anim, forKey: "anim")
//                    }

                }
            } else  {
                for lay in layers! {
//                    lay.transform = CATransform3DMakeScale(0.5, 0.5, 1.0)
                    lay.isHidden = false
                    visible = true
                }
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > 500.0 {
            if visible {
                for lay in layers! {
                    //                lay.transform = CATransform3DMakeScale(0.5, 0.5, 1.0)
                    lay.isHidden = true
                }
                visible = false
            }
            
        }
}
    
    @IBAction func fly(_ sender: Any) {
        natureView.setNeedsDisplay()
//                bigHiddenDrop?.isHidden = false
//                CATransaction.setDisableActions(true)
//
//                let anim = CASpringAnimation(keyPath: "position")
//                anim.damping = 0.7
//                anim.initialVelocity = 1
//                anim.mass = 0.04
//                anim.stiffness = 4
//                anim.duration = 5.8
//        anim.toValue = CGPoint(x: (mainLayer?.bounds.size.width)!, y: (mainLayer?.bounds.size.height)!)
//                print(anim.settlingDuration)
//                bigHiddenDrop?.add(anim, forKey: nil)
//
//        let animOpacity = CABasicAnimation(keyPath: "opacity")
//        animOpacity.duration = 5.8
//
//        animOpacity.toValue = 1
//
//        let animSize = CABasicAnimation(keyPath: "transform")
//        animSize.duration = 5.8
//
//        animSize.toValue = CATransform3DMakeScale(2.05, 2.05, 1.0)
//
//        let group = CAAnimationGroup()
//        group.animations = [anim, animOpacity, animSize]
//        group.duration = 5.8
//        group.fillMode = kCAFillModeForwards
//        group.isRemovedOnCompletion = false
//
//        bigHiddenDrop?.add(group, forKey: nil)
        
        
        let animation = CABasicAnimation(keyPath: "bounds.origin.y")
        animation.toValue = x.bounds.size.width * -0.75
        animation.duration = 5.8
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fillMode = kCAFillModeBoth
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        bigHiddenDrop?.add(animation, forKey: animation.keyPath)
        
        seaMaskLayer = WavesLayer()
        seaMaskLayer.frame = CGRect(x: -3 * x.bounds.width, y: 0, width: x.bounds.width * 4, height: x.bounds.height)
        seaMaskLayer.setNeedsDisplay()
       
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if (anim as! CABasicAnimation).keyPath == "bounds.origin.y" {
            bigHiddenDrop?.mask = seaMaskLayer
            animate()
        }
    }
    
    func animate() {
        
        let waveAnimation: CABasicAnimation = CABasicAnimation(keyPath: "bounds.origin.x")
        waveAnimation.toValue = -100
        waveAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        waveAnimation.duration = 5
        waveAnimation.repeatCount = Float.infinity
        bigHiddenDrop.add(waveAnimation, forKey: waveAnimation.keyPath)
        
    }
}

