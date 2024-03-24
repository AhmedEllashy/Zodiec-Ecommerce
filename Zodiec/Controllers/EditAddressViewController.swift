//
//  EditAddressViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 24/08/2023.
//

import UIKit

class EditAddressViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var StreetTextField: UITextField!
    @IBOutlet weak var DistrictTextField: UITextField!
    @IBOutlet weak var GovernrateTextField: UITextField!
    @IBOutlet weak var MoreDetailsTextField: UITextField!
    var address : AddressModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.addShadow()
        StreetTextField.addShadow()
        DistrictTextField.addShadow()
        GovernrateTextField.addShadow()
        MoreDetailsTextField.addShadow()
        titleTextField.text = address?.title
        StreetTextField.text = address?.street
        DistrictTextField.text = address?.district
        GovernrateTextField.text = address?.governrate
        MoreDetailsTextField.text = address?.moreDetails
    }
    //MARK: - @IBActions
    @IBAction func returnPopButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }

    @IBAction func updateAddressButtonPressed(_ sender : UIButton){
        loadingAlert(controller: self)
        guard let title = titleTextField.text else {return}
        guard let street = StreetTextField.text else{return}
        guard let district = DistrictTextField.text else{return}
        guard let governrate = GovernrateTextField.text else{return}
        guard let moreDetails = MoreDetailsTextField.text else{return}
        if !title.isEmpty && !street.isEmpty && !district.isEmpty && !governrate.isEmpty &&  !moreDetails.isEmpty{
        AppConstants.apiManager.addUserAddress(completion: { data, error in
            self.presentedViewController?.dismiss(animated: true, completion: {
                successAlert(message: AppStrings.success, controller: self)
            })
        }, address: AddressModel(id: address?.id, title: title, street: street, district: district, governrate: governrate, moreDetails: moreDetails))
        }else{
            self.presentedViewController?.dismiss(animated: true, completion: {
                handleErrorAlert(ErrorStrings.fillAllFieldsError, controller: self)

            })
        }
    }

}
