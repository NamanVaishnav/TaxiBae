//
//  LoginVC.swift
//  TaxiBae
//
//  Created by naman vaishnav on 15/10/18.
//  Copyright © 2018 naman vaishnav. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var txtEmail: RoundedCornerTextField!
    @IBOutlet weak var txtPassword: RoundedCornerTextField!
    @IBOutlet weak var authButton: RoundedShadowButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.delegate = self
        txtPassword.delegate = self
        
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
    @IBAction func authBtnPressed(_ sender: Any) {
        
        if txtEmail.hasText && txtPassword.hasText {
            authButton.animateButton(shouldLoad: true, withMessage: nil)
            self.view.endEditing(true)
            
            if let email = txtEmail.text, let password = txtPassword.text {
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if error == nil {
                        if let user = user {
                            if self.segmentedControl.selectedSegmentIndex == 0 { // passenger
                                let userData = ["provider": user.user.providerID] as [String: Any]
                                DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: false)
                                
                            }else{ // Driver
                                let userData = ["provider": user.user.providerID, "userIsDriver": true, "isPickupModeEnabled": false, "driverIsOnTrip": false] as [String: Any]
                                DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: true)
                            }
                            print("Email user authenticated successfully with Firebase")
                            self.authButton.animateButton(shouldLoad: false, withMessage: nil)
                            self.dismiss(animated: true, completion: nil)
                        }
                    } else {
                        
                        
                        if let errorCode = AuthErrorCode(rawValue: error!._code) {
                            switch errorCode {
                            case .invalidEmail:
                                print("Email is Invalid, Please Try Again")
                            case .emailAlreadyInUse:
                                print("THis Emaol is Already in Use Please Try again")
                            case .wrongPassword:
                                print("Whoops! That was the wrong password")
                                
                                
                            default:
                                print(error?.localizedDescription as Any)
                                
                            }
                        }
                        
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                                    switch errorCode {
                                    case .invalidEmail:
                                        print("Email is Invalid, Please Try Again")
                                    case .emailAlreadyInUse:
                                        print("THis Emaol is Already in Use Please Try again")
                                      
                                    default:
                                        print(error?.localizedDescription as Any)
                                        
                                    }
                                }
                            } else {
                                if let user = user {
                                    if self.segmentedControl.selectedSegmentIndex == 0{ // Passenger
                                        let userData = ["provider": user.user.providerID] as [String : Any]
                                        DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: false)
                                    }else{ // Driver
                                        let userData = ["provider": user.user.providerID, "userIsDriver": true, "isPickupModeEnabled": false, "driverIsOnTrip": false] as [String: Any]
                                        DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: true)
                                    }
                                    
                                    print("Successfully Created New User with Firebase")
                                    self.dismiss(animated: true, completion: nil)
                                }
                            }
                        })
                    }
                }
            }
        }
    }
    
}
