//
//  CircleView.swift
//  AustinWeirdSocial
//
//  Created by Luis Santos on 9/24/19.
//  Copyright © 2019 Luis Santos. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
    }
    
}
