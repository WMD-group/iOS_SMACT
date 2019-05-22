//
//  Chemical_Computation.swift
//  ChemestyApp
//
//  Created by Edward Attard Montalto on 16/06/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//
import UIKit

//determineChargeNeutral determines the charge neutral combinations of the elements
public func determineChargeNeutral(_ el1: String, _ el2: String, _ el3: String) -> [[(String, Int)]]{
    
    //Used to create an instance of the Element class
    let elementH = Element("H");
    
    //Charge neutral ratios list is empty
    var cn_list : [[(String, Int)]] = [];
    
    let elementList = [el1, el2, el3];
    
    let max_amount = 5
    
    // Iterate through each available oxidation state for each element
    for ox1 in Element(elementList[0]).oxidation_states{
        for ox2 in Element(elementList[1]).oxidation_states{
            for ox3 in Element(elementList[2]).oxidation_states{
                let symbols = [elementList[0], elementList[1], elementList[2]];
                let ox_states = [ox1, ox2, ox3];
                
                // Add charge neutral combos to list
                let (_, cn_r) = elementH.neutral_ratios(oxidations: ox_states, threshold: max_amount);
                
                for combination in cn_r{
                    let temp = zip(symbols, combination);
                    var tempList : [(String, Int)] = [];
                    for item in temp{
                        tempList.append(item);
                    }
                    cn_list.append(tempList);
                }
            }
        }
    }
    return cn_list;
}

//determinePerRatio determines if charge netural list for given elements contains a perovskite

//determinePerRatio determines if charge netural list for given elements contains a perovskite and returns number of perovskites
//only returns the chemical formula for the perovskites

public func determinePerRatio(_ cn_list : [[(String, Int)]]) -> (String, Int){
    
    var resString : String = "";
    var numberPer : Int = 0;
    
    for item in cn_list{
        // We want to make these look pretty.
        // e.g. [('Na', 1), ('Ti', 1), ('F', 3)] corresponds to NaTiF3 as a chemical formula.
        var formula = String(item[0].0+String(item[0].1)+item[1].0+String(item[1].1)+item[2].0+String(item[2].1));
        formula = formula.replacingOccurrences(of: "1", with: "");
        
        // Check for perovskite-like compositions i.e. = ABX3
        if (item[0].1 == 1) && (item[1].1 == 1) && (item[2].1 == 3){
            resString += (formula + "\n"); //+ " <-- Woohoo! We found a 1:1:3 ratio (perovskite)!
            numberPer += 1
        }

            //            resString += (formula + "\n");

//            resString += (formula + "\n");

        
    }
    return (resString, numberPer);
}

//Combines determineChargeNeutral & determinePerRatio to produce the desired list output
//Combines determineChargeNeutral & determinePerRatio to produce the desired list output
public func performComputation(el1: String, el2: String, el3: String) -> (String, String, Int, Int){
    
    var resultingString1 : String = "";
    var resultingString2 : String = "";
    
    let cn_list = determineChargeNeutral(el1, el2, el3);
    
    // And how many are charge neutral (to be used on the next page)

    //    resultingString += ("For elements \([el1, el2, el3]):\n");
    resultingString1 += ("Thomas: I found \(cn_list.count) candidate materials.");
    
    let (temp, numPer) = determinePerRatio(cn_list);
    //    resultingString += temp;
    
    resultingString2 += ("Thomas: \(numPer) will make Perovskites.");
    // resultingString += temp;
    //    resultingString += "************\n";
    
    return (resultingString1, resultingString2, cn_list.count, numPer);
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
    
    let colourMapping : [Float : String] = [3.5 : "Colourless", 3 : "Green", 2.5: "Yellow", 2:"Orange", 1.5:"Red", 1:"Nearly Black"];
    
    //Using approximate rounding to determine the most likely colour
    let value = ( (bandGap-0.2)*2).rounded()/2;
    
    if(value <= 3.5 && value >= 1){
        return colourMapping[value]!;
    }else if(value > 3.5){
        return colourMapping[3.5]!;
    }else{
        return "Black";
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
    let d = a+b+c;
    if (d < 20000) {
        return (Int((20000-(a+b+c))/2000));
    }
    else {
        return (0);
    }
}

//susLabel function used to assign the appropriate label to a sus score
func susLabel(_ score: Int) -> String{
    
    /*
    HHI score  Description
    < 1999        Excellent! You've chosen some very widely available elements.
    2000 - 2999   Very good! You've chosen some very abundant elements.
    3000 - 4999   Good! Most of the elements you've chosen are very abundant.
    5000 - 7999   Average. Some of the elements in this compound are more abundant than others.
    8000 - 10000   Not great. Some of the elements in this compound are quite rare.
    > 10000      Bad! Some of the elements in this compound are very rare!
    */
    var msg = "";
    if(score < 2000){
        msg = "Excellent!"
    }else if(score >= 2000 && score < 3000){
        msg = "Very good!"
    }else if(score >= 3000 && score < 5000){
        msg = "Good!"
    }else if(score >= 5000 && score < 8000){
        msg = "Average."
    }else if(score >= 8000 && score <= 10000){
        msg = "Not great!"
    }else{
        msg = "Awful!"
    }
    
    return msg;
}
