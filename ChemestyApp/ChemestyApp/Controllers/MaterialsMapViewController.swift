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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Delays:
        //Move Thomas left after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 1, animations:{
                self.ThomasImageView.frame.origin.x -= 453
            }, completion: nil)
            
            
        }
        
        //Show speech bubble after 2 second delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 1, animations:{
                self.SpeechBubbleImage.isHidden = false;
                self.SpeechLabel.isHidden = false;
            }, completion: nil)

    }
        
    
        
        
    }
    
   
    
    //X Buttons
    //GREEN X -> display figure 1
    @IBAction func displayImage1(_ sender: Any) {
        ImageView.image = UIImage(named: "Click_X_fig_1.png")
    }
    
    //PINK X -> display figure 2
    @IBAction func displayImage2(_ sender: Any) {
        ImageView.image = UIImage(named: "Click_X_fig_2.png")
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    //Back Button to IntroPage (Page 1)
    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
