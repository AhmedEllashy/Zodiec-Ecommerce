//
//  ProductDetailsViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 15/08/2023.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var ProductImageView : UIImageView!
    @IBOutlet var ProductNameLabel : UILabel!
    @IBOutlet var ProductPriceLabel : UILabel!
    @IBOutlet var PlusButton : UIButton!
    @IBOutlet var CounterLabel : UILabel!
    @IBOutlet var MinusButton : UIButton!
    
    //MARK: - Properties
    private var counter  : Int = 1
    var product : ProductModel?
    //MARK: - Functions
    
    //MARK: - Built In Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        PlusButton.addShadow()
        MinusButton.addShadow()
        CounterLabel.text = "\(counter)"
        ProductNameLabel.text = product?.name
        ProductPriceLabel.text = "$" + (product?.price)!

    }
    //MARK: - IBActions

    @IBAction func BackButtonPressed(_ sender : UIButton) {
        let transition: CATransition = CATransition()
        transition.duration = 0.9
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
        
    }
    @IBAction func PlusButtonPressed(_ sender : UIButton) {
        counter += 1
        CounterLabel.text = "\(counter)"
    }
    @IBAction func MinusButtonPressed(_ sender : UIButton) {
        if counter > 1{
            counter -= 1
            CounterLabel.text = "\(counter)"
        }
    }
    @IBAction func AddToCartButtonPressed(_ sender : UIButton) {
        loadingAlert(controller: self)
        AppConstants.apiManager.addToCart(completion: {  data, error in
            if error != nil {
                self.presentedViewController?.dismiss(animated: true, completion: {
                    handleErrorAlert(error!, controller: self)
                })
            }else{
                self.presentedViewController?.dismiss(animated: true, completion: {
                    successAlert(message:AppStrings.productAddedToCartSuccesfully,controller: self)
                    
                })
                
            }
            
        }, quantity: counter, product: product!)
    }

}
