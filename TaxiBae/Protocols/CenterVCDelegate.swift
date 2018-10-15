//
//  CenterVCDelegate.swift
//  TaxiBae
//
//  Created by naman vaishnav on 15/10/18.
//  Copyright © 2018 naman vaishnav. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
