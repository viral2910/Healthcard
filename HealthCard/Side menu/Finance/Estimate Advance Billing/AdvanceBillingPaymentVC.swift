//
//  AdvanceBillingPaymentVC.swift
//  HealthCard
//
//  Created by Dhairya on 30/04/22.
//

import UIKit

class AdvanceBillingPaymentVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataValue = [advanceBilling]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "AdvanceBillingPaymentCell", bundle: nil), forCellReuseIdentifier: "AdvanceBillingPaymentCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        apiCall()
    }
   
}
extension AdvanceBillingPaymentVC{

    //MARK: - API CALL
    func apiCall()  {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.estimateAdvanceBillingList(patientID: patientID)) { [weak self](data: [advanceBilling]?, error) in
                self?.dataValue = data!
                self?.tableView.reloadData()
        }
    }
}
extension AdvanceBillingPaymentVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValue.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdvanceBillingPaymentCell", for: indexPath)as! AdvanceBillingPaymentCell
        cell.invoiceNoLbl.text = dataValue[indexPath.row].estimatePlanRefNo
        cell.surgeonName.text = dataValue[indexPath.row].surgeonName
        cell.procedureNameLbl.text = dataValue[indexPath.row].procedureName
        cell.creationDateLbl.text = dataValue[indexPath.row].estimateCreationDate
        cell.initialAmtLbl.text = "₹" + dataValue[indexPath.row].balance
        cell.discountAmtLbl.text = "₹" + dataValue[indexPath.row].discountAmt
        cell.AdvancePaideLbl.text = "₹" + dataValue[indexPath.row].payAdvanceAmt
        cell.balanceAmtLbl.text = "₹" + dataValue[indexPath.row].balance
        return cell
    }
}
