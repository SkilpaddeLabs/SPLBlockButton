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
    
    @IBOutlet weak var blockView: SPLBlockView!
    @IBOutlet weak var blockButton: SPLBlockButton!
    @IBOutlet weak var disableOrangeButton: SPLBlockButton!
    @IBOutlet weak var changeButton: SPLBlockButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Remove colors set in IB for clarity.
        let clearColor = UIColor.clearColor()
        blockView.backgroundColor = clearColor
        blockButton.backgroundColor = clearColor
        changeButton.backgroundColor = clearColor
        self.view.tintColor = UIColor.redColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

