//
//  Chemical_Computation.swift
//  ChemestyApp
//
//  Created by Edward Attard Montalto on 16/06/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//

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
public func determinePerRatio(_ cn_list : [[(String, Int)]]) -> String{
    
    var temp : String = "";
    
    for item in cn_list{
        // We want to make these look pretty.
        // e.g. [('Na', 1), ('Ti', 1), ('F', 3)] corresponds to NaTiF3 as a chemical formula.
        var formula = String(item[0].0+String(item[0].1)+item[1].0+String(item[1].1)+item[2].0+String(item[2].1));
        formula = formula.replacingOccurrences(of: "1", with: "");
        
        // Check for perovskite-like compositions i.e. = ABX3
        if (item[0].1 == 1) && (item[1].1 == 1) && (item[2].1 == 3){
            temp += (formula + " <-- Woohoo! We found a 1:1:3 ratio (perovskite)!\n");
        }else{
            temp += (formula + "\n");
        }
    }
    return temp;
}

//Combines determineChargeNeutral & determinePerRatio to produce the desired list output
public func performComputation(el1: String, el2: String, el3: String) -> String{
    
    var resultingString : String = "";
    
    let cn_list = determineChargeNeutral(el1, el2, el3);
    
    // And how many are charge neutral (to be used on the next page)
    resultingString += ("For elements \([el1, el2, el3])\n");
    resultingString += ("There are \(cn_list.count) charge neutral combinations:\n");
    
    resultingString += determinePerRatio(cn_list);
    
    resultingString += "************\n";
    
    return resultingString;
}
