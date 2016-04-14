//
//  ViewController.swift
//  BlockButton
//
//  Created by bolstad on 4/12/16.
//  Copyright © 2016 Tim Bolstad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var changeIndex = 0
    var sizeButtonFlag = false
    
    @IBOutlet weak var blockView: SPLBlockView!
    @IBOutlet weak var orangeButton: SPLBlockButton!
    @IBOutlet weak var disableOrangeButton: SPLBlockButton!
    @IBOutlet weak var changeButton: SPLBlockButton!
    @IBOutlet weak var sizeButton: SPLBlockButton!
    @IBOutlet weak var sizeButtonConstraint: NSLayoutConstraint!
    
    @IBAction func orangeButtonClick(sender: SPLBlockButton) {
        print("Orange")
    }
    
    @IBAction func disableOrangeClicked(sender: SPLBlockButton) {
        
        orangeButton.enabled = !orangeButton.enabled
        let newTitle = orangeButton.enabled ? "Disable" : "Enable"
        disableOrangeButton.setTitle( newTitle, forState: .Normal)
    }
    
    @IBAction func changeButtonClicked(sender: SPLBlockButton) {
        
        cycleChangeButton()
    }
    
    @IBAction func sizeButtonClicked(sender: SPLBlockButton) {
        
        let superWidth = sizeButton.superview!.frame.size.width
        
        if sizeButtonFlag {
            sizeButtonConstraint.constant = 0.5 * superWidth
        } else {
            sizeButtonConstraint.constant = 0.2 * superWidth
        }
        sizeButtonFlag = !sizeButtonFlag
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.tintColor = UIColor.redColor()
        
        // Remove colors set in IB for clarity.
        let clearColor = UIColor.clearColor()
        blockView.backgroundColor = clearColor
        orangeButton.backgroundColor = clearColor
        changeButton.backgroundColor = clearColor
        sizeButton.backgroundColor = clearColor
        
        // Set Draw Blocks
        orangeButton.setBlockForState( .Normal, drawBlock: SPLBlockView.drawRoundedRect(8.0))
        orangeButton.setBlockForState( .Highlighted, drawBlock: SPLBlockView.drawRoundedRect(8.0, shadowOffset:4.0))
        orangeButton.setBlockForState( .Disabled, drawBlock: SPLBlockButton.drawDisabled())
        
        disableOrangeButton.setBlockForState( .Highlighted, drawBlock: SPLBlockView.drawRoundedRect(shadowOffset:4.0))
        
        sizeButton.setBlockForState( .Normal, drawBlock: SPLBlockView.drawOval())
        
        changeButton.setBlockForState( .Normal, drawBlock: SPLBlockView.drawOval())
    }
    
    func cycleChangeButton() {
        
        switch changeIndex {
        case 0:
            changeButton.setBlockForState( .Normal, drawBlock: SPLBlockView.drawRoundedRect())
        case 1:
            changeButton.setBlockForState( .Normal, drawBlock: SPLBlockView.drawTest())
        case 2:
            setStarButton()
        default: break
        }
        changeIndex = (changeIndex + 1) % 3
    }
    
    func setStarButton() {
        
        changeButton.setBlockForState(.Normal) { (frame, color) in
            
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let context = UIGraphicsGetCurrentContext()
            
            // Gradient
            let gradientStartColor = UIColor.blackColor().CGColor
            let gradientEndColor = color.CGColor
            let colors = [gradientStartColor, gradientEndColor]
            let locations = [1.0, 0.0].map{CGFloat($0)}
            
            let gradient = CGGradientCreateWithColors(colorSpace, colors, locations)
            
            // Star 
            let xoffset:CGFloat = 0.5 * frame.size.width - 50.0
            let yoffset:CGFloat = 10.0
            let starPath = UIBezierPath()
            starPath.moveToPoint(CGPoint(x: xoffset + 51.0, y: yoffset + 3.5))
            starPath.addLineToPoint(CGPoint(x: xoffset + 68.46, y: yoffset + 29.49))
            starPath.addLineToPoint(CGPoint(x: xoffset + 98.08, y: yoffset + 38.39))
            starPath.addLineToPoint(CGPoint(x: xoffset + 79.25, y: yoffset + 63.36))
            starPath.addLineToPoint(CGPoint(x: xoffset + 80.10, y: yoffset + 94.86))
            starPath.addLineToPoint(CGPoint(x: xoffset + 51.00, y: yoffset + 84.3))
            starPath.addLineToPoint(CGPoint(x: xoffset + 21.90, y: yoffset + 94.86))
            starPath.addLineToPoint(CGPoint(x: xoffset + 22.75, y: yoffset + 63.36))
            starPath.addLineToPoint(CGPoint(x: xoffset + 3.92,  y: yoffset + 38.39))
            starPath.addLineToPoint(CGPoint(x: xoffset + 33.54, y: yoffset + 29.49))
            starPath.closePath()
            CGContextSaveGState(context)
            starPath.addClip()
            CGContextDrawLinearGradient(context, gradient,
                                        CGPoint(x: xoffset + 51.0, y: yoffset + 3.5),
                                        CGPoint(x: xoffset + 51.0, y: yoffset + 94.86),
                                        .DrawsBeforeStartLocation)
            CGContextRestoreGState(context)
            UIColor.blackColor().setStroke()
            starPath.lineWidth = 1;
            starPath.stroke()
        }
    }
}

