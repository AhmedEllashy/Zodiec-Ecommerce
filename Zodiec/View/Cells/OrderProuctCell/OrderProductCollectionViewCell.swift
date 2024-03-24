//
//  OrderProductCollectionViewCell.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 10/12/2023.
//

import UIKit

class OrderProductCollectionViewCell: UICollectionViewCell {
    //MARK: - @IBOutlets
    @IBOutlet var ProductImageView : UIImageView!
    @IBOutlet var ProductPriceLabel : UILabel!
    @IBOutlet var ProductQuantityLabel : UILabel!
    //MARK: - Built In Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //MARK: - Functions
    func configure(_ data : CartModel){
        ProductPriceLabel.text = "$\(data.product?.price ?? "")"
        ProductQuantityLabel.text = "\(data.quantity ?? 0) Items "
    }
    static func nib() -> UINib{
        return UINib(nibName: CellIdentifierStrings.orderProductCellIdentifier, bundle: nil)
    }
    

}
