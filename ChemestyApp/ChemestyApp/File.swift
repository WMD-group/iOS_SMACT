//
//  File.swift
//  ChemestyApp
//
//  Created by Sophie on 12/06/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//

import Foundation

import UIKit
import SceneKit

class ThreeDimensionalView: SCNView {
    
    override func awakeFromNib() {
        configureScene()
        setupNodes()
    }
    
    func configureScene(){
        self.scene = SCNScene()
        
        var cameraNode              = SCNNode()
        cameraNode.camera           = SCNCamera()
        cameraNode.position         = SCNVector3Make(0, 100, 200)
        cameraNode.rotation         = SCNVector4Make(0, 0, 0, 0)
        cameraNode.camera?.xFov     = 80
        cameraNode.camera?.yFov     = 80
        cameraNode.camera?.zNear    = 20
        cameraNode.camera?.zFar     = 4000
        cameraNode.camera?.aperture = 4.286
        self.scene?.rootNode.addChildNode(cameraNode)
        
        var lightNode                = SCNNode()
        lightNode.light              = SCNLight()
        lightNode.position           = SCNVector3Make(0, 150, 200)
        lightNode.rotation           = SCNVector4Make(0, 0, 0, 0)
        //lightNode.light?.color       = UIColor.whiteColor()
        lightNode.light?.shadowColor = UIColor(red:0, green: 0, blue:0, alpha:0.5)
        self.scene?.rootNode.addChildNode(lightNode)
        
        var floor                             = SCNFloor()
        floor.reflectionFalloffEnd            = 50
        floor.firstMaterial?.diffuse.contents = "imageNamed://woodTile"
        var floorNode                         = SCNNode()
        floorNode.geometry                    = floor
        self.scene?.rootNode.addChildNode(floorNode)
    }
    
    func setupNodes(){
        var sphere          = SCNSphere(radius:25)
        sphere.isGeodesic     = false
        sphere.segmentCount = 24
        var sphereNode      = SCNNode()
        sphereNode.position = SCNVector3Make(0, 50, 0)
        sphereNode.rotation = SCNVector4Make(0, 0, 0, 0)
        sphereNode.geometry = sphere
        self.scene?.rootNode.addChildNode(sphereNode)
    }
    
}
