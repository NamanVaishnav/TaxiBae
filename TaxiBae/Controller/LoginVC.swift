//
//  LoginVC.swift
//  TaxiBae
//
//  Created by naman vaishnav on 15/10/18.
//  Copyright © 2018 naman vaishnav. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.bindtoKeyboard()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleScreenTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
   
    @IBAction func actionCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
