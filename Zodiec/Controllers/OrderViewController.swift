//
//  OrderViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 06/12/2023.
//

import UIKit

class OrderViewController: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var orderTableView : UITableView!
    //MARK: - Properties
    var orders : [OrderModel] = []
    //MARK: - Built In Methdos
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    
    }
    //MARK: - @IBActions
    @IBAction func popUpPressed(_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }



}
//MARK: - Functions
extension OrderViewController {
    func setUp(){
        orderTableView.register(OrderTableViewCell.nib(), forCellReuseIdentifier: CellIdentifierStrings.orderCellIdentifier)
        orderTableView.delegate = self
        orderTableView.dataSource = self
        getAllOrders()
    }
    func getAllOrders(){
        loadingAlert(controller: self)
        AppConstants.apiManager.getOrders { allOrders, error in
            self.presentedViewController?.dismiss(animated: true, completion: nil)
            if let error = error {
                handleErrorAlert(error, controller: self)
            }else{
             self.orders = allOrders ?? []
                dump(allOrders)

            self.orderTableView.reloadData()
            }
        }
    }
}
//MARK: - Table View Delegate Methods
extension OrderViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
  
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 10
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
//MARK: - Table View DataSource Methods

extension OrderViewController  : UITableViewDataSource{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderTableView.dequeueReusableCell(withIdentifier: CellIdentifierStrings.orderCellIdentifier, for: indexPath) as! OrderTableViewCell
        cell.config(orders[indexPath.row])
        cell.addShadow()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main",bundle: nil).instantiateViewController(withIdentifier: "OrderDetailsViewController") as? OrderDetailsViewController {
            let order : OrderModel = orders[indexPath.row]
            vc.products = order.products ?? []
            vc.total = order.total ?? 0.0
            vc.subTotal = order.subtotal ?? 0.0
            vc.discount = order.discount ?? 0.0
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
