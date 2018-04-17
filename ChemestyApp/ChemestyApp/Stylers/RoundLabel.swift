//
//  RoundLabel.swift
//  ChemestyApp
//
//  Created by Sophie on 17/04/2018.
//  Copyright © 2018 Edward Attard Montalto. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundLabel: UILabel {
    
    @IBInspectable var roundLabel:Bool = false {
        
        didSet {
            if roundLabel {
                layer.cornerRadius = frame.height / 2
                layer.masksToBounds = true
            }
        }
        
    }
    
    override func prepareForInterfaceBuilder() {
        if roundLabel {
            layer.cornerRadius = frame.height / 2
        }
    }
    //self.label.layer.cornerRadius = label.frame.size.width / 2;
   // self.label.ClipsToBounds = YES;

}
