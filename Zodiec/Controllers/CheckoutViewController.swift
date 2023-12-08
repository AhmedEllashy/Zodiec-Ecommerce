//
//  CheckoutViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 10/09/2023.
//

import UIKit
protocol CheckoutViewController_Delegate:AnyObject {
    func handleDismiss()
}
 
class CheckoutViewController: UIViewController {
    weak var delegate: CheckoutViewController_Delegate?
    //MARK: - IBOutlets
    @IBOutlet var ProductsCollectionView : UICollectionView!
    @IBOutlet var SubtotalLabel : UILabel!
    @IBOutlet var discountLabel : UILabel!
    @IBOutlet var totalLabel : UILabel!
    
    //MARK: - IBActions
    @IBAction func popUpButtonPressed(_ sender : UIButton){
        self.dismiss(animated: true) { [weak self ] in
            guard let self = self else { return }
            self.delegate?.handleDismiss()
            
        }
        
    }
    @IBAction func placeOrderPressed(_ sender : UIButton){
        AppConstants.apiManager.addOrder(completion: { data, error in
            if let error = error {
                handleErrorAlert(error, controller: self)
            }else{
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SuccessOrderViewController") as? SuccessOrderViewController{
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
                
                
            }
        }, products: cartProducts , total: subtotal + discount)
    }
    //MARK: - Properties
    var cartProducts : [CartModel] = []
    var vc : CartViewController?
    var subtotal : Double = 0
    var discount : Double = 0
    //MARK: - Built In Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductsCollectionView.register(CartProductCollectionViewCell.nib(), forCellWithReuseIdentifier: CellIdentifierStrings.cartProductCellIdentifier)
        ProductsCollectionView.dataSource = self
        ProductsCollectionView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.ProductsCollectionView.reloadData()
        

    }

}
//MARK: - Collection View DataSource Methods
extension CheckoutViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ProductsCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifierStrings.cartProductCellIdentifier, for: indexPath) as! CartProductCollectionViewCell
        subtotal += (Double((cartProducts[indexPath.row].product?.price)!)!) * Double((cartProducts[indexPath.row].quantity)!)
        self.SubtotalLabel.text = "\(self.subtotal)"
        self.totalLabel.text = "\(self.subtotal - self.discount)"
        self.discountLabel.text = "\(self.discount)"
        cell.configure(cartProducts[indexPath.row], controller: self)
        
        return cell
    }
    
    
}
//MARK: - Collection View Layout
extension CheckoutViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = 10.0 * 3.0
        let collectionSize = ProductsCollectionView.frame.size
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