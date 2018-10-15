//
//  HomeVC.swift
//  TaxiBae
//
//  Created by naman vaishnav on 05/10/18.
//  Copyright © 2018 naman vaishnav. All rights reserved.
//

import UIKit
import MapKit

class HomeVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var actionBtn: RoundedShadowButton!
    var delegate : CenterVCDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func actionBtnWasPressed(_ sender: Any) {
        actionBtn.animateButton(shouldLoad: true, withMessage: nil)
    }
    
    @IBAction func menuBtnWasPressed(_ sender: Any) {
        delegate?.toggleLeftPanel()
    }
}

extension HomeVC : MKMapViewDelegate{
    
}
