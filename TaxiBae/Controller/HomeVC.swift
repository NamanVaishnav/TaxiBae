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
import CoreLocation

class HomeVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var actionBtn: RoundedShadowButton!
    var delegate : CenterVCDelegate?
    
    var regionRadius: CLLocationDistance = 1000
    
    let revelingSplashView = RevealingSplashView(iconImage: UIImage(named: "launchScreenIcon")!, iconInitialSize: CGSize(width: 80, height: 80), backgroundColor: .white)
    
    
    var manager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        manager = CLLocationManager()
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyBest

        checkLocationAuthStatus()

        
        mapView.delegate = self
        centerMapOnUserLocation()
        
        self.view.addSubview(revelingSplashView)
        
        revelingSplashView.animationType = SplashAnimationType.woobleAndZoomOut
        revelingSplashView.startAnimation()
        
        revelingSplashView.heartAttack = true
    }
    
    func checkLocationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            manager?.startUpdatingLocation()
        } else {
            manager?.requestAlwaysAuthorization()
        }
    }

    func centerMapOnUserLocation() {
        let coordinateRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func actionBtnWasPressed(_ sender: Any) {
        actionBtn.animateButton(shouldLoad: true, withMessage: nil)
    }
    
    @IBAction func menuBtnWasPressed(_ sender: Any) {
        delegate?.toggleLeftPanel()
    }
    @IBAction func centerMapButtonPressed(_ sender: Any) {
        centerMapOnUserLocation()
    }
}


extension HomeVC : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways{
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
}

extension HomeVC : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
       
	       print("userLocation",userLocation)
        UpdateService.instance.updateUserLocation(withCoordinate: userLocation.coordinate)
        
        UpdateService.instance.updateDriverLocation(withCoordinate: userLocation.coordinate)
      
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? DriverAnnotation {
            let identifier = "driver"
            var view: MKAnnotationView
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.image = UIImage(named: "driverAnnotaion")
            
            return view
        }
        return nil
    }
}


