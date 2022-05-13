//
//  OPDBillingPaymentVCViewController.swift
//  HealthCard
//
//  Created by Dhairya on 30/04/22.
//

import UIKit

class OPDBillingPaymentVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataValue = [opdBilling]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "OpdConsultationCell", bundle: nil), forCellReuseIdentifier: "OpdConsultationCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        apiCall()
    }

}

extension OPDBillingPaymentVC{

    //MARK: - API CALL
    func apiCall()  {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.OPDBillingList(patientID: patientID)) { [weak self](data: [opdBilling]?, error) in
                self?.dataValue = data!
                self?.tableView.reloadData()
        }
    }
}
extension OPDBillingPaymentVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OpdConsultationCell", for: indexPath)as! OpdConsultationCell
        cell.billReleaseDateLbl.text = dataValue[indexPath.row].billReleaseDate
        cell.totalDiscountLbl.text = dataValue[indexPath.row].totalDiscountVal
        cell.amountDueLbl.text = dataValue[indexPath.row].totalDueAmount
        cell.balanceLbl.text = dataValue[indexPath.row].balance
//        cell.doctorNameLbl.text = dataValue[indexPath.row].
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValue.count
    }
}

struct opdBilling: Codable {
    let id, bookAppBillID, patientID, bookAppID: JSONNull?
    let paymentHead, invoiceNo, billReleaseDate, totalDueAmount: String
    let balance: String
    let gstTax: JSONNull?
    let receivedAmount: String
    let totalAmount, totalAfterDisc, stageID: JSONNull?
    let status: String
    let isPendToApprDisc, isDiscount: JSONNull?
    let totalDiscountVal, totalDiscountPer: String
    let paymentMode, createdBy, createdOn, billingComponentID: JSONNull?
    let type, subType, orgCode, amount: JSONNull?
    let percentageBilling, orderNo, isEdit, reportLink: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case bookAppBillID = "BookAppBillId"
        case patientID = "PatientId"
        case bookAppID = "BookAppId"
        case paymentHead = "PaymentHead"
        case invoiceNo = "InvoiceNo"
        case billReleaseDate = "BillReleaseDate"
        case totalDueAmount = "TotalDueAmount"
        case balance = "Balance"
        case gstTax = "GST_Tax"
        case receivedAmount = "ReceivedAmount"
        case totalAmount = "TotalAmount"
        case totalAfterDisc = "TotalAfterDisc"
        case stageID = "StageId"
        case status = "Status"
        case isPendToApprDisc = "IsPendToApprDisc"
        case isDiscount = "IsDiscount"
        case totalDiscountVal = "TotalDiscountVal"
        case totalDiscountPer = "TotalDiscountPer"
        case paymentMode = "PaymentMode"
        case createdBy = "CreatedBy"
        case createdOn = "CreatedOn"
        case billingComponentID = "BillingComponentId"
        case type = "Type"
        case subType = "SubType"
        case orgCode = "OrgCode"
        case amount = "Amount"
        case percentageBilling = "PercentageBilling"
        case orderNo = "OrderNo"
        case isEdit = "IsEdit"
        case reportLink = "ReportLink"
    }
}

