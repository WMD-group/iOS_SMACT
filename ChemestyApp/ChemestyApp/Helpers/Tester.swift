import Foundation

//Test data_loader.swift
public class TestDataLoader{
    public init(){}
    
    public func Run(){
    
        let temp = Data_loader();
        print("Oxidation statse of Be: ", temp.lookup_element_oxidation_states(symbol: "Be"));
        print("HHI_R and HHI_p scores of Be: ", temp.lookup_element_hhis(symbol: "Be")!);
        print("solid-state energy (SSE) for Be: ", temp.lookup_element_sse_data(symbol: "Be")!);
        print("element data for Be: "); //returns zip2Array
        for (name, value) in temp.lookup_element_data(symbol: "Be"){
            print("\(name) : \(value)");
        }
    }
    
}

public class TestInit{
    public init(){}
    
    public func Run(el1: String, el2: String, el3: String) -> String{
        
        var resultingString : String = "";
        
        let elementH = Element("H");
//        print(elementH.concatObjectData());
//        print("\n");
//        let elementHe = Element(symbol: "He");
//        print(elementHe.concatObjectData());
//        print("\n");
//        let elementBk = Element(symbol: "Bk");
//        print(elementBk.concatObjectData());
//        print("\n");
//        let elementMn = Element(symbol: "Mn");
//        print(elementMn.concatObjectData());
        
//        let test_case1 = ["Na","Ti","F"];
//        let test_case2 = ["Na","K","Cl"];
//        let test_case3 = ["Fe","Cu","Cl"];
//        let test_cases = [test_case1, test_case2, test_case3];
        let test_case1 = [el1, el2, el3];
        let test_cases = [test_case1];
        
        for situation in test_cases{
            let max_amount = 5
            //Charge neutral ratios list is empty
            var cn_list : [[(String, Int)]] = [];
            
            // Iterate through each available oxidation state for each element
            for ox1 in Element(situation[0]).oxidation_states{
                for ox2 in Element(situation[1]).oxidation_states{
                    for ox3 in Element(situation[2]).oxidation_states{
                        let symbols = [situation[0], situation[1], situation[2]];
                        let ox_states = [ox1, ox2, ox3];
                        
                        // Add charge neutral combos to list
                        let (cn_e, cn_r) = elementH.neutral_ratios(oxidations: ox_states, threshold: max_amount);
                        
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
            // And how many are charge neutral (to be used on the next page)
//            print("For elements,", situation);
//            print("There are \(cn_list.count) charge neutral combinations:");
            resultingString += ("For elements \(situation)\n");
            resultingString += ("There are \(cn_list.count) charge neutral combinations:\n");
            
            for item in cn_list{
                // We want to make these look pretty.
                // e.g. [('Na', 1), ('Ti', 1), ('F', 3)] corresponds to NaTiF3 as a chemical formula.
                var formula = String(item[0].0+String(item[0].1)+item[1].0+String(item[1].1)+item[2].0+String(item[2].1));
                formula = formula.replacingOccurrences(of: "1", with: "");

                // Check for perovskite-like compositions i.e. = ABX3
                if (item[0].1 == 1) && (item[1].1 == 1) && (item[2].1 == 3){
//                    print(formula, " <-- Woohoo! We found a 1:1:3 ratio (perovskite)!");
                    resultingString += (formula + " <-- Woohoo! We found a 1:1:3 ratio (perovskite)!\n");
                }else{
//                    print(formula);
                    resultingString += (formula + "\n");
                }
            }
            resultingString += "************\n";
//            print("************");
        }
        //Na, Ti, F
//        print(elementH.is_neutral(oxidations: [1,1,-1], stoichs: [5,5,5]));
//        print(elementH.is_neutral(oxidations: [1,1,-1], stoichs: [1,2,3]));
        
//        print(testElement);
//        print(resultingString);
        return resultingString;
    }
}
