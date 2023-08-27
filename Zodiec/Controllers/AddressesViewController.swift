//
//  AddressesViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 24/08/2023.
//

import UIKit

class AddressesViewController: UIViewController {
    @IBOutlet var AddresseTableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        AddresseTableView.delegate = self
        AddresseTableView.dataSource = self
        AddresseTableView.register(AddressTableViewCell.nib(), forCellReuseIdentifier: CellIdentifierStrings.addresseCellIdentifier)

    }

    
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
        return 3
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 10
     }
    
}
//MARK: - Table View DataSource Methods

extension AddressesViewController  : UITableViewDataSource{


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddresseTableView.dequeueReusableCell(withIdentifier: CellIdentifierStrings.addresseCellIdentifier, for: indexPath) as! AddressTableViewCell
        return cell
    }

    
    
}
