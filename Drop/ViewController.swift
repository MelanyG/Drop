//
//  ViewController.swift
//  Drop
//
//  Created by Melaniia Hulianovych on 3/27/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var x: UIView!
    var mainLayer: DropLayer?
        var bigHiddenDrop: DropLayer?
    var layers: [DropLayer]?
    var visible = false
    let distance:CGFloat = 300
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addHiddenDrops()
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height * 2.5)
        scrollView.isScrollEnabled = true
        mainLayer = DropLayer(x.bounds, shouldFillLayer:false)
        //           lay.setNeedsDisplay()
        
        x.layer.addSublayer(mainLayer!)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addHiddenDrops() {
        
        
        let width = x.bounds.size.width
        let mainWidth = x.bounds.size.width
        var xPosition = x.bounds.midX - width/2
        
        bigHiddenDrop = DropLayer(CGRect(origin:CGPoint(x: xPosition, y: x.bounds.origin.y - distance),
                                             size:x.frame.size),
                                      shouldFillLayer:true)
        bigHiddenDrop?.opacity = 0.4
        
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
        //            bigHiddenDrop?.bounds.size = CGSize(width:(bigHiddenDrop?.bounds.size.width)! / 3, height:(bigHiddenDrop?.bounds.size.height)! / 2)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let bottomOffset = scrollView.contentOffset.y + scrollView.bounds.size.height
        print(scrollView.contentOffset)
        
        if bottomOffset < x.frame.midY && bottomOffset > x.frame.midY - distance {
            if visible {
                if scrollView.contentOffset.y < x.frame.midY {
                var realDistanceToCenter = x.frame.midY - bottomOffset
                var percent = realDistanceToCenter / distance
                    
                    let animPosition = CABasicAnimation(keyPath: "position")
                    animPosition.duration = 1
                    animPosition.fillMode = kCAFillModeForwards
                    animPosition.isRemovedOnCompletion = false
                    //        anim.fromValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 0, height: 30))
                    animPosition.toValue = NSValue(cgRect: CGRect(x:(mainLayer?.frame.midX)!, y:(mainLayer?.frame.midY)!, width: (mainLayer?.frame.size.width)!, height: (mainLayer?.frame.size.height)!))
                    bigHiddenDrop?.add(animPosition, forKey: "position")
                    
                    
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
        
        //        CATransaction.begin()
        //        CATransaction.setAnimationDuration(10.0)
        //        lay.bounds = CGRect(x:0, y:0, width: 200 , height: 250)
        //        CATransaction.commit()
        
        //        lay.transform = CATransform3DScale(m11, 5, 5, 400)
        //        bigHiddenDrop?.isHidden = false
        //        CATransaction.setDisableActions(true)
        //        bigHiddenDrop?.position.y = (mainLayer?.position.y)!
        //         bigHiddenDrop?.bounds.size.height = (mainLayer?.bounds.size.height)!
        //        bigHiddenDrop?.bounds.size.width = (mainLayer?.bounds.size.width)!
        //        let anim = CASpringAnimation(keyPath: "position")
        //        anim.damping = 0.7
        //        anim.initialVelocity = 20
        //        anim.mass = 0.04
        //        anim.stiffness = 4
        //        anim.duration = 100.8
        //        print(anim.settlingDuration)
        //        bigHiddenDrop?.add(anim, forKey: nil)
        
        
        
        //        bigHiddenDrop?.transform = CATransform3DMakeScale(0.5, 0.5, 1.0)
        
        //        let anim = CABasicAnimation(keyPath: "bounds")
        //        anim.duration = 5
        ////        anim.fromValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 0, height: 30))
        //        anim.toValue = NSValue(cgRect: (mainLayer?.frame)!)
        //        bigHiddenDrop?.add(anim, forKey: "anim")
        
        
                let animPosition = CABasicAnimation(keyPath: "position")
                animPosition.duration = 2
        animPosition.fillMode = kCAFillModeForwards
        animPosition.isRemovedOnCompletion = false
                //        anim.fromValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 0, height: 30))
        animPosition.toValue = NSValue(cgRect: CGRect(x:(mainLayer?.frame.midX)!, y:(mainLayer?.frame.midY)!, width: (mainLayer?.frame.size.width)!, height: (mainLayer?.frame.size.height)!))
                bigHiddenDrop?.add(animPosition, forKey: "position")

    }
    
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("anim did end")
    }
}

