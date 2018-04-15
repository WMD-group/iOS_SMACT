//
//  RoundButton.swift
//  ChemestyApp
//
//  Created by Edward Attard Montalto on 15/04/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//

import Foundation;
import UIKit;

@IBDesignable
class RoundButton: UIButton{
    
    @IBInspectable var roundButton:Bool = false {
        didSet {
            if roundButton {
                layer.cornerRadius = frame.height / 2
            }
        }
        
    }
    
    override func prepareForInterfaceBuilder() {
        if roundButton {
            layer.cornerRadius = frame.height / 2
        }
    }
    
}
