//
//  ViewController.swift
//  TaxiBae
//
//  Created by naman vaishnav on 05/10/18.
//  Copyright © 2018 naman vaishnav. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var actionBtn: RoundedShadowButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func actionBtnWasPressed(_ sender: Any) {
        actionBtn.animateButton(shouldLoad: true, withMessage: nil)
    }
    
}

extension ViewController : MKMapViewDelegate{
    
}
