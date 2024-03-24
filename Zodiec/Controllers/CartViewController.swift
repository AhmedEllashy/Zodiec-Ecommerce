//
//  CartViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 03/08/2023.
//

import UIKit

class CartViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var ChangeLocationButton : UIButton!
    @IBOutlet var CurrentLocationLabel : UILabel!
    @IBOutlet var SubtotalLabel : UILabel!
    @IBOutlet var discountLabel : UILabel!
    @IBOutlet var totalLabel : UILabel!
    @IBOutlet var CouponView : UIView!
    @IBOutlet var CouponTextField : UITextField!
    @IBOutlet var ApplyCouponButton : UIButton!
    @IBOutlet var CartProductCollectionView : UICollectionView!
    
    //MARK: - Property
    var cartProducts : [CartModel] = []
    var subtotal : Double = 0.0
    var discount : Double = 0.0
    
    //MARK: - Built-In Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = "0.0"
        discountLabel.text = "0.0"
        SubtotalLabel.text = "0.0"
        CouponView.addShadow()
        CouponView.layer.cornerRadius = 15.0
        ApplyCouponButton.RectangleBorderRadius()
        CartProductCollectionView.delegate = self
        CartProductCollectionView.dataSource = self
        CartProductCollectionView.register(CartProductCollectionViewCell.nib(), forCellWithReuseIdentifier: CellIdentifierStrings.cartProductCellIdentifier)
        CouponView.addShadow()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCartProducts()
        subtotal = 0.0
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vc = segue.destination as? CheckoutViewController {
//            vc.cartProducts = self.cartProducts
//
//        }
//    }
    //MARK: - IBActions
    @IBAction func checkPaymentButtonPressed(_ sender : UIButton){
        
    }
    @IBAction func applyCouponButtonPressed(_ sender : UIButton){
      let couponCode = CouponTextField.text
        if couponCode == nil || couponCode == "" {
            handleErrorAlert(ErrorStrings.noCodeToApplyError, controller: self)
        }else{
            AppConstants.apiManager.getCoupon(completion: { [self] data, error in
                if error != nil {
                    handleErrorAlert(error!, controller: self)
                }else{
                    self.discount = (data?.discount)!
                    self.discountLabel.text = "\(self.discount)"
                    self.totalLabel.text = "\(self.subtotal - self.discount)"
                    successAlert(message:AppStrings.theCouponHasImplementedSuccesfully,controller: self)
                }
            }, couponCode: couponCode!)
        }
        
    }
    @IBAction func checkoutButtonPressed(_ sender: UIButton) {
        
        if  let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CheckoutViewController") as? CheckoutViewController {
            vc.cartProducts = self.cartProducts
            vc.discount = self.discount
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
      
    }
    
    //MARK: - Functions
    func getCartProducts(){
        loadingAlert(controller: self)
        AppConstants.apiManager.getCartProducts { data, error in
            dismissAlert()
            if error != nil {
                handleErrorAlert(error!, controller: self)
            
            }else{
                self.cartProducts = data!
                self.CartProductCollectionView.reloadData()
            }
        }

    }

  

}
//MARK: - Collection View DataSource
extension CartViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CartProductCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifierStrings.cartProductCellIdentifier, for: indexPath) as! CartProductCollectionViewCell
        subtotal += (Double((cartProducts[indexPath.row].product?.price)!)!) * Double((cartProducts[indexPath.row].quantity)!)
        self.SubtotalLabel.text = "\(self.subtotal)"
        self.totalLabel.text = "\(self.subtotal - self.discount)"
            cell.configure(cartProducts[indexPath.row],controller: self)
        return cell
    }
    
    
}


//MARK: - Collection View Layout
extension CartViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = 10.0 * 3.0
        let collectionSize = CartProductCollectionView.frame.size
        let avalibleHeight = collectionSize.height - paddingSpace
        let heightPerItem = avalibleHeight / 2
        return CGSize(width: collectionSize.width - 10 , height: heightPerItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30.0
    }
    
}


extension CartViewController: CheckoutViewController_Delegate{
    func handleDismiss() {
        self.getCartProducts()
    }
}
