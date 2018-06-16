//
//  CrystalOptionsController.swift
//  ChemestyApp
//
//  Created by Edward Attard Montalto on 15/04/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//

import UIKit
import SpriteKit

class CrystalOptionsController: UIViewController {
    
    //The three element labels
    @IBOutlet weak var aElementChosen: UILabel!
    @IBOutlet weak var bElementChosen: UILabel!
    @IBOutlet weak var xElementChosen: UILabel!
    
    //Labels for displaying text and output
    @IBOutlet weak var computedOutput: UITextView!
    @IBOutlet weak var pseuLabel: UILabel!
    
    //Empty list containing the label values
    var suppliedList : [String] = []; //filled by previous controller
    var selectedElList : [String] = [];
    var computedResult : String = "";
    
    //this function is invoked once the controller is ready (ie loaded into memory)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aElementChosen.text = suppliedList[0];
        bElementChosen.text = suppliedList[1];
        xElementChosen.text = suppliedList[2];
        
        selectedElList = [aElementChosen.text!, bElementChosen.text!, xElementChosen.text!];
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //This is called once the controller is visible
    override func viewDidAppear(_ animated: Bool) {
        
        //Adding this thread to preform actual computation in the background
        DispatchQueue.global(qos: .background).async {
            
            //This is where the actual computation is performed, in the 'background'
            //performComputation function located in Chemical_Computation under Helpers folder
            self.computedResult = performComputation(el1: self.selectedElList[0], el2: self.selectedElList[1], el3: self.selectedElList[2]);
            
            //This is done after the background code is computed
//            DispatchQueue.main.async {
//                self.computedOutput.text = self.computedResult;
//            }
        }
        
        //Adding 2 second delays to demonstrate 'computation'
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
            // Your code with delay
            self.pseuLabel.text = "Done!";
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.pseuLabel.text = "Calculating charge neutral ratios ... ";
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.pseuLabel.text = "Done! All computations are complete!";
                    
                    //This is done after the background code is computed
                    DispatchQueue.main.async {
                        self.computedOutput.text = self.computedResult;
                    }
                }
            }
            
        }
    }
    
    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
}
