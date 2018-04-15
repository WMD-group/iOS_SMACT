//
//  PeriodicTableController.swift
//  ChemestyApp
//
//  Created by Edward Attard Montalto on 15/04/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//

import UIKit

class PeriodicTableController: UIViewController {

    //Creating local variables to store labels value
    @IBOutlet weak var aElementSelected: UILabel!
    @IBOutlet weak var bElementSelected: UILabel!
    @IBOutlet weak var xElementSelected: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Function mapped to "Let's Go" button
    @IBAction func navigateCrystalOptions(_ sender: Any) {
        //preform check to make sure that the three elements have been slected
        performSegue(withIdentifier: "crystalOptionsNav", sender: self);
    }
    
    //Mapping all the buttons to three seperate functions
    //Each function changes the label of either a, b or x
    
    //a element selected
    @IBAction func aElementPressed(_ sender: UIButton) {
        aElementSelected.text = sender.titleLabel!.text;
    }
    
    //b element selected
    @IBAction func bElementPressed(_ sender: UIButton) {
        bElementSelected.text = sender.titleLabel!.text;
    }
    
    //x element selected
    @IBAction func xElementPressed(_ sender: UIButton) {
        xElementSelected.text = sender.titleLabel!.text;
    }

    //Function responcible for sending data to next page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var crystalOptionsController = segue.destination as!  CrystalOptionsController;
        
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
