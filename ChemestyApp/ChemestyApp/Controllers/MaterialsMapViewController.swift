//
//  MaterialsMapViewController.swift
//  ChemestyApp
//
//  Created by Sophie on 12/06/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//

import UIKit

class MaterialsMapViewController: UIViewController {

    //Image Views
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var ThomasImageView: UIImageView!
    @IBOutlet weak var SpeechBubbleImage: UIImageView!
    @IBOutlet weak var SpeechLabel: UILabel!
    
    //Buttons
    
    //Unexplored X Button
    @IBAction func UnexploredXButton(_ sender: Any) {
        SpeechLabel.text="Scientists think that less than 1% of 1% of 1% of the possible materials space has actually been explored! Somewhere in the unexplored space could be the best new solar cell, battery or superconductor material of tomorrow. Maybe we’ll discover it today!";
        ImageView.isHidden=true;
    }
    
    //Solar Panel X Button
    @IBAction func SolarPanelXButton(_ sender: Any) {
        SpeechLabel.text="This is the structure of CIGS which can be used to make solar cells. It is made out of some sustainable elements – Copper and Sulfur, as well as some that are harder to find and more expensive – Indium and Gallium.";
        ImageView.isHidden=false;
        ImageView.image = UIImage(named: "Click_X_fig_1")
    }
    
    // Car/Bike X Button
    @IBAction func CarXButton(_ sender: Any) {
        SpeechLabel.text="This is the structure of Lithium Iron Phosphate.  It can be used to make batteries which power electric bikes or cars.";
        ImageView.isHidden=false;
        ImageView.image = UIImage(named: "Click_X_fig_2")
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Delays:
        //Move Thomas left after 0.5 of a second
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 1, animations:{
                self.ThomasImageView.frame.origin.x -= 453
            }, completion: nil)
            
            
        }
        
        //Show speech bubble after 1.5 second delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            UIView.animate(withDuration: 1, animations:{
                self.SpeechBubbleImage.isHidden = false;
                self.SpeechLabel.isHidden = false;
            }, completion: nil)
            
        }}
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Back Button to IntroPage (Page 1)
    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    

}
