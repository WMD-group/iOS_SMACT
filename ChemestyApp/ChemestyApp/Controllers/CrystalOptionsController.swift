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
    @IBOutlet weak var computedOutput: UITextView!
    
    //Empty list containing the label values
    var suppliedList : [String] = [];
    
    //this function is invoked once the controller is ready
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aElementChosen.text = suppliedList[0];
        bElementChosen.text = suppliedList[1];
        xElementChosen.text = suppliedList[2];
        
        let selectedElList = [aElementChosen.text!, bElementChosen.text!, xElementChosen.text!];
        
        //calling my test class
        let result = TestInit().Run(el1: selectedElList[0], el2: selectedElList[1], el3: selectedElList[2]);
        // Do any additional setup after loading the view.
        computedOutput.text = result;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil);
        
    }
    
    
    

}
