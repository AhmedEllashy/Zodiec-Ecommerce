//
//  AddressesViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 24/08/2023.
//

import UIKit

class AddressesViewController: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet var AddresseTableView : UITableView!
    //MARK: - Properties
    private var userAddresses : [AddressModel] = []
    var index : Int?
    //MARK: - Built In Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        AddresseTableView.delegate = self
        AddresseTableView.dataSource = self
        AddresseTableView.register(AddressTableViewCell.nib(), forCellReuseIdentifier: CellIdentifierStrings.addresseCellIdentifier)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserAddresses()
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editAddresseVC = segue.destination as? EditAddressViewController{
            print(index ?? 7)
            editAddresseVC.address = userAddresses[index ?? 0]
        }
    }
    
  
    //MARK: - Functions
    func getUserAddresses(){
//        loadingAlert(controller: self)
        AppConstants.apiManager.getUserAddress { data, error in
            if error != nil {
                self.presentedViewController?.dismiss(animated: true, completion: nil)
            }else{
                self.userAddresses = data!
                self.AddresseTableView.reloadData()
                self.presentedViewController?.dismiss(animated: true, completion: nil)

            }
        }

    }
    //MARK: - @IBActions
    @IBAction func returnPopButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
}



//MARK: - Table View Delegate Methods
extension AddressesViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return userAddresses.count
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 10
     }
    
}
//MARK: - Table View DataSource Methods

extension AddressesViewController  : UITableViewDataSource{


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddresseTableView.dequeueReusableCell(withIdentifier: CellIdentifierStrings.addresseCellIdentifier, for: indexPath) as! AddressTableViewCell
        if userAddresses.count > 0 {
            cell.configure(_data: userAddresses[indexPath.section], _controller: self, _tableViewWidth: AddresseTableView.frame.size.width - 50, _index: indexPath.section)
          
        }
  
        return cell
    }

    
    
}
