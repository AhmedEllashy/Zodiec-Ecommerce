//
//  CartProductCollectionViewCell.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 04/08/2023.
//

import UIKit

class CartProductCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlets
    @IBOutlet var ProductImageView : UIImageView!
    @IBOutlet var ProductNameLabel : UILabel!
    @IBOutlet var ProductPriceLabel : UILabel!
    @IBOutlet var PlusButton : UIButton!
    @IBOutlet var CounterLabel : UILabel!
    @IBOutlet var MinusButton : UIButton!
    
    
    //MARK: - Property
    var counter : Int = 1
    var cart : CartModel?
    var cartViewController : CartViewController?
    

    
    //MARK: - IBActions
    @IBAction func PlusButtonPressed(_ sender : UIButton){
        loadingAlert(controller: cartViewController!)
        counter = (cart?.quantity)! + 1
        CounterLabel.text = "\(counter)"
        AppConstants.apiManager.addToCart(completion: { data, error in
            if error != nil{
                self.cartViewController?.presentedViewController?.dismiss(animated: true, completion: {
                    handleErrorAlert(error!, controller: self.cartViewController!)
                })
            }else{
                self.cartViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
            }
        }, quantity: counter, product: (cart?.product!)!)
        self.cartViewController?.viewWillAppear(true)
    }
    @IBAction func MinusButtonPressed(_ sender : UIButton){
        counter = (cart?.quantity)!
        if counter > 1 {
        loadingAlert(controller: cartViewController!)
        counter = (cart?.quantity)! - 1
        CounterLabel.text = "\(counter)"
        AppConstants.apiManager.addToCart(completion: { data, error in
            if error != nil{
                self.cartViewController?.presentedViewController?.dismiss(animated: true, completion: {
                    handleErrorAlert(error!, controller: self.cartViewController!)
                })
            }else{
                self.cartViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
            }
        }, quantity: counter, product: (cart?.product!)!)
        self.cartViewController?.viewWillAppear(true)
      }
    }
    @IBAction func deleteFromCartButtonPressed(_ sender : UIButton){
        loadingAlert(controller: cartViewController!)
        AppConstants.apiManager.deleteProductFromCart(completion: { [self] data, error in
            if error != nil {
                self.cartViewController?.presentedViewController?.dismiss(animated: true, completion: {
                    handleErrorAlert(error!, controller: self.cartViewController!)
                })
            }else{
                self.cartViewController?.presentedViewController?.dismiss(animated: true, completion: {
                    successAlert(message: AppStrings.productDeletedSuccesfully, controller: self.cartViewController!)
                })
            }
        }, id: cart?.product?.id)
        cartViewController?.viewWillAppear(true)
    }
    //MARK: - Built-In-Medthods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15.0
        self.addShadow()
        ProductImageView.RectangleBorderRadius()
        PlusButton.circluteView()
        MinusButton.circluteView()

    }
    //MARK: - Functions
    func configure(_ data : CartModel , controller : CartViewController){
        cart = data
        cartViewController = controller
        ProductNameLabel.text = data.product?.name
        ProductPriceLabel.text = "$\(Double(data.product?.price! ?? "0.0") ?? 0.0)"
        CounterLabel.text = "\(data.quantity ?? 1)"
        
    }
    //MARK: - Cell Config
    static func nib() -> UINib {
        return UINib(nibName: CellIdentifierStrings.cartProductCellIdentifier, bundle: nil)
    }

}
