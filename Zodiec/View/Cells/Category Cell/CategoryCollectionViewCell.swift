//
//  CategoryCollectionViewCell.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 31/07/2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlets
    @IBOutlet var categoryImageView : UIImageView!
    @IBOutlet var categoryNameLabelView : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImageView.layer.cornerRadius = 12.0
    }
    
    //MARK: - Functions
    func configure(_ data : Any?) {
        
    }
    
    //MARK: - Cell Config
    static func nib() -> UINib{
        return UINib(nibName: CellIdentifierStrings.categoryCellIdentfier, bundle: nil)
    }
    

}
