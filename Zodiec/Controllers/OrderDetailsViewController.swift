//
//  OrderDetailsViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 07/12/2023.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet var ProductsCollectionView : UICollectionView!
    @IBOutlet var OrderStatusTrackView : UIView!
    @IBOutlet weak var TrackOrderUIButton: UIButton!
    @IBOutlet var SubtotalLabel : UILabel!
    @IBOutlet var discountLabel : UILabel!
    @IBOutlet var totalLabel : UILabel!
    //MARK: - Properties
    var products : [CartModel] = []
    var total : Double = 0
    var subTotal : Double = 0
    var discount : Double = 0
    //MARK: - @IBOutlets
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    
    }
    //MARK: - @IBActions
    @IBAction func returnBackButtonPressed(_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func trackOrderButtonPressed(_ sender : UIButton){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderTrackingViewController") as! OrderTrackingViewController
        self.present(vc, animated: true, completion: nil)
            
    }
    


}

//MARK: - Functions
extension OrderDetailsViewController {
    func setUp(){
        ProductsCollectionView.delegate = self
        ProductsCollectionView.dataSource = self
        ProductsCollectionView.register(OrderProductCollectionViewCell.nib(), forCellWithReuseIdentifier: CellIdentifierStrings.orderProductCellIdentifier)
        OrderStatusTrackView.RectangleBorderRadius()
        TrackOrderUIButton.RectangleBorderRadius()
        OrderStatusTrackView.addShadow()
        SubtotalLabel.text = "\(subTotal)"
        discountLabel.text = "\(discount)"
        totalLabel.text = "\(total)"
    }
    
    
}
//MARK: - Collection View DataSource Methods
extension OrderDetailsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.ProductsCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifierStrings.orderProductCellIdentifier, for: indexPath) as! OrderProductCollectionViewCell
            cell.configure(products[indexPath.row])
            cell.addShadow()
        return cell
    }

}
//MARK: - Collection View Layout
extension OrderDetailsViewController : UICollectionViewDelegateFlowLayout {
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
