//
//  CrystalOptionsController.swift
//  ChemestyApp
//
//  Created by Edward Attard Montalto on 15/04/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//

import UIKit
import SpriteKit

class CrystalOptionsController: UIViewController {
    
    // Thomas' Head Terminal and Perovskite structure
    @IBOutlet weak var ThomasHeadTerm: UIImageView!
    @IBOutlet weak var ThomasHeadTerm1: UIImageView!
    //@IBOutlet weak var MaterialMap: UIImageView!
    
    // Different Pseudo Code Labels
    @IBOutlet weak var PseudoCode1: UILabel!
    @IBOutlet weak var PseudoCode2: UILabel!
    @IBOutlet weak var PseudoCode3: UILabel!
    @IBOutlet weak var PseudoCode4: UILabel!
    @IBOutlet weak var PseudoCode5: UILabel!
    
    //The three element labels
    @IBOutlet weak var aElementChosen: UILabel!
    @IBOutlet weak var bElementChosen: UILabel!
    @IBOutlet weak var xElementChosen: UILabel!
    
    //Labels for displaying text and output
    @IBOutlet weak var computedOutput: UITextView!
    @IBOutlet weak var pseuLabel: UILabel!
    
    //Empty list containing the label values
    var suppliedList : [String] = []; //filled by previous controller
    var selectedElList : [String] = [];
    var computedResult1 : String = "";
    var computedResult2 : String = "";
    var numberOfPerov : Int = 0;
    
    //this function is invoked once the controller is ready (ie loaded into memory)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aElementChosen.text = suppliedList[0];
        bElementChosen.text = suppliedList[1];
        xElementChosen.text = suppliedList[2];
        
        selectedElList = [aElementChosen.text!, bElementChosen.text!, xElementChosen.text!];
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //This is called once the controller is visible
    override func viewDidAppear(_ animated: Bool) {
        
        //Adding this thread to preform actual computation in the background
        DispatchQueue.global(qos: .background).async {
            
            //This is where the actual computation is performed, in the 'background'
            //performComputation function located in Chemical_Computation under Helpers folder
            //self.computedResult

            let (msg1, msg2, chargeNeutrals, numOfPerov)  = performComputation(el1: self.selectedElList[0], el2: self.selectedElList[1], el3: self.selectedElList[2]);
            self.computedResult1 = msg1;
            self.computedResult2 = msg2;
            self.numberOfPerov = numOfPerov;

            //This is done after the background code is computed
//            DispatchQueue.main.async {
//                self.computedOutput.text = self.computedResult;
//            }
        }
        
        // Pseudo Code from 'Thomas' to simulate the computation.
        //
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // change 2 to desired number of seconds
            // Your code with delay
            self.PseudoCode1.isHidden = false;
            self.PseudoCode2.isHidden = false;
            self.PseudoCode3.isHidden = false;
            self.PseudoCode4.isHidden = false;
            self.PseudoCode5.isHidden = false;
            self.ThomasHeadTerm.isHidden = true;
            self.ThomasHeadTerm1.isHidden = false;
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.PseudoCode2.text = "Thomas: Running wake-up scripts ...";
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.PseudoCode3.text = "Thomas: Done!";
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.PseudoCode4.text = "Thomas: Initializing Material Discovery software.";
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            self.PseudoCode5.text = "Thomas: Done!";
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.PseudoCode1.text = "Thomas: Running wake-up scripts ...";
                                self.PseudoCode2.text = "Thomas: Done!";
                                self.PseudoCode3.text = "Thomas: Initializing material discovery software.";
                                self.PseudoCode4.text = "Thomas: Done!";
                                self.PseudoCode5.text = "Thomas: Calculating all possible elemental combinations.";
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                    self.PseudoCode1.text = "Thomas: Done!";
                                    self.PseudoCode2.text = "Thomas: Initializing material discovery software.";
                                    self.PseudoCode3.text = "Thomas: Done!";
                                    self.PseudoCode4.text = "Thomas: Calculating all elemental combinations.";
                                    self.PseudoCode5.text = "Thomas: Done!";
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        self.PseudoCode1.text = "Thomas: Initializing material discovery software.";
                                        self.PseudoCode2.text = "Thomas: Done!";
                                        self.PseudoCode3.text = "Thomas: Calculating all elemental combinations.";
                                        self.PseudoCode4.text = "Thomas: Done!";
                                        self.PseudoCode5.text = "Thomas: Calculating charge neutral combinations.";
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                            self.PseudoCode1.text = "Thomas: Done!";
                                            self.PseudoCode2.text = "Thomas: Calculating all elemental combinations.";
                                            self.PseudoCode3.text = "Thomas: Done!";
                                            self.PseudoCode4.text = "Thomas: Calculating charge neutral combinations.";
                                            self.PseudoCode5.text = "Thomas: Done!";
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                self.PseudoCode1.text = "Thomas: Calculating all elemental combinations.";
                                                self.PseudoCode2.text = "Thomas: Done!";
                                                self.PseudoCode3.text = "Thomas: Calculating charge neutral combinations.";
                                                self.PseudoCode4.text = "Thomas: Done!";
                                                self.PseudoCode5.text = "Thomas: All calculations are complete.";
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                    self.PseudoCode1.text = "Thomas: Done!";
                                                    self.PseudoCode2.text = "Thomas: Calculating charge neutral combinations.";
                                                    self.PseudoCode3.text = "Thomas: Done!";
                                                    self.PseudoCode4.text = "Thomas: All calculations complete.";
                                                    self.PseudoCode5.text = "Thomas: ...";
                                                    
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                                        self.PseudoCode1.text = "Thomas: Calculating charge neutral combinations.";
                                                        self.PseudoCode2.text = "Thomas: Done!";
                                                        self.PseudoCode3.text = "Thomas: All calculations complete.";
                                                        self.PseudoCode4.text = "Thomas: ...";
                                                        self.PseudoCode5.text = self.computedResult1;
                                                    
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                            self.PseudoCode1.text = "Thomas: Done!";
                                                            self.PseudoCode2.text = "Thomas: All calculations complete.";
                                                            self.PseudoCode3.text = "Thomas: ...";
                                                            self.PseudoCode4.text = self.computedResult1;
                                                            self.PseudoCode5.text = self.computedResult2;
                                                            
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                                self.PseudoCode1.text = "Thomas: All calculations complete.";
                                                                self.PseudoCode2.text = "Thomas: ...";
                                                                self.PseudoCode3.text = self.computedResult1;
                                                                self.PseudoCode4.text = self.computedResult2;
                                                                self.PseudoCode5.text = "Thomas: ...";
                                                                
                                                        if self.numberOfPerov == 0 {
                                                    
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                                self.PseudoCode1.text = "Thomas: ...";
                                                                self.PseudoCode2.text = self.computedResult1;
                                                                self.PseudoCode3.text = self.computedResult2;
                                                                self.PseudoCode4.text = "Thomas: ...";
                                                                self.PseudoCode5.text = "Thomas: Oh no! We didn't discover a new Perovskite this time.";
                                                    
                                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                                    self.PseudoCode1.text = self.computedResult1;
                                                                    self.PseudoCode2.text = self.computedResult2;
                                                                    self.PseudoCode3.text = "Thomas: ...";
                                                                    self.PseudoCode4.text = "Thomas: Oh no! We didn't discover a new Perovskite this time.";
                                                                    self.PseudoCode5.text = "Thomas: Press 'Back' to try again.";
                                                                }
                                                            }
                                                        }
                                                            else {

                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                                self.PseudoCode1.text = "Thomas: ...";
                                                                self.PseudoCode2.text = self.computedResult1;
                                                                self.PseudoCode3.text = self.computedResult2;
                                                                self.PseudoCode4.text = "Thomas: ...";
                                                                self.PseudoCode5.text = "Thomas: Wooohoo! We discovered a new perovskite!";
                                                                
                                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                                    self.PseudoCode1.text = self.computedResult1;
                                                                    self.PseudoCode2.text = self.computedResult2;
                                                                    self.PseudoCode3.text = "Thomas: ...";
                                                                    self.PseudoCode4.text = "Thomas: Wooohoo! We discovered a new perovskite!";
                                                                    self.PseudoCode5.text = "Thomas: Press 'Next' to take a closer look.";
                                                                }
                                                            }
                                                        }
                                                    
                    //This is done after the background code is computed
                   // DispatchQueue.main.async {
                       // self.computedOutput.text = self.computedResult;
                        
                    }
                }
            }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    //Created this function manually in order to transfer data between controllers
    @IBAction func nextPage(_ sender: Any) {
        performSegue(withIdentifier: "crystalInfoNav", sender: self);
    }
    
    
    //Function responcible for sending data to next page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Creating an instance of the CrystalOptionsController
        let crystalInfoController = segue.destination as!  CrystalInfoViewController;
        
        //preform check to make sure the data is not null
        crystalInfoController.elementList = suppliedList; //enforcing the type to be list of string
        
    }
    
    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
}
