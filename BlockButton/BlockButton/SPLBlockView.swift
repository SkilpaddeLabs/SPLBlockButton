//
//  SPLBlockView.swift
//  BlockButton
//
//  Created by bolstad on 4/12/16.
//  Copyright © 2016 Tim Bolstad. All rights reserved.
//

import UIKit

typealias SPLDrawClosure = (CGRect, UIColor)->Void

class SPLBlockView: UIView {

    var drawBlock:SPLDrawClosure?
    
    // MARK: - init()
    override init(frame:CGRect) {
        super.init(frame:frame)
        commonSetup()
    }
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        commonSetup()
    }
    
    func commonSetup() {
        drawBlock = SPLBlockView.defaultClosure()
    }
    // MARK: - drawRect()
    override func drawRect(rect: CGRect) {
        // Drawing code
        guard let aDrawBlock = drawBlock else {
            return
        }
        aDrawBlock(rect, tintColor)
    }
    
    // MARK: - Sample Closures
    class func defaultClosure() ->SPLDrawClosure {
        
        //return drawTest()
        return drawRoundedRect(14.0)
    }
    
    class func drawRoundedRect(stroke:CGFloat = 4.0,
                         shadowOffset:CGFloat = 0.0) ->SPLDrawClosure {
        
        let newBlock:SPLDrawClosure = { (rect, tintColor) in
            
            let inset:CGFloat  = stroke / 2.0
            let drawRect = CGRectInset(rect, inset, inset)
            let rectPath = UIBezierPath(roundedRect: drawRect, cornerRadius: stroke)
            rectPath.lineWidth = stroke
            
            if (shadowOffset != 0.0) {
                let context = UIGraphicsGetCurrentContext()
                let offsetSize = CGSize(width: shadowOffset, height: shadowOffset)
                CGContextSetShadow(context, offsetSize, 3.0)
            }
            
            tintColor.setStroke()
            rectPath.stroke()
        }
        return newBlock
    }
    
    class func drawClear(stroke:CGFloat) ->SPLDrawClosure {
        
        let newBlock:SPLDrawClosure = { (rect, _) in
            
            let context = UIGraphicsGetCurrentContext()
            CGContextSetFillColorWithColor(context, UIColor.clearColor().CGColor)
            CGContextFillRect(context, rect)
        }
        return newBlock
    }
    
    class func drawTest() ->SPLDrawClosure {
        
        let newBlock:SPLDrawClosure = { (rect, tintColor) in
            
            UIColor.greenColor().setFill()
            UIColor.redColor().setStroke()
            let path = UIBezierPath.init(rect: rect)
            path.fill()
            path.stroke()
        }
        return newBlock
    }
}
