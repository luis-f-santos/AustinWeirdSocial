//
//  ShadowField.swift
//  AustinWeirdSocial
//
//  Created by Luis Santos on 9/19/19.
//  Copyright © 2019 Luis Santos. All rights reserved.
//

import UIKit

class ShadowField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 9.2).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
        
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
}
