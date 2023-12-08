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
    var VC : UIViewController?
    

    
    //MARK: - IBActions
    @IBAction func PlusButtonPressed(_ sender : UIButton){
        loadingAlert(controller: VC!)
        counter = (cart?.quantity)! + 1
        CounterLabel.text = "\(counter)"
        AppConstants.apiManager.addToCart(completion: { data, error in
            if error != nil{
                self.VC?.presentedViewController?.dismiss(animated: true, completion: {
                    handleErrorAlert(error!, controller: self.VC!)
                })
            }else{
                self.VC?.presentedViewController?.dismiss(animated: true, completion: nil)
            }
        }, quantity: counter, product: (cart?.product!)!)
        self.VC?.viewWillAppear(true)
    }
    @IBAction func MinusButtonPressed(_ sender : UIButton){
      if let cart = cart {
         guard let product = cart.product else {return}
         guard let quantity = cart.quantity else {return}
         counter = quantity
         if counter > 1 {
         loadingAlert(controller: VC!)
         counter = (cart.quantity)! - 1
            print(cart.quantity!)
             print(counter)
         CounterLabel.text = "\(counter)"
         AppConstants.apiManager.addToCart(completion: { data, error in
            if error != nil{
                self.VC?.presentedViewController?.dismiss(animated: true, completion: {
                    handleErrorAlert(error!, controller: self.VC!)
                })
            }else{
                self.VC?.presentedViewController?.dismiss(animated: true, completion: nil)
            }
        }, quantity: counter, product: product)
        self.VC?.viewWillAppear(true)
      }
          print(counter)
    }
}
    @IBAction func deleteFromCartButtonPressed(_ sender : UIButton){
        loadingAlert(controller: VC!)
        AppConstants.apiManager.deleteProductFromCart(completion: { [self] data, error in
            if error != nil {
                self.VC?.presentedViewController?.dismiss(animated: true, completion: {
                    handleErrorAlert(error!, controller: self.VC!)
                })
            }else{
                self.VC?.presentedViewController?.dismiss(animated: true, completion: {
                    successAlert(message: AppStrings.productDeletedSuccesfully, controller: self.VC!)
                })
            }
        }, id: cart?.product?.id)
        
        VC?.viewWillAppear(true)
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
    func configure(_ data : CartModel , controller : UIViewController){
        cart = data
        VC = controller
        ProductNameLabel.text = data.product?.name
        ProductPriceLabel.text = "$\(Double(data.product?.price! ?? "0.0") ?? 0.0)"
        CounterLabel.text = "\(data.quantity ?? 1)"
        
    }
    //MARK: - Cell Config
    static func nib() -> UINib {
        return UINib(nibName: CellIdentifierStrings.cartProductCellIdentifier, bundle: nil)
    }

}
