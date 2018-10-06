//
//  RoundedShadowView.swift
//  TaxiBae
//
//  Created by naman vaishnav on 06/10/18.
//  Copyright © 2018 naman vaishnav. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {
    
    override func awakeFromNib() {
        setupView()
    }

    func setupView() {
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.cornerRadius = 5
    }
}
