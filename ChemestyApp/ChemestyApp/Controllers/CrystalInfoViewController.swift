//
//  CrystalInfoViewController.swift
//  ChemestyApp
//
//  Created by Sophie on 26/04/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//

import UIKit

class CrystalInfoViewController: UIViewController {
    
    //Supplied list of elements filled from PeriodicTableController
    var elementList : [String] = []; //filled by previous controller
    
    //Inidividual properties of each element
    var elementHHIs : [Int] = [];
    
    //The three labels storing the information about the desired elements
    @IBOutlet weak var colourLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var efficiencyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var elObjList = [Element(elementList[0]),Element(elementList[1]), Element(elementList[2])];

        let bandGap = calcBandGap(elObjList[0],elObjList[1],elObjList[2]);
        colourLabel.text = mostLikelyColour(bandGap);
        scoreLabel.text = String(calcSusScore(elObjList[0],elObjList[1],elObjList[2]));
        efficiencyLabel.text = String(maximumEfficiency(bandGap)) + "%";
        
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

/*
 Band gap    Max efficiency
 < 0.4   "0% - This material wouldn't absorb enough light to be used as a solar cell"
 0.40   9.66%
 0.60   18.93%
 0.80   25.97%
 1.00   31.57%
 1.20   33.33%
 1.40   33.42%
 1.60   30.54%
 1.80   27.17%
 2.00   22.85%
 2.20   18.58%
 2.40   14.51%
 2.60   10.67%
 2.80   7.12%
 3.00   4.61%
 3.20   2.82%
 3.40   1.71%
 3.60   0.90%
 3.80   0.26%
 4.00   0.02%
 > 4.2  "0% - This material would not absorb any visible light
 */

//maximumEfficiency returns the maximum efficiency for the given combination of elements
func maximumEfficiency(_ bandGap: Float) -> Float{
    
    let efficiencyMap : [Float : Float] = [0:0, 0.4: 9.66, 0.6:18.93, 0.8:25.97, 1.00:31.57, 1.2:33.33, 1.4:33.42,
                                           1.6:30.54, 1.8:27.17, 2.0:22.85, 2.2:18.58, 2.4:14.51, 2.6:10.67,2.8:7.12,
                                           3.0:4.61, 3.2:2.82, 3.4:1.71, 3.6:0.9, 3.8:0.26, 4.00:0.02, 4.2:0]
    
    //Using rounding to determine most opporximate value for efficiency
    let roundedVal = round(bandGap*10)/10;
    var value = roundedVal;
    if(Int(roundedVal*10) % 2 != 0){ //even operation can only be applied to integers
        value = (round(bandGap*100)/100)-0.1; //round to 1 decimal place then subtract 0.1 to get range
    }
    
    if(value <= 4.2 && value >= 0.4){
        value = round(value*10)/10; //added this as theres a strange rounding issue with floats, ensures 2 decimal places
        print(value)
        return efficiencyMap[value]!;
    }else if(value > 4.2){
        return efficiencyMap[4.2]!;
    }else{
        return efficiencyMap[0]!;
    }
}


/*
 Colour ranges:
 > 3.5           Colourless
 3 - 3.49      Green
 2.5 - 2.99  Yellow
 2 - 2.49      Orange
 1.5 - 1.99    Red
 < 1.5
 */

//mostLikelyColour function used to determine the most likely colour of a set of elements
func mostLikelyColour(_ bandGap: Float) -> String{
    
    let colourMapping : [Float : String] = [3.5 : "Colourless", 3 : "Green", 2.5: "Yellow", 2:"Orange", 1.5:"Red", 1:"Black"];

    //Using approximate rounding to determine the most likely colour
    let value = ( (bandGap-0.2)*2).rounded()/2;
    
    if(value <= 3.5 && value >= 1){
        return colourMapping[value]!;
    }else if(value > 3.5){
        return colourMapping[3.5]!;
    }else{
        return colourMapping[1]!;
    }
}

//calcBandGap calculates the bandgap for a given combination of elements
func calcBandGap(_ el1: Element, _ el2:Element, _ el3: Element) -> Float{
    return min(el1.SSE!, el2.SSE!) - el3.SSE!;
}

//calcSusScore function that calculates the sustainability score
func calcSusScore(_ el1: Element, _ el2:Element, _ el3: Element) -> Int {
    //Seperate out the claculations due to issues with rounding
    let a = el1.HHI_r!
    let b = el2.HHI_r!
    let c = el3.HHI_r!
    return (Int(a+b+c));
}
