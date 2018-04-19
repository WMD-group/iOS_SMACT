//
//  PeriodicTableController.swift
//  ChemestyApp
//
//  Created by Edward Attard Montalto on 15/04/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//

import UIKit

var aBList : [UIButton] = [];

class PeriodicTableController: UIViewController {

    //Creating local variables to store labels value
    @IBOutlet weak var aElementSelected: UILabel!
    @IBOutlet weak var bElementSelected: UILabel!
    @IBOutlet weak var xElementSelected: UILabel!
    
    //Integer used to record how many buttons are pressed
    var numberSelected = 0;
    var aBElementLabels = [UILabel()];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aBElementLabels = [aElementSelected, bElementSelected];
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    //Function mapped to "Let's Go" button
    @IBAction func navigateCrystalOptions(_ sender: Any) {
        //preform check to make sure that the three elements have been slected
        performSegue(withIdentifier: "crystalOptionsNav", sender: self);
    }
    
    //Mapping all the buttons to three seperate functions
    //Each function changes the label of either a, b or x
    
    /* SELECT A and B elements
     * Green section of elements
     */
    @IBAction func aBElementSelected(_ sender: UIButton) {
        
        var broken = false;
        if aBList.contains(sender){
            sender.backgroundColor = UIColor(red: -0.141793, green: 0.8178, blue: -0.0124199, alpha: 1);
            aBList = aBList.filter({ !($0 == sender) });
            broken = true;
        }
        if aBList.count == 0{
            aElementSelected.text = "<1>";
            bElementSelected.text = "<2>";
        }else if aBList.count == 1{
            aElementSelected.text = aBList[0].titleLabel!.text;
            bElementSelected.text = "<2>";
        }else{
            aElementSelected.text = aBList[0].titleLabel!.text;
            bElementSelected.text = aBList[1].titleLabel!.text;
        }
        
        if broken{ return; }

        if aBList.count < 2{
            aBList.append(sender);
            sender.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1);
//            aBElementLabels[aBList.count-1].text = sender.titleLabel!.text;
        }else{
            print("Cannot select more than 2 elements from A and B category")
        }
        
        if aBList.count == 0{
            aElementSelected.text = "<1>";
            bElementSelected.text = "<2>";
        }else if aBList.count == 1{
            aElementSelected.text = aBList[0].titleLabel!.text;
            bElementSelected.text = "<2>";
        }else{
            aElementSelected.text = aBList[0].titleLabel!.text;
            bElementSelected.text = aBList[1].titleLabel!.text;
        }
       
    }
    
    @IBAction func xElementSelected(_ sender: UIButton) {
        xElementSelected.text = sender.titleLabel?.text;
    }
    
    //Function responcible for sending data to next page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let crystalOptionsController = segue.destination as!  CrystalOptionsController;
        
        //preform check to make sure the data is not null
        let list = [aElementSelected.text, bElementSelected.text, xElementSelected.text];
        crystalOptionsController.suppliedList = list as! [String]; //enforcing the type to be list of string
        
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
