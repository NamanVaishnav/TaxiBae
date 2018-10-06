//
//  GradientView.swift
//  TaxiBae
//
//  Created by naman vaishnav on 05/10/18.
//  Copyright © 2018 naman vaishnav. All rights reserved.
//

import UIKit

class GradientView: UIView {

    let gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        setupGradientView()
    }
    
    func setupGradientView() {
         self.layoutIfNeeded()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.locations = [0.8, 1.0]
        gradient.frame = self.bounds
        self.layoutIfNeeded()
        self.layer.addSublayer(gradient)
        
    }
}
