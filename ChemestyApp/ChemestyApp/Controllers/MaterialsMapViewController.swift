//
//  MaterialsMapViewController.swift
//  ChemestyApp
//
//  Created by Sophie on 12/06/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MaterialsMapViewController: UIViewController {

    //Image Views
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var PictureFrame: UIImageView!
    @IBOutlet weak var ThomasImageView: UIImageView!
    @IBOutlet weak var SpeechBubbleImage: UIImageView!
    @IBOutlet weak var MaterialMap: UIImageView!
    @IBOutlet weak var MaterialMap1: UIImageView!
    @IBOutlet weak var SpeechLabel: UILabel!
    @IBOutlet weak var SpeechLabel1: UILabel!
    @IBOutlet weak var PlayVidButton: UIButton!
    @IBOutlet weak var X1: UIButton!
    @IBOutlet weak var X2: UIButton!
    @IBOutlet weak var X3: UIButton!
    
    //Buttons
    
    //Unexplored X Button
    @IBAction func UnexploredXButton(_ sender: Any) {
        SpeechLabel.text="We are searching for new materials, which can capture carbon dioxide from the atmosphere and slow down global warming.";
        SpeechLabel1.text="Click on another X or press 'Next' to continue.";
        ImageView.isHidden=false;
        PictureFrame.isHidden=false;
        ImageView.image = UIImage(named: "Click_X_fig_3")
    }
    
    //Solar Panel X Button
    @IBAction func SolarPanelXButton(_ sender: Any) {
        SpeechLabel.text="We are searching for new materials to make solid-state batteries, which can store renewable electricity.";
        SpeechLabel1.text="Click on another X or press 'Next' to continue.";
        ImageView.isHidden=false;
        PictureFrame.isHidden=false;
        ImageView.image = UIImage(named: "Click_X_fig_1")
    }
    
    // Car/Bike X Button
    @IBAction func CarXButton(_ sender: Any) {
        SpeechLabel.text="We are searching for 2-D super-conducting materials, which can improve medical equipment and public transport.";
        SpeechLabel1.text="Click on another X or press 'Next' to continue.";
        ImageView.isHidden=false;
        PictureFrame.isHidden=false;
        ImageView.image = UIImage(named: "Click_X_fig_2")
    }
    
    @IBAction func PlayVideoButton(_ sender: Any) {
        
        var path : String;
        path = (Bundle.main.url(forResource: "MaterialMapAnime_V2", withExtension: ".mov")?.path)!;
        
        let video = AVPlayer(url: URL(fileURLWithPath: path));
        let videoPlayer = AVPlayerViewController()
        videoPlayer.player = video
        
        present(videoPlayer, animated: true, completion:
            {
                video.play()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIView.animate(withDuration: 1, animations:{
                self.MaterialMap.isHidden = true;
                self.MaterialMap1.isHidden = false;
                self.X1.isHidden = false;
                self.X2.isHidden = false;
                self.X3.isHidden = false;
                self.SpeechLabel.text="Scientists are searching the unknown 'material space' for materials which can develop new and existing technologies.";
                self.SpeechLabel1.text="Click on an X to see what they are looking for!";
                self.PlayVidButton.isHidden = true;
            }, completion: nil)
            
            
        }
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Delays:
        //Move Thomas left after 1.0 of a second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIView.animate(withDuration: 1, animations:{
                self.ThomasImageView.isHidden = false;
            }, completion: nil)
            
            
        }
        
        
        //Show speech bubble after 1.5 second delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            UIView.animate(withDuration: 1, animations:{
                self.SpeechBubbleImage.isHidden = false;
                self.SpeechLabel.isHidden = false;
                self.SpeechLabel1.isHidden = false;
                self.PlayVidButton.isHidden = false;
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
