//
//  CrystalInfoViewController.swift
//  ChemestyApp
//
//  Created by Sophie on 26/04/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//

import UIKit
import SceneKit

class CrystalInfoViewController: UIViewController {
    
    //3D model area
    @IBOutlet weak var sceneView: SCNView!
    
    //Supplied list of elements filled from PeriodicTableController
    var elementList : [String] = []; //filled by previous controller
    
    //Inidividual properties of each element
    var elementHHIs : [Int] = [];
    
    //The three labels storing the information about the desired elements
    @IBOutlet weak var colourLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var efficiencyLabel: UILabel!
    @IBOutlet weak var chemicalFormulaLabel: UILabel!
    
    @IBAction func returnToStart(_ sender: Any) {
        //Resets all view controllers and starts app again from fresh
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil);
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        var elObjList = [Element(elementList[0]),Element(elementList[1]), Element(elementList[2])];
        
        //using the customText swift file to achieve the subscripting
        //github: https://github.com/nicolocandiani/subandsuperscripttext
        let chemForm = elementList[0] + elementList[1] + elementList[2] + "£3$";
        let finalSubScript : NSMutableAttributedString =  chemForm.customText()
        
        chemicalFormulaLabel.attributedText = finalSubScript;
        
        let bandGap = calcBandGap(elObjList[0],elObjList[1],elObjList[2]);
        colourLabel.text = mostLikelyColour(bandGap);
        let susScore = calcSusScore(elObjList[0],elObjList[1],elObjList[2]);
        scoreLabel.text = String(susScore) + " - " + susLabel(susScore);
        efficiencyLabel.text = String(maximumEfficiency(bandGap)) + "%";
        
        let scene = SCNScene(named: "3DPerovskite.dae")!;
        sceneView.scene = scene;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //BackButton
    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
}
