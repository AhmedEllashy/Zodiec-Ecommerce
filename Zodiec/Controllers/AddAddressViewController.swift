//
//  AddAddressViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 24/08/2023.
//

import UIKit

class AddAddressViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var StreetTextField: UITextField!
    @IBOutlet weak var DistrictTextField: UITextField!
    @IBOutlet weak var GovernrateTextField: UITextField!
    @IBOutlet weak var MoreDetailsTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.addShadow()
        StreetTextField.addShadow()
        DistrictTextField.addShadow()
        GovernrateTextField.addShadow()
        MoreDetailsTextField.addShadow()
    }
    



}
