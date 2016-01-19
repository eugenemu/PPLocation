//
//  AddLocationViewController.swift
//  PushPullLocation
//
//  Created by Eugene Mu on 1/18/16.
//  Copyright © 2016 Eugene Mu. All rights reserved.
//

import UIKit
import MapKit



class AddLocationViewController: UIViewController {
    
    weak var cancelButtonDelegate: CancelButtonDelegate?
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
}

