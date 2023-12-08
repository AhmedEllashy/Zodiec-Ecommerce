//
//  AddressTableViewCell.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 24/08/2023.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet var AddressTitleLabel : UILabel!
    @IBOutlet var AddressDetailsLabel : UILabel!
    
    //MARK: - Properties
    var controller : AddressesViewController?
    var tableViewWidth : CGFloat = 0.0
    var addresse : AddressModel?
    var index : Int?

    //MARK: - Functions
    func configure(_data : AddressModel , _controller : AddressesViewController, _tableViewWidth : CGFloat, _index : Int){
        self.controller = _controller
        self.tableViewWidth = _tableViewWidth
        self.index = _index
        self.addresse = _data
        self.AddressTitleLabel.text = _data.title
        self.AddressDetailsLabel.text = "\(_data.street) \(_data.district) \(_data.governrate)"
    }
    
    
    //MARK: - Built In Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addShadow()
        
    }
    override func layoutSubviews() {
          super.layoutSubviews()
        self.bounds.size.width = tableViewWidth

//          let margins = UIEdgeInsets(top: 55, left: 8, bottom: 5, right: 8)
//        contentView.frame = contentView.frame.inset(by: margins)
//          contentView.layer.cornerRadius = 8
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    //MARK: - @IBActions Fucntions
    
    @IBAction func editAdressButtonPressed(_ sender : UIButton) {
        controller?.index = index
        controller?.performSegue(withIdentifier: AppSegues.addressesGoToEditAddresseSegue, sender: self)
        
        
    }
    
    //MARK: - Cell Config
    static func nib() -> UINib{
        return UINib(nibName: CellIdentifierStrings.addresseCellIdentifier, bundle: nil)
    }
}
