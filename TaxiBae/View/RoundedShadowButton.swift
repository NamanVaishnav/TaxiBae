//
//  RoundedShadowButton.swift
//  TaxiBae
//
//  Created by naman vaishnav on 06/10/18.
//  Copyright © 2018 naman vaishnav. All rights reserved.
//

import UIKit

class RoundedShadowButton: UIButton {

    var originalSize : CGRect?
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        originalSize = self.frame
        self.layer.cornerRadius = 5.0
        self.layer.shadowRadius = 10.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
    }
    
    func animateButton(shouldLoad: Bool, withMessage message:String?) {
        
        let spinner = UIActivityIndicatorView()
        spinner.style = .whiteLarge
        spinner.color = UIColor.darkGray
        spinner.alpha = 0.0
        spinner.hidesWhenStopped = true
        spinner.tag = 21
        
        if shouldLoad {
            self.addSubview(spinner)
            self.setTitle("", for: .normal)
            UIView.animate(withDuration: 0.5, animations: {
                self.layer.cornerRadius = self.frame.height/2
                self.frame = CGRect(x: self.frame.midX - (self.frame.height/2), y: self.frame.origin.y, width: self.frame.height, height: self.frame.height)
            }) { (finished) in
                if finished {
                    
                    spinner.startAnimating()
                    spinner.center = CGPoint(x: self.frame.width/2 + 1, y: self.frame.width/2 + 1)
                    UIView.animate(withDuration: 0.2, animations: {
                        spinner.alpha = 1.0
                    })
                    self.isUserInteractionEnabled = false
                }
            }
        } else {
            self.isUserInteractionEnabled = true
            
            for subView in self.subviews {
                if subView.tag == 21 {
                    subView.removeFromSuperview()
                }
            }
            
            UIView.animate(withDuration: 0.2) {
                self.layer.cornerRadius = 5.0
                self.frame = self.originalSize!
                self.setTitle(message, for: .normal)
            }
        }
    }
}
