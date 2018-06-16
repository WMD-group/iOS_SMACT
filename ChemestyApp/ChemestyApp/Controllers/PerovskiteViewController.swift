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
    
    
    @IBOutlet weak var ThomasImage: UIImageView!
    @IBOutlet weak var SpeechBubble: UIImageView!
    @IBOutlet weak var SpeechLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //Delays:
        //Move Thomas up after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 0.7, animations:{
                self.ThomasImage.frame.origin.y -= 280
                self.SpeechBubble.frame.origin.y -= 280
                self.SpeechLabel.frame.origin.y -= 280
            }, completion: nil)
            
        }
    
//        sceneView.backgroundColor = UIColor.black;
        
        //Creating the scene for the 3D material
//        let scene = SCNScene();
        let scene = SCNScene(named: "3DPerovskite.dae")!;
        
//        let cameraNode = SCNNode();
//        cameraNode.camera = SCNCamera();
//        scene.rootNode.addChildNode(cameraNode);
//        cameraNode.position = SCNVector3(x:70, y:0, z:120);
//        cameraNode.camera!.zFar = 200;
////        cameraNode.look(at: SCNVector3(x:0, y:0, z: 0));
//        
//        //adding light to the scene
//        let lightNode = SCNNode();
//        lightNode.light = SCNLight();
//        lightNode.light!.type = SCNLight.LightType.directional;
////        lightNode.position = SCNVector3(xS: 70, y: 0, z: 120);
//        lightNode.position = SCNVector3(x: 140, y:27, z:-13);
//        scene.rootNode.addChildNode(lightNode);
//        
//        //create and add ambient light
//        let ambientLightNode = SCNNode();
//        ambientLightNode.light = SCNLight();
//        ambientLightNode.light!.type = SCNLight.LightType.ambient;
//        ambientLightNode.light!.color = UIColor.white;
//        scene.rootNode.addChildNode(ambientLightNode);
//        
//        //retrivieing inner geometry
//        let model = scene.rootNode.childNode(withName: "per", recursively: true)!;
//        model.position = SCNVector3(x:0, y:0, z:0);
        
        //Trying to get it to rotate isn't working as expected
//        model.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(Double.pi*2), z: 0, duration: 5)));
        sceneView.scene = scene;
//        let animation = CABasicAnimation(keyPath: "rotation");
//        model.position = SCNVector3(x: 0, y: 0, z:0);
//
//        //creating and adding camera to scene
////        let cameraNode = SCNNode();
////        cameraNode.camera = SCNCamera();
////        scene.rootNode.addChildNode(cameraNode);
////        cameraNode.position = SCNVector3(x: 0, y: 10, z: 0);
//
//        //Lighting effect
//        let lightNode = SCNNode();
//        lightNode.light = SCNLight();
//        lightNode.light!.type = SCNLight.LightType.omni;
//        lightNode.position = SCNVector3(x:10, y:0, z:0);
//        lightNode.light!.color = UIColor.red;
//        scene.rootNode.addChildNode(lightNode);
//
//        //Spinning effect animnation
////        animation.fromValue = NSValue(scnVector4: SCNVector4(x: 0, y: 0, z: 1, w: 0));
////        animation.toValue = NSValue(scnVector4: SCNVector4(x: Float(0), y:Float(0), z: Float(1), w: Float(Double.pi*2)));
//        animation.duration = 3;
//        animation.repeatCount = .infinity;
//        model.addAnimation(animation, forKey: nil);
//
//        sceneView.scene = scene;
        
//        //Creating and adding a camera to the scene
//        let cameraNode = SCNNode();
//        cameraNode.camera = SCNCamera();
//        sceneView.rootNode.addChildNode(cameraNode);
//
        //Placing the camera
//        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15);
        
//        //Adding a light to the scene
//        let lightNode = SCNNode();
//        lightNode.light = SCNLight();
//        lightNode.light!.type = SCNLight.LightType.omni;
//        lightNode.position = SCNVector3(x: 0, y: 10, z: 10);
//        sceneView.rootNode.addChildNode(lightNode);
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
