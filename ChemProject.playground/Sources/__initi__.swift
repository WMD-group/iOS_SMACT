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
    
    private let HHI_r : Float?;
    private let name : String;
    private let zNumber : Float;
    private let oxidation_states : [Int];
    private let SSE : Float?;
    private let superSymbol : String;
    
    public init(symbol : String) {
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
    
    func neutral_ratios_iter(oxidations : [Int], stoichs : Bool = false, threshold : Int = 5) -> (Int, Int){
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
            var stoichsList = Array(repeating: Array(1..<threshold+1), count: oxidations.count);
            
        }
        
        // First filter: remove combinations which have a common denominator
        // greater than 1 (i.e. Use simplest form of each set of ratios)
        // Second filter: return only charge-neutral combinations
        print("Oxidations: ", oxidations);
        
        //not sure how to do the next bit ...
        
        return (0,0);
    }
    func is_neutral(oxidations: (Int, Int), stoichs: (Int,Int)) -> Bool{
        /*
        Check if set of oxidation states is neutral in given stoichiometry

        Args:
            oxidations (tuple): Oxidation states of a set of oxidised elements
            stoichs (tuple): Stoichiometry values corresponding to `oxidations`
        */
        let temp = multiplyTuples(a: oxidations, b: stoichs);
        return 0 == (temp.0+temp.1);
    }
    func multiplyTuples(a: (Int, Int), b: (Int, Int)) -> (Int, Int){
        return (a.0*b.0, a.1*b.1);
    }
    
    func _gcd_recursive(_ args: Int...) -> Int{ //... allows for any arbitrary number of arguments to be passed (creates a list internally (maybe))
        /*
        Get the greatest common denominator among any number of ints
        */
        if args.count == 2{
            return gcd(args[0], args[1]);
        }else{
//            return gcd(args[0], _gcd_recursive(args[1...])); //not supported yet ...
        }
        return 0;
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
