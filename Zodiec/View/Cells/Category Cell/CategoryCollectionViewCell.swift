//
//  CategoryCollectionViewCell.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 31/07/2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlets
    @IBOutlet var CategoryImageView : UIImageView!
    @IBOutlet var CategoryNameLabelView : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        CategoryImageView.layer.cornerRadius = 0.5 * CategoryImageView.layer.bounds.size.width
    }
    
    //MARK: - Functions
    func configure(_ data : CategoryModel) {
        CategoryNameLabelView.text = data.name
        
    }
    
    //MARK: - Cell Config
    static func nib() -> UINib{
        return UINib(nibName: CellIdentifierStrings.categoryCellIdentfier, bundle: nil)
    }
    

}
