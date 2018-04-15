import Foundation

public class Data_loader{
    
    private var _print_warnings : Bool;
    private var data_directory : String;
//    private var _element_data : Any?; //Basically saying it might Optionally be Any type
    
    //Data-holding variables
    private var _element_data : Dictionary<String, Zip2Sequence<Array<String>, Array<Any>> >;
    private var _element_ox_states : Dictionary<String, [Int]>;
    private var _element_hhis : Dictionary<String, (Float, Float)>; //String to pair of floats
    private var _element_sse_data : Dictionary<String, (String, Float)>;
    
    public init() {
        _print_warnings = false;
        data_directory = "../Data_Store/";
        
        //Init data holding variables
        _element_data = Dictionary<String, Zip2Sequence<Array<String>, Array<Any>> >(); //empty dictionary of type String: Any
        _element_ox_states = Dictionary<String, [Int]>(); //init the dictionary
        _element_hhis = Dictionary<String, (Float, Float)>();
        _element_sse_data = Dictionary<String, (String, Float)>();
    }
    
    func set_warnings(enable : Bool = true){
        /*Set verbose warning messages on and off.
        In order to see any of the warnings, this function needs to be
        called _before_ the first call to the smact.Element()
        constructor.

        Args:
        enable (bool) : print verbose warning messages.
        */
        _print_warnings = enable;
    }
    
    //Returns the contents of a file as an Array of Strings
    //Each index is a row in the file
    func _get_data_rows(filename: String, filetype: String) -> [[String]]{
        //Generator for datafile entries by row
        var myStrings : [String] = [""];

        //Reading in the file
//        if let path = Bundle.main.path(forResource: data_directory+filename, ofType: filetype) {
//            do {
//                let data = try String(contentsOfFile: path, encoding: .utf8)
//                myStrings = data.components(separatedBy: .newlines);
//            } catch {
//                print(error)
//            }
//        }
        
        //Reading in the file
        //.path converts it to a String
        if let path = Bundle.main.url(forResource: filename, withExtension: filetype)?.path {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                myStrings = data.components(separatedBy: .newlines);
            } catch {
                print(error)
            }
        }
        
        //$0 represents each item in the array
        let reducedFile = myStrings.filter{ !$0.hasPrefix("#") };
        //Go through each element of reducedFile array and:
        //replace each multiple white space in string with single white space
        //then split the string into array of strings on the single whitespace as separator
        var furtherReduced = reducedFile.map{
            ($0.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)).components(separatedBy: .whitespaces)
        };
        furtherReduced.remove(at: furtherReduced.count-1); //removing the [""] at the end of the array
        return furtherReduced;
    }
    
    //The Float? allows for nil values ... I think
    func float_or_Nil(x: String) -> Float?{
        //Cast a string to a float or to a None
        return Float(x);
    }
    
    //Unwraps Any type. Ex: extracts value from Optional(1.29) as 1.29
    //Returns NSNull() object is not able to unwrap
    //Sources from stack overflow
    func unwrap(any:Any) -> Any {
        
        let mi = Mirror(reflecting: any)
        if mi.displayStyle != .optional {
            return any
        }
        
        if mi.children.count == 0 { return NSNull() }
        let (_, some) = mi.children.first!
        return some
        
    }

    //Returns value assoicated with key of Dictionary
    func lookup_element_data( symbol : String, copy:Bool = true) -> Zip2Sequence<Array<String>, Array<Any>>{
        /*
        Retrieve tabulated data for an element.

        The table "data/element_data.txt" contains a collection of relevant
        atomic data. If a cache exists in the form of the module-level
        variable _element_data, this is returned. Otherwise, a dictionary is
        constructed from the data table and cached before returning it.

        Args:
            symbol (str) : Atomic symbol for lookup

            copy (Optional(bool)) : if True (default), return a copy of the
                data dictionary, rather than a reference to the cached
                object -- only used copy=False in performance-sensitive code
                and where you are certain the dictionary will not be
                modified!

        Returns (dict): Dictionary of data for given element, keyed by
            column headings from data/element_data.txt
         */
        
        if _element_data.count == 0{
            //Creating a String : Any dictionary
            let Keys : [String] = ["Symbol", "Name", "Z", "Mass", "r_cov", "e_affinity", "p_eig", "s_eig", "Abundance", "el_neg", "ion_pot"];

            //Gets all the data from the file element_data.txt as a 2D string array
            let elementDataFile = _get_data_rows(filename: "element_data", filetype: "txt");
            
            for items in elementDataFile{
                
                //Take each item in the list and:
                //filter the items out into Optional(number) and nil
                var convertedNumerals = items.map({ float_or_Nil(x: $0) }); //force unwrapping the value
                var tempList : [String] = Array(items[0...1]); //store each string in an array of type Any
                let tempListBack : [Float?] = Array(convertedNumerals[2...]);
                
                var convertedList : [Any] = tempList;
                
                //Joining the two lists together
                for item in tempListBack{
                    convertedList.append(item as Any); //Type casting gets rid of warning message
                }
                
                //Unwrapping each item in the list
                let unwrappedList : [Any] = convertedList.map({ unwrap(any: $0) } );
                
                //Zipping keys with items together
                let zipped = zip(Keys, unwrappedList);
                
                //Asign value with key element data converted to String
                //Each key is assoicated with a list of pairs of each element
                _element_data[tempList[0]] = zipped;
             }
        }
        
        //If the item is a key in the dictionary
        if _element_data[symbol] != nil{
            
            //Check if the copy thing is necessary, hard to implement in swift
            
            //Return the value assoicated with this specific symbol
            return _element_data[symbol]!;
        }else{
            if _print_warnings{
                print("WARNING: Elemental data for %@ not found", symbol); //%@ should be replaced by the string
                print(_element_data);
            }
            //Return empty list isntead of None/nil due to compatibility issues with nil and Any
            return zip([],[]);
        }
        
    }
    
    func lookup_element_oxidation_states(symbol : String, copy : Bool = true) -> [Int]{
        /*
        Retrieve a list of known oxidation states for an element.
        The oxidation states list used is the SMACT default and
        most exhaustive list.

        Args:
            symbol (str) : the atomic symbol of the element to look up.
            copy (Optional(bool)): if True (default), return a copy of the
                oxidation-state list, rather than a reference to the cached
                data -- only use copy=False in performance-sensitive code
                and where the list will not be modified!

        Returns:
            list: List of known oxidation states for the element.

                Return None if oxidation states for the Element were not
                found in the external data.
        */
        
        if _element_ox_states.count == 0{
            
            //Gets all the data from the file element_data.txt as a 2D string array
            let oxidationFileData = _get_data_rows(filename: "oxidation_states", filetype: "txt");
            
            for items in oxidationFileData{

                var convertedOx : [Int] = [];
                for i in items[1...]{
                    convertedOx.append(Int(i)!); //use ! to unwrap
                }
                _element_ox_states[items[0]] = convertedOx;
            }
        }
        
        //If the item is a key in the dictionary
        if _element_ox_states[symbol] != nil{
            
            //Check if the copy thing is necessary, hard to implement in swift
            
            //Return the value assoicated with this specific symbol
            //            dump(_element_data[symbol]);
            return _element_ox_states[symbol]!;
        }else{
            if _print_warnings{
                print("WARNING: Oxidation states for element %@ not found", symbol); //%@ should be replaced by the string
            }
            //Return empty list isntead of None/nil due to compatibility issues with nil and Any
            return [-99999]; //using a large negative to reflect that element is not in dictionary
        }
        
    }
    
    func lookup_element_hhis(symbol: String) -> (Float, Float)!{ //explicity unwraps it - nil! = none (wow)
        /*
        Retrieve the HHI_R and HHI_p scores for an element.

        Args:
            symbol : the atomic symbol of the element to look up.

        Returns:
            A (HHI_p, HHI_R) tuple, or None if values for the elements were
            not found in the external data.
        */
        if _element_hhis.count == 0{
            
            let hhisFileData = _get_data_rows(filename: "HHIs", filetype: "txt");
            
            for item in hhisFileData{
                _element_hhis[item[0]] = (Float(item[1])!, Float(item[2])!);
            }
        
        }
        
        //If the item is a key in the dictionary
        if _element_hhis[symbol] != nil{
            
            //Check if the copy thing is necessary, hard to implement in swift
            
            //Return the value assoicated with this specific symbol
            return _element_hhis[symbol]!;
        }else{
            if _print_warnings{
                print("WARNING: HHI data for element %@ not found", symbol); //%@ should be replaced by the string
            }
            //Return empty list isntead of None/nil due to compatibility issues with nil and Any
            return (0, 0); //is this ok?
        }
        
    }
    
    func lookup_element_sse_data(symbol: String) -> (String, Float)!{
        /*
        Retrieve the solid-state energy (SSE) data for an element.

        Taken from J. Am. Chem. Soc., 2011, 133 (42), pp 16852-16960,
        DOI: 10.1021/ja204670s

        Args:
            symbol : the atomic symbol of the element to look up.

        Returns:
            A dictionary containing the SSE dataset for the element, or None
            if the element was not found among the external data.
        */
        
        if _element_sse_data.count == 0{
            
            let sseFileData = _get_data_rows(filename: "SSE", filetype: "csv");
            
            //Split internal string of each list elemnt on ","
            let furtherReducedSSE = sseFileData.map{
                ($0[0]).components(separatedBy: ",")
            };
            
            for item in furtherReducedSSE{
                _element_sse_data[item[0]] = ("SolidStateEnergy", Float(item[1])!);
            }
        }
        
        //If the item is a key in the dictionary
        if _element_sse_data[symbol] != nil{
            
            //Check if the copy thing is necessary, hard to implement in swift
            
            //Return the value assoicated with this specific symbol
            return _element_sse_data[symbol]!;
        }else{
            if _print_warnings{
                print("WARNING: Solid-state energy data element %@ not found", symbol); //%@ should be replaced by the string
            }
            //Return empty tuple isntead of None/nil due to compatibility issues with nil and Any
            return ("", 0);
        }
    }
}
