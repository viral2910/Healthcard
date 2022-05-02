//
//  AddressDetailsVC.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

class AddressDetailsVC: UIViewController {
    
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableCell()
        cartBtn.setTitle("", for: .normal)
    }
    /// TableViewCell Setup
    private func setupTableCell(){
        tableView.register(UINib(nibName: "AddNewAddressCell", bundle: nil), forCellReuseIdentifier: "AddNewAddressCell")
        tableView.register(UINib(nibName: "AddressDetailsCell", bundle: nil), forCellReuseIdentifier: "AddressDetailsCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
    }
    
    @IBAction func cartBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
}


extension AddressDetailsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 90
        }else{
            return 500
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewAddressCell", for: indexPath)as! AddNewAddressCell
            
            return cell
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressDetailsCell", for: indexPath)as! AddressDetailsCell
        return cell
        }
        return UITableViewCell()
    }
    
}
