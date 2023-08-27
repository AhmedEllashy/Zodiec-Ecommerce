//
//  FavouriteViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 15/08/2023.
//

import UIKit

class FavouriteViewController: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet var wishlistCountLabel : UILabel!
    @IBOutlet var WishListCollectionView : UICollectionView!
    
    //MARK: - Properties
    var wishlist : [ProductModel] = []
    let uIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    var isList : Bool = false

    //MARK: - Built-In-Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        WishListCollectionView.delegate = self
        WishListCollectionView.dataSource = self
        WishListCollectionView.register(ProductCollectionViewCell.nib(), forCellWithReuseIdentifier: CellIdentifierStrings.productCellIdentfier)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWishlsitProducts()
    }
    //MARK: - Functions
    func getWishlsitProducts(){
        loadingAlert(controller: self)
        AppConstants.apiManager.getUserWishLishProducts { data, error in
            if error != nil{
                self.presentedViewController?.dismiss(animated: true, completion: {
                    handleErrorAlert(error!, controller: self)
                })
            }else{
                self.wishlist = data!
                self.wishlistCountLabel.text = "\(self.wishlist.count)"
                self.WishListCollectionView.reloadData()
                self.presentedViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    

}

//MARK: - Collection View DataSource Methods
extension FavouriteViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifierStrings.productCellIdentfier, for: indexPath) as! ProductCollectionViewCell
        cell.configure(wishlist[indexPath.row], controller: self)
        return cell
        
    }
    
    
}
//MARK: - Collection View Layout Methods
extension FavouriteViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = WishListCollectionView.frame.size
            let paddingSpace = uIEdgeInsets.left * 3
            let avaliableWidth = size.width  - paddingSpace
            let widthPerItem = avaliableWidth / 2
            return CGSize(width: widthPerItem, height: widthPerItem + 150)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return uIEdgeInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30.0
    }
}
