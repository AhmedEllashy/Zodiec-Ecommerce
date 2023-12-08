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
            self.orderTableView.reloadData()
            }
        }
    }
}
//MARK: - Table View Delegate Methods
extension OrderViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
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
        return cell
    }
}
