//
//  ViewController.swift
//  Gestures&Animations
//
//  Created on: 03-June-2016
//      Author: Nafisa Rahman
//
//  LICENSE:-
//  The MIT License (MIT)
//  Copyright (c) 2016 Nafisa Rahman
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom
//  the Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall
//  be included in all copies or substantial portions of the
//  Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
//  OR OTHER DEALINGS IN THE SOFTWARE.
//


import UIKit

class ViewController: UIViewController {
    
    //MARK:- properties
    @IBOutlet weak var box: UIView!
    
    var animator: UIDynamicAnimator?
    
    //MARK:- methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //MARK: tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        box.addGestureRecognizer(tap)
        
        
        //MARK: double tap gesture
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction(_:)))
        doubleTap.numberOfTapsRequired = 2
        tap.requireGestureRecognizerToFail(doubleTap)
        box.addGestureRecognizer(doubleTap)
        
        
        //MARK: long press gesture
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:)))
        box.addGestureRecognizer(longPress)
        
        
        //MARK: pinch gesture
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(_:)))
        box.addGestureRecognizer(pinch)
        
        
        //MARK: rotate gesture
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(rotateAction(_:)))
        box.addGestureRecognizer(rotate)
        
        
        //MARK: pan gesture
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        box.addGestureRecognizer(pan)
        
        
        //MARK: left screen edge pan gesture
        let leftEdgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(leftEdgePanAction(_:)))
        leftEdgePan.edges = UIRectEdge.Left
        self.view.addGestureRecognizer(leftEdgePan)
        
        
        //MARK: right screen edge pan gesture
        let rightEdgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(rightEdgePanAction(_:)))
        rightEdgePan.edges = UIRectEdge.Right
        self.view.addGestureRecognizer(rightEdgePan)
        
        
        //MARK: swipe left gesture
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeAction(_:)))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        pan.requireGestureRecognizerToFail(leftSwipe)
        box.addGestureRecognizer(leftSwipe)
        
        
        //MARK: swipe up gesture
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(upSwipeAction(_:)))
        upSwipe.direction = UISwipeGestureRecognizerDirection.Up
        pan.requireGestureRecognizerToFail(upSwipe)
        box.addGestureRecognizer(upSwipe)
        
        
        //MARK: swipe down gesture
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(downSwipeAction(_:)))
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        pan.requireGestureRecognizerToFail(downSwipe)
        box.addGestureRecognizer(downSwipe)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- tap gesture action
    func tapAction(sender: UITapGestureRecognizer){
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 0.5
        animation.repeatCount = 5
        box.layer.addAnimation(animation,forKey: "opacity")
    }
    
    //MARK:- double tap action
    func doubleTapAction(sender: UITapGestureRecognizer){
        
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.fromValue = 70.0
        animation.toValue = 40.0
        animation.repeatCount = 5
        box.layer.addAnimation(animation, forKey: "cornerRadius")
        
    }
    
    //MARK:- long press action
    func longPressAction(sender: UILongPressGestureRecognizer){
        
        box.layer.borderColor = UIColor.yellowColor().CGColor
        
        let animation = CABasicAnimation(keyPath: "borderWidth")
        animation.fromValue = 10.0
        animation.toValue = 50.0
        animation.repeatDuration = 2.0
        box.layer.addAnimation(animation, forKey: "borderWidth")
    }
    
    //MARK:- pinch action
    func pinchAction(sender: UIPinchGestureRecognizer){
        
        sender.view!.transform = CGAffineTransformScale(sender.view!.transform,
                                                        sender.scale, sender.scale)
        sender.scale = 1
        
        
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 0
        animation.repeatCount = 1
        
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        box.layer.addAnimation(animation, forKey: "scale")
        
    }
    
    
    //MARK:- rotate action
    func rotateAction(sender: UIRotationGestureRecognizer){
        
        sender.view!.transform = CGAffineTransformRotate(sender.view!.transform, sender.rotation)
        
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = M_PI
        animation.repeatCount = 5
        
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        box.layer.addAnimation(animation, forKey: "rotation")
        
    }
    
    //MARK:- pan action
    func panAction(sender: UIPanGestureRecognizer){
        
        let translate = sender.translationInView(self.view)
        sender.view?.center =  CGPointMake((sender.view?.center.x)! + translate.x, (sender.view?.center.y)! + translate.y)
        sender.setTranslation(CGPointZero, inView: self.view)
        
        
        if sender.state == .Changed{
            let animation = CABasicAnimation(keyPath: "backgroundColor")
            animation.fromValue = UIColor.redColor().CGColor
            animation.toValue = UIColor.greenColor().CGColor
            animation.repeatCount = 5
            box.layer.addAnimation(animation, forKey: "backgroundColor")
            
        }
        
    }
    
    //MARK:- left swipe action
    func leftSwipeAction(sender: UISwipeGestureRecognizer){
        
        animator?.removeAllBehaviors()
        let leftPush = UIPushBehavior(items: [box], mode: UIPushBehaviorMode.Continuous)
        
        let vector = CGVector(dx: -20.0, dy: 0.0)
        leftPush.pushDirection = vector
        
        animator = UIDynamicAnimator(referenceView: view)
        
        animator?.addBehavior(leftPush)
        
        let collison = UICollisionBehavior(items: [box])
        collison.translatesReferenceBoundsIntoBoundary = true
        collison.collisionMode = .Boundaries
        animator?.addBehavior(collison)
    }
    
    
    
    //MARK:- upSwipe action
    func upSwipeAction(sender: UISwipeGestureRecognizerDirection){
        
        animator?.removeAllBehaviors()
        
        let gravity = UIGravityBehavior(items: [box])
        
        let vector = CGVector(dx: 0, dy: -1.0)
        gravity.gravityDirection = vector
        
        animator = UIDynamicAnimator(referenceView: view)
        animator?.addBehavior(gravity)
        
        let collison = UICollisionBehavior(items: [box])
        collison.translatesReferenceBoundsIntoBoundary = true
        collison.collisionMode = .Boundaries
        animator?.addBehavior(collison)
    }
    
    
    //MARK:- down Swipe action
    func downSwipeAction(sender: UISwipeGestureRecognizerDirection){
        
        animator?.removeAllBehaviors()
        
        let gravity = UIGravityBehavior(items: [box])
        
        let vector = CGVector(dx: 0.0, dy: 1.0)
        gravity.gravityDirection = vector
        
        animator = UIDynamicAnimator(referenceView: view)
        animator?.addBehavior(gravity)
        
        let collision = UICollisionBehavior(items: [box])
        collision.collisionMode = .Everything
        collision.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collision)
    }
    
    //MARK:- left edge pan gesture
    func leftEdgePanAction(sender: UIScreenEdgePanGestureRecognizer){
        
        animator?.removeAllBehaviors()
        
        let position = sender.locationInView(self.view)
        
        animator = UIDynamicAnimator(referenceView: view)
        let snap = UISnapBehavior(item: box, snapToPoint: position)
        animator?.addBehavior(snap)
    }
    
    //MARK:- right edge pan gesture
    func rightEdgePanAction(sender: UIScreenEdgePanGestureRecognizer){
        
        animator?.removeAllBehaviors()
        
        let position = sender.locationInView(self.view)
        
        animator = UIDynamicAnimator(referenceView: view)
        let snap = UISnapBehavior(item: box, snapToPoint: position)
        animator?.addBehavior(snap)
        
    }
    
}

