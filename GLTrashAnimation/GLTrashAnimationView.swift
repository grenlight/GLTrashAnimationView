//
//  GLTrashAnimationView.swift
//  BookShelf_Swift
//
//  Created by grenlight on 15/4/1.
//  Copyright (c) 2015年 grenlight. All rights reserved.
//

import UIKit

private class GLTrashBasicView: UIView {
    var strokeColor: UIColor?
    let strokeWidth: CGFloat = 4
    let cornerRadius: CGFloat = 4
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    func setup() {
        self.backgroundColor = UIColor.clearColor()
        self.clipsToBounds = true
        strokeColor = OWColor.colorWithHex(0x666666)
    }
}

private class GLTrashCover: GLTrashBasicView {
    
    private override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(ctx, strokeColor?.CGColor)
        CGContextSetLineWidth(ctx, strokeWidth)
        
        var padding = ceil(CGRectGetWidth(rect)/6.0)

        var minX = strokeWidth/2.0 + padding
        var midX = CGRectGetMidX(rect)
        var maxX = CGRectGetMaxX(rect) - minX
        var minY = strokeWidth/2.0
        var maxY = CGRectGetMaxY(rect)
        
        CGContextMoveToPoint(ctx, minX , maxY);
        CGContextAddArcToPoint(ctx, minX , minY , midX , minY, cornerRadius);
        CGContextAddArcToPoint(ctx, maxX , minY, maxX , maxY ,cornerRadius);
        CGContextAddLineToPoint(ctx, maxX, maxY)
        
        CGContextDrawPath(ctx, kCGPathStroke)
        CGContextSaveGState(ctx)
        
        CGContextSetLineWidth(ctx, strokeWidth*2)
        CGContextSetLineCap(ctx, kCGLineCapRound)
        
        CGContextMoveToPoint(ctx, strokeWidth , maxY);
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect)-strokeWidth, maxY)

        CGContextDrawPath(ctx, kCGPathStroke)
    }
}

private class GLTrashBody: GLTrashBasicView {
    private override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(ctx, strokeColor?.CGColor)
        CGContextSetLineWidth(ctx, strokeWidth)
        
        var minX = strokeWidth/2.0
        var midX = CGRectGetMidX(rect)
        var maxX = CGRectGetMaxX(rect) - minX
        var minY = strokeWidth/2.0
        var midY = CGRectGetMidY(rect)
        var maxY = CGRectGetMaxY(rect) - minY

        CGContextMoveToPoint(ctx, minX , minY);
        CGContextAddLineToPoint(ctx, maxX, minY)
        CGContextAddArcToPoint(ctx, maxX , maxY, midX , maxY ,cornerRadius);
        CGContextAddArcToPoint(ctx, minX , maxY , minX , midY, cornerRadius);
        CGContextAddLineToPoint(ctx, minX, minY)
        
        var paddingTop: CGFloat = 10
        var paddingGap: CGFloat = (CGRectGetWidth(rect) - 4*strokeWidth) / 3.0
        
        func drawLine(startX: CGFloat, startY: CGFloat, endX: CGFloat, endY: CGFloat) {
            CGContextMoveToPoint(ctx, startX , startY);
            CGContextAddLineToPoint(ctx, endX, endY)
        }
        CGContextSetLineCap(ctx, kCGLineCapRound)
        drawLine(strokeWidth + minX + paddingGap, minY + paddingTop, strokeWidth + minX + paddingGap, maxY-paddingTop)
        drawLine((strokeWidth + paddingGap)*2 + minX, minY + paddingTop, (strokeWidth + paddingGap)*2 + minX, maxY-paddingTop)

        CGContextDrawPath(ctx, kCGPathStroke)
    }
}

class GLTrashAnimationView: GLAnimationBasicView {
    //是否为打开状态, 打开状态执行开盖动画
    var isOpened: Bool = false
    
    private lazy var cover: GLTrashCover = {
        var height = ceil(CGRectGetHeight(self.bounds)/5.0)
        return GLTrashCover(frame: CGRectMake(-CGRectGetWidth(self.bounds)/2.0, height/2.0, CGRectGetWidth(self.bounds), height))
    }()
    
    private lazy var body: GLTrashBody = {
        var offsetY = ceil(CGRectGetHeight(self.bounds)/5.0) - 1
         return GLTrashBody(frame: CGRectMake(0, offsetY, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - offsetY))
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(cover)
        self.addSubview(body)
        
        cover.layer.anchorPoint = CGPointMake(0, 1);
    }
    
//    override func startAnimating() {
//        if !animating {
//            isOpened = !isOpened
//            super.startAnimating()
//        }
//    }
//    
//    override func enterFrame() {
//        if (isOpened) {
//            self.openCover()
//        }
//        else {
//            self.closeCover()
//        }
//    }
    
    func openCover() {
        var angle: CGFloat = CGFloat(M_PI)/8.0
        var transform: CGAffineTransform = CGAffineTransformMakeRotation(-angle)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.cover.transform = transform
        })
    }
    
    func closeCover() {
        var transform: CGAffineTransform = CGAffineTransformIdentity
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.cover.transform = transform
        })
    }
    
}