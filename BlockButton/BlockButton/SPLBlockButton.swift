//
//  SPLBlockButton.swift
//  BlockButton
//
//  Created by bolstad on 4/12/16.
//  Copyright © 2016 Tim Bolstad. All rights reserved.
//

import UIKit

// MARK: - SPLBlockState
// Maps UIControlState for use in dictionary.
private enum SPLBlockState {
    
    // TODO: Make all Control States available.
    case Normal, Highlighted, Disabled //, Selected, Focused, Application, Reserved
    
    func controlState() ->UIControlState {
        
        switch self {
            case Normal:
                return .Normal
            case Highlighted:
                return .Highlighted
            case Disabled:
                return .Disabled
//            case Selected:
//                return .Selected
//            case Focused:
//                return .Focused
//            case Application:
//                return .Application
//            case Reserved:
//                return .Reserved
        }
    }
}

private extension UIControlState {
    func toBlockState() ->SPLBlockState? {
        switch self {
        case UIControlState.Normal:
            return SPLBlockState.Normal
        case UIControlState.Highlighted:
            return SPLBlockState.Highlighted
        case UIControlState.Disabled:
            return SPLBlockState.Disabled
//        case UIControlState.Selected:
//            return SPLBlockState.Selected
//        case UIControlState.Focused:
//            return SPLBlockState.Focused
//        case UIControlState.Application:
//            return SPLBlockState.Application
//        case UIControlState.Reserved:
//            return SPLBlockState.Reserved
        default:
            return nil
        }
    }
}

// MARK: - SPLBlockButton
class SPLBlockButton: UIButton {

    var blockView:SPLBlockView?
    // var drawBlock:SPLDrawClosure?
    private var blocks = [SPLBlockState:SPLDrawClosure]()
    // MARK: - Button State
    override var highlighted:Bool {
        didSet { updateDrawBlock() }
    }
    
    override var enabled: Bool {
        didSet { updateDrawBlock() }
    }
    
    // MARK: - init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }
    
    func commonSetup() {
        
        blockView = SPLBlockView(frame: self.bounds)
        blockView?.backgroundColor = UIColor.clearColor()
        blockView?.userInteractionEnabled = false
        addSubview(blockView!)
    
        // Default Blocks
        self.setBlockForState( .Highlighted,//.Normal,
                    drawBlock: SPLBlockView.drawRoundedRect(shadowOffset:4.0))
        self.setBlockForState( .Normal,//.Highlighted,
                    drawBlock: SPLBlockView.drawRoundedRect())
        self.setBlockForState( .Disabled,
                    drawBlock: SPLBlockButton.drawDisabled())
        updateDrawBlock()
    }
    
    func updateDrawBlock() {
        
        let newBlock:SPLDrawClosure?
        switch (enabled, highlighted) {
        case (true, true):
            newBlock = blocks[.Highlighted]
        case (true, false):
            newBlock = blocks[.Normal]
        case (false, _):
            newBlock = blocks[.Disabled]
        default:
            newBlock = nil
        }
        blockView?.drawBlock = newBlock ?? blocks[.Normal]
        blockView?.setNeedsDisplay()
    }
    
    func setBlockForState(state:UIControlState, drawBlock:SPLDrawClosure) {
        
        if let validState = state.toBlockState() {
            blocks[validState] = drawBlock
        }
    }
    
    class func drawDisabled(stroke:CGFloat = 4.0) ->SPLDrawClosure {
        
        let newBlock:SPLDrawClosure = { (rect, tintColor) in
            
            let inset:CGFloat  = stroke / 2.0
            let drawRect = CGRectInset(rect, inset, inset)
            let rectPath = UIBezierPath(roundedRect: drawRect, cornerRadius: stroke)
            rectPath.lineWidth = stroke
            UIColor.grayColor().setStroke()
            rectPath.stroke()
        }
        return newBlock
    }
}
