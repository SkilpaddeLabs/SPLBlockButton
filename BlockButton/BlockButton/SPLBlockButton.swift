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
        default:
            return nil
        }
    }
}

// MARK: - SPLBlockButton
class SPLBlockButton: UIButton {

    var blockView:SPLBlockView?
    var underDraw:CGSize {
        get { return blockView?.underDraw ?? CGSizeZero }
        set { blockView?.underDraw = newValue }
    }
    
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
        
        self.clipsToBounds = false
        blockView?.clipsToBounds = false
    
        // Default Blocks
        self.setBlockForState( .Normal,
                    drawBlock: SPLBlockView.drawRoundedRect())
        updateDrawBlock()
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.blockView?.frame = self.bounds
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
    }
    
    func setBlockForState(state:UIControlState, drawBlock:SPLDrawClosure?) {
        
        if let validState = state.toBlockState() {
            blocks[validState] = drawBlock
        }
        updateDrawBlock()
    }
}
