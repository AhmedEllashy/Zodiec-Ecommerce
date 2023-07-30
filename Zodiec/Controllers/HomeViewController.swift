//
//  HomeViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 30/07/2023.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: - IBOulets
    @IBOutlet var QRCodeView : UIView!
    @IBOutlet var SearchView : UIView!
    @IBOutlet var redShoesImageView : UIImageView!
    @IBOutlet var redShoesInFrontOfView : UIView!

    //MARK: - Property
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QRCodeView.circluteView()
        SearchView.circluteView()
        redShoesImageView.layer.cornerRadius = 15.0
        redShoesInFrontOfView.layer.cornerRadius = 15.0
    }
    



}
