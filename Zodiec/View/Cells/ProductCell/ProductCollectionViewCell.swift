//
//  ProductCollectionViewCell.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 01/08/2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlets
    @IBOutlet var ProductImageView : UIImageView!
    @IBOutlet var ProductNameLabel : UILabel!
    @IBOutlet var ProductPriceLabel : UILabel!
    var product : ProductModel?
    var viewController : UIViewController?
    //MARK: - Property
    let apiManager : ApiManager = ApiManager()
    //MARK: - Built In Methpds
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ProductImageView.layer.cornerRadius = 15.0
        self.addShadow()
   
        
    }
    
    //MARK: - IBActions
    @IBAction func addToCartButtonPressed(_ sender : UIButton){
        guard let viewController = self.viewController else{
            return
        }
        loadingAlert(controller: viewController)
        AppConstants.apiManager.addToCart(completion: {  data, error in
            if error != nil {
                viewController.presentedViewController?.dismiss(animated: true, completion: {
                    handleErrorAlert(error!, controller: self.viewController!)
                })
            }else{
                viewController.presentedViewController?.dismiss(animated: true, completion: {
                    successAlert(message:AppStrings.productAddedToCartSuccesfully,controller: viewController)
                    
                })
                
            }
            
        }, quantity: 1, product: product!)
    }
    @IBAction func AddToWishListButtonPressed(_ sender : UIButton) {
//        if sender.imageView?.image == UIImage(systemName: "heart.circle") {
//            sender.imageView?.image = UIImage(systemName: "heart.circle.fill")
//        }else{
//            sender.imageView?.image = UIImage(systemName: "heart.circle")
//        }
        loadingAlert(controller: viewController!)
        AppConstants.apiManager.addToWishlist(completion: { data, error in
            if error != nil {
                self.viewController?.presentedViewController?.dismiss(animated: true, completion: {
                    handleErrorAlert(error!, controller: self.viewController!)
                })
            }else{
                self.viewController?.presentedViewController?.dismiss(animated: true, completion: {
                    successAlert(message: AppStrings.productAddedToWishlistSuccessfully, controller: self.viewController!)
                })
            }
        }, product: product!)
    }
    
//    @IBAction func goToProductDetails(){
//        if let vc = viewController as? HomeViewController {
//            vc.productIndex = index
//        }
//    viewController?.performSegue(withIdentifier: AppSegues.homeGoToProductDetailsSegue, sender: viewController.self)
//        print("tabbed!")
//
//
//      }
    
    //MARK: - Functions
    func configure(_ data : ProductModel , controller : UIViewController ,_index : Int){
        ProductNameLabel.text = data.name
        ProductPriceLabel.text = "$\(Double(data.price!) ?? 0.0)"
        product = data
//        self.index = _index
        self.viewController = controller
    }

    //MARK: - Cell Config
    static func nib() -> UINib{
        return UINib(nibName: CellIdentifierStrings.productCellIdentfier, bundle: nil)
    }



}
