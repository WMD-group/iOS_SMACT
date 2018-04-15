//
//  CrystalOptionsController.swift
//  ChemestyApp
//
//  Created by Edward Attard Montalto on 15/04/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//

import UIKit

class CrystalOptionsController: UIViewController {

    //The three element labels
    @IBOutlet weak var aElementChosen: UILabel!
    @IBOutlet weak var bElementChosen: UILabel!
    @IBOutlet weak var xElementChosen: UILabel!
    
    //Empty list containing the label values
    var suppliedList : [String] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aElementChosen.text = suppliedList[0];
        bElementChosen.text = suppliedList[1];
        xElementChosen.text = suppliedList[2];
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
