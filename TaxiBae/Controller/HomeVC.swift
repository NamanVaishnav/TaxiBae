//
//  HomeVC.swift
//  TaxiBae
//
//  Created by naman vaishnav on 05/10/18.
//  Copyright © 2018 naman vaishnav. All rights reserved.
//

import UIKit
import MapKit
import RevealingSplashView

class HomeVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var actionBtn: RoundedShadowButton!
    var delegate : CenterVCDelegate?
    let revelingSplashView = RevealingSplashView(iconImage: UIImage(named: "launchScreenIcon")!, iconInitialSize: CGSize(width: 80, height: 80), backgroundColor: .white)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(revelingSplashView)
        
        revelingSplashView.animationType = SplashAnimationType.woobleAndZoomOut
        revelingSplashView.startAnimation()
        
        revelingSplashView.heartAttack = true
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
