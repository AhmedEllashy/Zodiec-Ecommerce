//
//  PreferencesViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 07/11/2023.
//

import UIKit

class PreferencesViewController: UIViewController {
    
    @IBOutlet var ProfileImage : UIImageView!
    @IBOutlet var UserNameTextField : UITextField!
    @IBOutlet var EmailTextField : UITextField!
    @IBOutlet var MobileNumberTextField : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        UserNameTextField.addShadow()
        EmailTextField.addShadow()
        MobileNumberTextField.addShadow()
    }
    


}
