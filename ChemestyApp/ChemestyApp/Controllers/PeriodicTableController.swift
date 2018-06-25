//
//  PeriodicTableController.swift
//  ChemestyApp
//
//  Created by Edward Attard Montalto on 15/04/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//

import UIKit

var aBList : [UIButton] = [];
var xElementList : [UIButton] = [];

class PeriodicTableController: UIViewController {

    //Creating local variables to store labels value
    @IBOutlet weak var aElementSelected: UILabel!
    @IBOutlet weak var bElementSelected: UILabel!
    @IBOutlet weak var xElementSelected: UILabel!
    @IBOutlet weak var sendToThomas: RoundButton!
    var abElementLabels : [UILabel] = [];
    
    //Full name of element labels
    @IBOutlet weak var elementName1: UILabel!
    @IBOutlet weak var elementName2: UILabel!
    @IBOutlet weak var elementName3: UILabel!
    var abElementNames : [UILabel] = [];
    
    //Integer used to record how many buttons are pressed
    var numberSelected = 0;
    var aBElementLabels = [UILabel()];
    var elementNames : [String : String] = [:];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aBElementLabels = [aElementSelected, bElementSelected];
        // Do any additional setup after loading the view.
        elementNames = Data_loader().lookup_element_name(symbol: "He"); //element name is redundant
        resetVariables();
        abElementNames = [elementName1, elementName2];
        abElementLabels = [aElementSelected, bElementSelected];
    }

    func resetVariables (){
        aElementSelected.text = "<1>";
        bElementSelected.text = "<2>";
        xElementSelected.text = "<3>";
        aBList = [];
        xElementList = [];
        sendToThomas.isEnabled = false;
        elementName1.text = "";
        elementName2.text = "";
        elementName3.text = "";
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Function mapped to "Send to thomas" button
    @IBAction func navigateCrystalOptions(_ sender: Any) {
        //preform check to make sure that the three elements have been slected
        let list = [aElementSelected.text, bElementSelected.text, xElementSelected.text];
        if list.contains("<1>") || list.contains("<2>") || list.contains("<3>"){
            return;
        }
        performSegue(withIdentifier: "crystalOptionsNav", sender: self);
    }
    
    //Mapping all the buttons to three seperate functions
    //Each function changes the label of either a, b or x
    
    /* SELECT A and B elements
     * Blue section of elements
     */
    @IBAction func aBElementSelected(_ sender: UIButton) {
        
        //Original dark blue of buttons: 0.00485985 0.0960863 0.574993 1
        var alreadySelected = false;
        
        //Check to see if button pressed twice
        if aBList.contains(sender){
            
            sender.backgroundColor = UIColor(red:  0.00485985, green: 0.0960863, blue: 0.574993, alpha: 1);
            
            //If the first element in the list is selected to be removed
            if abElementLabels[0].text == sender.titleLabel!.text{
                
                //Special case when de-selecting a single chosen element
                if aBList.count == 1{
                    abElementNames[0].text = "";
                    abElementLabels[0].text = "<1>";
                    sendToThomas.isEnabled = false;
                }else{
                    abElementNames[0].text = abElementNames[1].text;
                    abElementLabels[0].text = abElementLabels[1].text;
                    abElementNames[1].text = "";
                    abElementLabels[1].text = "<2>";
                    sendToThomas.isEnabled = false;
                }
                
            }else if aBElementLabels[1].text == sender.titleLabel!.text{
                abElementNames[1].text = "";
                abElementLabels[1].text = "<2>";
                sendToThomas.isEnabled = false;
            }
//            abElementNames[aBList.count-1].text = "";
//            abElementLabels[aBList.count-1].text = "<??>";

            alreadySelected = true;
            aBList = aBList.filter({ !($0 == sender) });
            
        }
        
//        if aBList.count == 0{
//            aElementSelected.text = "<1>";
//            bElementSelected.text = "<2>";
//            sendToThomas.isEnabled = false;
//
//            abElementNames[0].text = "";
//            abElementNames[1].text = "";
//        }else if aBList.count == 1{
//            aElementSelected.text = aBList[0].titleLabel!.text;
//            elementName1.text = elementNames[aBList[0].titleLabel!.text!];
//            bElementSelected.text = "<2>";
//            sendToThomas.isEnabled = false;
//        }else{
//            aElementSelected.text = aBList[0].titleLabel!.text;
//            bElementSelected.text = aBList[1].titleLabel!.text;
//
//            elementName2.text = elementNames[aBList[1].titleLabel!.text!];
//            //If all the elements are selcted, then enable the 'send to thomas' button
//            if(xElementList.count == 1){
//                sendToThomas.isEnabled = true;
//            }
//        }
        
        if alreadySelected{ return; }

        if aBList.count < 2{
            aBList.append(sender);
            sender.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1);
            abElementNames[aBList.count-1].text = elementNames[sender.titleLabel!.text!];
            abElementLabels[aBList.count-1].text = aBList[aBList.count-1].titleLabel!.text!;
        }else{
            print("Cannot select more than 2 elements from A and B category")
        }
        
        //If all elements are selected, activate button
        if(aBList.count == 2 && xElementSelected.text != "<3>"){
            sendToThomas.isEnabled = true;
        }
        
//        if aBList.count == 0{
//            aElementSelected.text = "<1>";
//            bElementSelected.text = "<2>";
//
//            abElementNames[0].text = "";
//            abElementNames[1].text = "";
//        }else if aBList.count == 1{
//            aElementSelected.text = aBList[0].titleLabel!.text;
//            abElementNames[0].text = abElementNames[1].text;
//            bElementSelected.text = "<2>";
//            abElementNames[1].text = "";
//        }else{
//            aElementSelected.text = aBList[0].titleLabel!.text;
//            bElementSelected.text = aBList[1].titleLabel!.text;
//
////            abElementNames[0].text = elementNames[aBList[0].titleLabel!.text!];
////            abElementNames[1].text = elementNames[aBList[1].titleLabel!.text!];
//
//            //If all the elements are selcted, then enable the 'send to thomas' button
//            if(xElementList.count == 1){
//                sendToThomas.isEnabled = true;
//            }
//        }
       
    }
    
    @IBAction func xElementSelected(_ sender: UIButton) {
        
        //Original colour of orange x element: 1 0.578105 0 1
        
        if xElementList.contains(sender){
            sender.backgroundColor = UIColor(red: 1, green: 0.578105, blue: 0, alpha: 1);
            xElementList = xElementList.filter({ !($0 == sender)});
            xElementSelected.text = "<3>";
            sendToThomas.isEnabled = false;
            elementName3.text = "";
        }else if xElementList.count == 0{
            xElementList.append(sender);
            sender.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1);
            
            let element = sender.titleLabel?.text;
            xElementSelected.text = element;
            elementName3.text = elementNames[element!];
            //if all a, b and x elements selected, then enable next button
            if(aBList.count == 2){
                sendToThomas.isEnabled = true;
            }
            
        }else{
            print("Cannot select more than one x element")
        }
    }
    
    //Function responcible for sending data to next page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Creating an instance of the CrystalOptionsController
        let crystalOptionsController = segue.destination as!  CrystalOptionsController;
        
        //preform check to make sure the data is not null
        let list = [aElementSelected.text, bElementSelected.text, xElementSelected.text];
        crystalOptionsController.suppliedList = list as! [String]; //enforcing the type to be list of string
        
    }
    
    
    //Back Button
    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil);
        
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
