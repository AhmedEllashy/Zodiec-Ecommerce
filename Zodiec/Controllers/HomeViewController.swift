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
    @IBOutlet var NewArrivalProductsCollectionView : UICollectionView!

    //MARK: - Property
    var categories : [CategoryModel] = []
    var products : [ProductModel] = []
    
    //MARK: - Built-In-Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        QRCodeView.circluteView()
        SearchView.circluteView()
        redShoesImageView.layer.cornerRadius = 15.0
        redShoesInFrontOfView.layer.cornerRadius = 15.0
        CategoryCollectionView.dataSource = self
        NewArrivalProductsCollectionView.dataSource = self
        NewArrivalProductsCollectionView.delegate = self
        CategoryCollectionView.register(CategoryCollectionViewCell.nib(), forCellWithReuseIdentifier: CellIdentifierStrings.categoryCellIdentfier)
        NewArrivalProductsCollectionView.register(ProductCollectionViewCell.nib(), forCellWithReuseIdentifier: CellIdentifierStrings.productCellIdentfier)
        //Call Data Functions
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllCategories()
        getAllProducts()

    }
    //MARK: - Functions
    func getAllCategories(){
        AppConstants.apiManager.getCategories { data, error in
            if let safeData = data {
                self.categories = safeData
                self.CategoryCollectionView.reloadData()

            }else{
                handleErrorAlert(error!, controller: self)
            }
          
        }
    }
    func getAllProducts(){
        AppConstants.apiManager.getProducts { data, error in
            if let safeData = data {
                self.products = safeData
                self.NewArrivalProductsCollectionView.reloadData()

            }else{
                handleErrorAlert(error!, controller: self)
            }
          
        }
    }

}

    

//MARK: - Collection View DataSource Methods
extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == CategoryCollectionView {
            return categories.count
        }else if collectionView == NewArrivalProductsCollectionView {
            return products.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == CategoryCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifierStrings.categoryCellIdentfier, for: indexPath) as! CategoryCollectionViewCell
            cell.configure(categories[indexPath.row])
        return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifierStrings.productCellIdentfier, for: indexPath) as! ProductCollectionViewCell
            cell.configure(products[indexPath.row],controller: self)
            return cell
        }
    
    }
    
    
}

//MARK: - Collection View Layout Methods
extension HomeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let paddingSpace = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10).left * 3
            let avaliableWidth = NewArrivalProductsCollectionView.frame.width - paddingSpace
            let widthPerItem = avaliableWidth / 2
            return CGSize(width: widthPerItem , height: widthPerItem + 50)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.6
    }
        
}
