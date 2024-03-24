//
//  SearchViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 31/12/2023.
//

import UIKit

class SearchViewController: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var SearchTextFieldView: UIView!
    @IBOutlet weak var SearchTextField: UITextField!
    @IBOutlet weak var SearchedProductsCollectionView: UICollectionView!
    //MARK: - @Properties
    let uIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    var productsList : [ProductModel] = []
    var filteredArray : [ProductModel] = []
    //MARK: - @Built In Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        modifyUiViewsApperence()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAllProducts()
    }
    //MARK: - @IBActions
    @IBAction func returnButtonPressed(_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }



}
//MARK: - @Functions
extension SearchViewController{
    func setup(){
        SearchedProductsCollectionView.dataSource = self
        SearchedProductsCollectionView.delegate = self
        SearchedProductsCollectionView.register(ProductCollectionViewCell.nib(), forCellWithReuseIdentifier: CellIdentifierStrings.productCellIdentfier)
        SearchTextField.addTarget(self, action: #selector(searchTextFieldChanged), for: .editingChanged)
  
    }
    func modifyUiViewsApperence(){
        SearchTextFieldView.addShadow()
    }
    func getAllProducts(){
        AppConstants.apiManager.getProducts { [self] data, error in
            if let error = error {
                handleErrorAlert(error, controller: self)
            }
            guard let data = data else {
                return
            }
            self.productsList = data


        }
    }
    func searchInReceivedProducts(_ name : String){
        if productsList.count >= 1 {
            self.filteredArray = productsList.filter { product in product.name?.contains(name) as! Bool }
            print(filteredArray)
        }
    }
    @objc func searchTextFieldChanged(_ textField : UITextField){
        if let text = textField.text{
        searchInReceivedProducts(text)
            self.SearchedProductsCollectionView.reloadData()
        }
    }
}
//MARK: - @Collection View DataSource Methods
extension SearchViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifierStrings.productCellIdentfier, for: indexPath) as! ProductCollectionViewCell
        print(filteredArray)
        cell.configure(filteredArray[indexPath.row], controller: self, _index: indexPath.row)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name :"Main",bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        vc.product = filteredArray[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
//MARK: - @Collection View Layout Methods
extension SearchViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = collectionView.frame.size
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
