//
//  ViewController.swift
//  BlockButton
//
//  Created by bolstad on 4/12/16.
//  Copyright © 2016 Tim Bolstad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var blockView: SPLBlockView!
    @IBOutlet weak var blockButton: SPLBlockButton!
    
    @IBAction func orangeButtonClick(sender: SPLBlockButton) {
        print("Orange")
    }
    
    @IBAction func disableOrangeClicked(sender: SPLBlockButton) {
        blockButton.enabled = !blockButton.enabled
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Remove colors set in IB for clarity.
        blockView.backgroundColor = UIColor.clearColor()
        blockButton.backgroundColor = UIColor.clearColor()
        self.view.tintColor = UIColor.redColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

