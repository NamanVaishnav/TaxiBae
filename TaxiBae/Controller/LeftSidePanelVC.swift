//
//  LeftSidePanelVC.swift
//  TaxiBae
//
//  Created by naman vaishnav on 06/10/18.
//  Copyright © 2018 naman vaishnav. All rights reserved.
//

import UIKit
import Firebase

class LeftPanelBottomView: UIView {
    static let instace = LeftPanelBottomView()
    let appDelegate = AppDelegate.getAppDelegate()
    @IBOutlet weak var switchPickupMode: UISwitch!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var userImageView: RoundImageView!
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var lblDriveOrPassnger: UILabel!
    @IBOutlet weak var lblPickupMode: UILabel!
    let currentUserId = Auth.auth().currentUser?.uid
    
    static func test() -> UIView{
        return UINib(nibName: "LeftPanelBottomView", bundle: Bundle.main).instantiate(withOwner: self, options: nil)[0] as! UIView
    }
    @IBAction func actionSwitchPickupMode(_ sender: Any) {
        print("Switch Clicked")
        if self.switchPickupMode.isOn {
            self.lblPickupMode.text = "PICKUP MODE ENABLED"
           appDelegate.MenuContainerVC.toggleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickupModeEnabled" : true])
        }else{
            self.lblPickupMode.text = "PICKUP MODE DISABLED"
            appDelegate.MenuContainerVC.toggleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickupModeEnabled" : false])
        }
        
    }
    @IBAction func actionSignOut(_ sender: Any) {
        
        
        if Auth.auth().currentUser == nil {
            let loginVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            
            self.window?.rootViewController!.present(loginVC, animated: true, completion: nil)
        }else{
            do {
                try Auth.auth().signOut()
                self.lblEmailAddress.text = ""
                self.lblDriveOrPassnger.text = ""
                self.userImageView.isHidden = true
                self.lblPickupMode.text = ""
                self.switchPickupMode.isHidden = true
                self.btnSignIn.setTitle("Sign Up / Login", for: .normal)
                
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
        
      
    }
}

class LeftSidePanelVC: UIViewController {

    var arrMenuItems = NSMutableArray()
    var view1  = LeftPanelBottomView()
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view1 = LeftPanelBottomView.test() as! LeftPanelBottomView
        view1.lblEmailAddress.text = "namanmvaishnav@gmail.com"
        view1.lblDriveOrPassnger.text = "Naman"
        view1.lblPickupMode.isHidden = true
        
        view1.switchPickupMode.isHidden = true
        view1.switchPickupMode.isOn = false
        
        viewBottom.addSubview(view1)
        
        observePassengerAndDriver()
        
        if Auth.auth().currentUser == nil {
            view1.lblDriveOrPassnger.text = ""
            view1.userImageView.isHidden = true
            view1.btnSignIn.setTitle("Sign Up / Login", for: .normal)
        } else{
            view1.lblEmailAddress.text = Auth.auth().currentUser?.email
            view1.lblDriveOrPassnger.text = ""
            view1.userImageView.isHidden = false
            view1.btnSignIn.setTitle("Logout", for: .normal)
        }
    }
    func setupView() {
        arrMenuItems.add("Payment")
        arrMenuItems.add("Your Trips")
        arrMenuItems.add("Help")
        arrMenuItems.add("Settings")
        tblView.reloadData()
    }
    
    
    func observePassengerAndDriver() {
        DataService.instance.REF_USERS.observeSingleEvent(of: .value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.view1.lblDriveOrPassnger.text = "PASSENGER"
                    }
                }
            }
        }
        
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.view1.lblDriveOrPassnger.text = "DRIVER"
                        self.view1.switchPickupMode.isHidden = false
                       
                        
                        
                       let switchStatus = snap.childSnapshot(forPath: "isPickupModeEnabled").value as! Bool
                        self.view1.switchPickupMode.isOn = switchStatus
                        self.view1.lblPickupMode.isHidden = false
                    }
                }
            }
        }
        
        
        
    }

}

extension LeftSidePanelVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftSidePanelCell") as! LeftSidePanelCell
        cell.lblTitle.text = arrMenuItems[indexPath.row] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        
    }
}
