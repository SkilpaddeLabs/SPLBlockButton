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
    @IBOutlet weak var blockButton: SPLBlockButton!
    @IBOutlet weak var disableOrangeButton: SPLBlockButton!
    @IBOutlet weak var changeButton: SPLBlockButton!
    @IBOutlet weak var sizeButton: SPLBlockButton!
    @IBOutlet weak var sizeButtonConstraint: NSLayoutConstraint!
    
    @IBAction func orangeButtonClick(sender: SPLBlockButton) {
        print("Orange")
    }
    
    @IBAction func disableOrangeClicked(sender: SPLBlockButton) {
        
        blockButton.enabled = !blockButton.enabled
        let newTitle = blockButton.enabled ? "Disable" : "Enable"
        disableOrangeButton.setTitle( newTitle, forState: .Normal)
    }
    
    @IBAction func changeButtonClicked(sender: SPLBlockButton) {

        changeButton.tintColor = UIColor.blueColor()
//        if changeIndex == 0 {
//            changeButton.setBlockForState( .Normal,
//                                drawBlock: SPLBlockView.drawTest())
//            
//         } else {
//            
//            changeButton.setBlockForState( .Normal,
//                                drawBlock: SPLBlockView.drawRoundedRect())
//        }
//        changeIndex = (changeIndex + 1) % 2
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
        blockButton.backgroundColor = clearColor
        changeButton.backgroundColor = clearColor
        sizeButton.backgroundColor = clearColor
        
        sizeButton.setBlockForState( .Normal,
                          drawBlock: SPLBlockView.drawOval())
        sizeButton.setBlockForState( .Highlighted, drawBlock:nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

