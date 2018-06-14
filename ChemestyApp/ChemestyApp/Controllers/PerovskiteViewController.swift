//
//  PerovskiteViewController.swift
//  ChemestyApp
//
//  Created by Sophie on 26/04/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//

import UIKit
import SceneKit

class PerovskiteViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        sceneView.backgroundColor = UIColor.black;
        
        //Creating the scene for the 3D material
//        let scene = SCNScene(named: "Assets.xcassets/3DPerovskite.dae")!;
//        
//        //Creating and adding a camera to the scene
//        let cameraNode = SCNNode();
//        cameraNode.camera = SCNCamera();
//        scene.rootNode.addChildNode(cameraNode);
//        
//        //Placing the camera
//        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15);
//        
//        //Adding a light to the scene
//        let lightNode = SCNNode();
//        lightNode.light = SCNLight();
//        lightNode.light!.type = SCNLight.LightType.omni;
//        lightNode.position = SCNVector3(x: 0, y: 10, z: 10);
//        scene.rootNode.addChildNode(lightNode);
//        
//        //retrieve the inner node
//        let element = scene.rootNode.childNode(withName: "element", recursively: true);
//        
//        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func BackButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil);
    }
    
    
}
