//
//  CrystalInfoViewController.swift
//  ChemestyApp
//
//  Created by Sophie on 26/04/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//

import UIKit

class CrystalInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //BackButton
    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
}
