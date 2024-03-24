//
//  ProfileViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 15/08/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var PreferencesView: UIView!
    @IBOutlet weak var AddressesView: UIView!
    @IBOutlet weak var OrdersView: UIView!
    @IBOutlet weak var LogoutView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        PreferencesView.addShadow()
        AddressesView.addShadow()
        OrdersView.addShadow()
        LogoutView.addShadow()
    }
    



}
