//
//  AdvanceBillingPaymentVC.swift
//  HealthCard
//
//  Created by Dhairya on 30/04/22.
//

import UIKit

class AdvanceBillingPaymentVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "AdvanceBillingPaymentCell", bundle: nil), forCellReuseIdentifier: "AdvanceBillingPaymentCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
    }
   
}
extension AdvanceBillingPaymentVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdvanceBillingPaymentCell", for: indexPath)as! AdvanceBillingPaymentCell
        return cell
    }
}
