//
//  OPDBillingPaymentVCViewController.swift
//  HealthCard
//
//  Created by Dhairya on 30/04/22.
//

import UIKit

class OPDBillingPaymentVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "OpdConsultationCell", bundle: nil), forCellReuseIdentifier: "OpdConsultationCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
    }

}

extension OPDBillingPaymentVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OpdConsultationCell", for: indexPath)as! OpdConsultationCell
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}
