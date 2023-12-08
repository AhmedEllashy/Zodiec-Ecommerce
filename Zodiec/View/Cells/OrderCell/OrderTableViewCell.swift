//
//  OrderTableViewCell.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 07/11/2023.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet var OrderIdLabel : UILabel!
    @IBOutlet var OrderStatusLabel : UILabel!
    @IBOutlet var OrderDateLabel : UILabel!

    //MARK: - Built In Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    //MARK: - Functions
    func config(_ order : OrderModel){
        OrderIdLabel.text = "Order001"
        OrderStatusLabel.text = order.status
        OrderDateLabel.text = "\(order.total ?? 0.0)"
    }
    //MARK: - Cell Config
    static func nib() -> UINib{
        return UINib(nibName: CellIdentifierStrings.orderCellIdentifier, bundle: nil)
    }
    
}
