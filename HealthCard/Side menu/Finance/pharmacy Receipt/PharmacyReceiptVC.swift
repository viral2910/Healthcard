//
//  PharmacyReceiptVC.swift
//  HealthCard
//
//  Created by Dhairya on 30/04/22.
//

import UIKit

class PharmacyReceiptVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "prescriptionDetailsCell", bundle: nil), forCellReuseIdentifier: "prescriptionDetailsCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
    }
    
}

extension PharmacyReceiptVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prescriptionDetailsCell", for: indexPath)as! prescriptionDetailsCell
        return cell
    }
}
