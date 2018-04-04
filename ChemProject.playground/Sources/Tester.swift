import Foundation

//Test data_loader.swift
public class TestDataLoader{
    public init(){}
    
    public func Run(){
    
        let temp = Data_loader();
//        temp.lookup_element_data(symbol: "He");
//        temp.lookup_element_data(symbol: "He", copy:true);
    
//        print(temp._get_data_rows(filename: "element_data"));
        
//        print(temp.float_or_Nil(x: "1")!); //returns Optional(1.0) ??
//        print(temp.float_or_Nil(x: "hi")); //returns nil
//        let testHe = temp.lookup_element_data(symbol: "He"); //allows me to inspect output
//        print(type(of: testHe))
//        let testing = [Any](testHe);
//        for (item,value) in testHe{
//            print("\(item) : \(value)");
//        }
        
//        dump(testHe);
//
//        print(temp.lookup_element_data(symbol: "Joe")); //Returns an empty list - great (joe is not a valid symbol)!
//        temp.lookup_element_data(symbol: "Joe").count == 0? print("List is empty") : print("List has stuff in it")
//        print(temp.lookup_element_oxidation_states(symbol: "Mn"));
//        print(temp.lookup_element_oxidation_states(symbol: "He"));
//        print(temp.lookup_element_oxidation_states(symbol: "O"));
        
//        print(temp.lookup_element_hhis(symbol: "He"));
//        print(temp.lookup_element_hhis(symbol: "Joe"));
        
//        print(temp.lookup_element_sse_data(symbol: "Li")!);
//        print(temp.lookup_element_sse_data(symbol: "Joe"));
        
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
    
    public func Run(){
        
        let elementH = Element(symbol: "H");
        print(elementH.concatObjectData());
        print("\n");
        let elementHe = Element(symbol: "He");
        print(elementHe.concatObjectData());
        print("\n");
        let elementBk = Element(symbol: "Bk");
        print(elementBk.concatObjectData());
        print("\n");
        let elementMn = Element(symbol: "Mn");
        print(elementMn.concatObjectData());

//        print(testElement);
    }
}
