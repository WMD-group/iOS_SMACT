//
//  ViewController.swift
//  PeriodicTablePage
//
//  Created by Sophie on 16/03/2018.
//  Copyright © 2018 Sophie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Display element when button pressed
    @IBOutlet weak var elementLabel: RoundButton!
    
    //chosen Element
    var chosenElem = " "
    
    
    //Handle button presses
    @IBAction func elementPressed(_ sender: RoundButton) {
        
        chosenElem += "\(sender.tag)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}

