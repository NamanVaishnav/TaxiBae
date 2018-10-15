//
//  RoundImageView.swift
//  TaxiBae
//
//  Created by naman vaishnav on 06/10/18.
//  Copyright © 2018 naman vaishnav. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }

}
