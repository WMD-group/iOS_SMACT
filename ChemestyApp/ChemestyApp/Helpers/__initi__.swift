import Foundation

//Make funcitons public in order for them to be accessible from the playgroud
public enum ElementError: Error{
    case NameError(String)
}

public class Element {
    /*
    Collection of standard elemental properties for given element.
    
    Data is drawn from "data/element.txt", part of the Open Babel
    package.
    
    Attributes:
    Element.symbol (string) : Elemental symbol used to retrieve data
    
    Element.name (string) : Full name of element
    
    Element.number (int) : Proton number of element
    
    Element.SSE (float) : Solid State Energy
    
    Element.oxidation_states (list) : Default list of allowed oxidation states for use in SMACT
    
    Element.HHI_r (float) : Hirfindahl-Hirschman Index for elemental reserves
    
    Raises:
    NameError: Element not found in element.txt
    Warning: Element not found in Eigenvalues.csv
    */
    
    private var data_loader : Data_loader;
    private var dataset : Array<(String, Any)>;
    private var HHI_scores : (Float, Float)!;
    private var sse_data : (String, Float)?;
    private var sse : Float?;
    
    /*
        internal is private to the current module. fileprivate is private to the current file (which used to be called private).
        The new private is private to the current scope (closer to what most people probably think of as private).
     */
    internal let HHI_r : Float?;
    internal let name : String;
    internal let zNumber : Float;
    internal let oxidation_states : [Int];
    internal let SSE : Float?;
    internal let superSymbol : String;
    
    //added the _ to avoid having to type sumbol : ... each time Element class is instansiated
    public init(_ symbol : String) {
        /*
        Initialise Element class

        Args:
            symbol (str): Chemical element symbol (e.g. 'Fe')

        */
        
        //Creating an instance of the Data_loader() class
        data_loader = Data_loader();
        
        dataset = Array(data_loader.lookup_element_data(symbol: symbol, copy: false));
        
        HHI_scores = data_loader.lookup_element_hhis(symbol: symbol);
        
        sse_data = data_loader.lookup_element_sse_data(symbol: symbol);
        
        if sse_data! != ("", 0){
            sse = sse_data!.1 as Float; //type casting removes Optional()
        }else{
            sse = nil;
        }
        
        //Assigning specific values to globals
        if HHI_scores == (0,0){
            HHI_r = nil;
        }else{
            HHI_r = HHI_scores.1; //Accessing second element of the tuple
        }
        
        name = (dataset[1]).1 as! String;
        zNumber = (dataset[2]).1 as! Float;
        oxidation_states = data_loader.lookup_element_oxidation_states(symbol: symbol);
        SSE = sse;
        superSymbol = symbol;
        
    }
    
    func neutral_ratios_iter(oxidations : [Int], stoichs : Bool = false, threshold : Int = 5) -> ([[Int]]){
        /*
        Iterator for charge-neutral stoichiometries

        Given a list of oxidation states of arbitrary length, yield ratios in which
        these form a charge-neutral compound. Stoichiometries may be provided as a
        set of legal stoichiometries per site (e.g. a known family of compounds);
        otherwise all unique ratios are tried up to a threshold coefficient.

        Args:
            oxidations : list of integers
            stoichs : stoichiometric ratios for each site (if provided)
            threshold : single threshold to go up to if stoichs are not provided

        Yields:
            tuple: ratio that gives neutrality
        */
        var stoichsList : [[Int]] = [];
        if !stoichs{
            //in python:
            //[list(range(1,threshold+1)]* len(oxidations)
            //creates a 2D list, with each inner list repeated len(oxidations) times
            //ex: [list(range(1,3))]*3 -> [[1, 2], [1, 2], [1, 2]]
            //Creating the 2D array
            stoichsList = Array(repeating: Array(1..<threshold+1), count: oxidations.count);
            
        }
        // First filter: remove combinations which have a common denominator
        // greater than 1 (i.e. Use simplest form of each set of ratios)
        // Second filter: return only charge-neutral combinations
        
        //Loop through each level of the combindations list
        //Each array within stoichsList represents an Array of numbers 1->5
        //Thoose numbers are used to combine x number of that element with another element ( x in stoichsList[i] )
        var allowedList : [[Int]] = [];
        for el1 in stoichsList[0]{
            for el2 in stoichsList[1]{
                for el3 in stoichsList[2]{
                    let neutral = is_neutral(oxidations: oxidations, stoichs: [el1, el2, el3]);
                    let gcd = findGCDList(arr: [el1, el2, el3]);
                    
                    if neutral && gcd == 1{
                        //added this combindation to the list
                        allowedList.append([el1, el2, el3]);
                    }
                }
            }
        }
        
        return (allowedList);
    }
    //Given a tuple of oxidation states, find the corresponding charge neutral states
    func neutral_ratios(oxidations : [Int], stoichs : Bool = false, threshold : Int = 5) -> (Bool, [[Int]]){
        /*
        Get a list of charge-neutral compounds

        Given a list of oxidation states of arbitrary length, yield ratios in which
        these form a charge-neutral compound. Stoichiometries may be provided as a
        set of legal stoichiometries per site (e.g. a known family of compounds);
        otherwise all unique ratios are tried up to a threshold coefficient.

        Given a list of oxidation states of arbitrary length it searches for
        neutral ratios in a given ratio of sites (stoichs) or up to a given
        threshold.

        Args:
            oxidations (list of ints): Oxidation state of each site
            stoichs (list of positive ints): A selection of valid stoichiometric
                ratios for each site
            threshold (int): Maximum stoichiometry coefficient; if no 'stoichs'
                argument is provided, all combinations of integer coefficients up
                to this value will be tried.

        Returns:
            (exists, allowed_ratios) (tuple):

            exists *bool*:
                True ifc any ratio exists, otherwise False

            allowed_ratios *list of tuples*:
                Ratios of atoms in given oxidation
                states which yield a charge-neutral structure
        */
        
        let allowed_ratios = neutral_ratios_iter(oxidations: oxidations);
        
        return (allowed_ratios.count > 0, allowed_ratios);
    }
    
    func is_neutral(oxidations: [Int], stoichs: [Int]) -> Bool{
        /*
        Check if set of oxidation states is neutral in given stoichiometry

        Args:
            oxidations (tuple): Oxidation states of a set of oxidised elements
            stoichs (tuple): Stoichiometry values corresponding to `oxidations`
        */
        
        //Take in list of oxidation states and list of stoichs
        //Check for neutrality
        
        let multipliedList = zip(oxidations, stoichs).map{ $0 * $1 } //create list of tuples then multiple tuples together
        //0 is the first number added with each element of the list
        let sumnation = multipliedList.reduce(0, +);
        return sumnation == 0;
    }
    
//    func _gcd_recursive(list: [Int]) -> Int{ //... allows for any arbitrary number of arguments to be passed (creates a list internally (maybe))
//        /*
//        Get the greatest common denominator among any number of ints
//        */
//        if list.count == 2{
//            return gcd(list[0], list[1]);
//        }else{
////            return gcd(list[0], _gcd_recursive(list: Array(dropFirst(list)))); //not supported yet ...
//        }
//        return 0;
//    }
    
    //Correctly finds GCD of list of numbers!
    //n = arr.count-1
    func findGCDList(arr: [Int]) -> Int{
        var result = arr[0];
        let n = arr.count-1;
        for i in 1...n{
            result = gcd(arr[i], result);
        }
        return result;
    }
    
    //Implementing gcd
    //Sources from github
    func gcd(_ a: Int, _ b: Int) -> Int {
        let r = a % b
        if r != 0 {
            return gcd(b, r)
        } else {
            return b
        }
    }
    
    func concatObjectData() -> String{
        return """
                Name: \(name)
                Symbol: \(superSymbol)
                Oxidation_states: \(oxidation_states)
                SSE: \(SSE as Float?)
                zNumber: \(zNumber)
                HHI_r: \(HHI_r as Float?)
                """;
    }
}
