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
    @IBOutlet var CategoryCollectionView : UICollectionView!

    //MARK: - Property
    override func viewDidLoad() {
        super.viewDidLoad()
        QRCodeView.circluteView()
        SearchView.circluteView()
        redShoesImageView.layer.cornerRadius = 15.0
        redShoesInFrontOfView.layer.cornerRadius = 15.0
        CategoryCollectionView.dataSource = self
        CategoryCollectionView.register(CategoryCollectionViewCell.nib(), forCellWithReuseIdentifier: CellIdentifierStrings.categoryCellIdentfier)
    }
    



}

//MARK: - Category Collection View Methods
extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifierStrings.categoryCellIdentfier, for: indexPath) as! CategoryCollectionViewCell
        return cell
    
    }
    
    
}

