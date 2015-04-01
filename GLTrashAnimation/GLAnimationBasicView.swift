//
//  GLAnimationBaseView.swift
//  GLTrashAnimation
//
//  Created by grenlight on 15/4/1.
//  Copyright (c) 2015年 grenlight. All rights reserved.
//

import Foundation

class  GLAnimationBasicView: UIView {
    
    var displaylink: CADisplayLink?
    var animating: Bool = false;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func startAnimating() {
        if animating == false {
            displaylink = CADisplayLink(target: self, selector: Selector("enterFrame"))
            displaylink?.frameInterval = 1
            displaylink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
            animating = true
        }
    }
    
    func stopAnimating() {
        displaylink?.invalidate()
        displaylink?.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        displaylink = nil
        animating = false
    }

    func enterFrame() {
        
    }
}