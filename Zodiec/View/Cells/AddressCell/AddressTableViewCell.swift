//
//  AddressTableViewCell.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 24/08/2023.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    @IBOutlet var AddressTitleLabel : UILabel!
    @IBOutlet var AddressDetailsLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addShadow()
        
    }
    override func layoutSubviews() {
          super.layoutSubviews()
        self.bounds.size.width = 340

//          let margins = UIEdgeInsets(top: 55, left: 8, bottom: 5, right: 8)
//        contentView.frame = contentView.frame.inset(by: margins)
//          contentView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func editAdressButtonPressed(_ sender : UIButton) {
        
    }
    //MARK: - Cell Config
    static func nib() -> UINib{
        return UINib(nibName: CellIdentifierStrings.addresseCellIdentifier, bundle: nil)
    }
}
