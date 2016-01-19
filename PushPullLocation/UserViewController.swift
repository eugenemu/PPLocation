//
//  UserViewController.swift
//  PushPullLocation
//
//  Created by Eugene Mu on 1/18/16.
//  Copyright © 2016 Eugene Mu. All rights reserved.
//

import UIKit

protocol CancelButtonDelegate: class {
    func cancelButtonPressedFrom(controller: UIViewController)
}

class UserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    @IBAction func enterButton(sender: UIButton) {
        Connection.sharedInstance.sendToServer(nameTextField.text!)
        if nameTextField.text != "" {
            performSegueWithIdentifier("MapSegue", sender: sender)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let controller = navigationController.topViewController as! MapViewController
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Connection.sharedInstance.connectToServer()
    }
    
    
}
