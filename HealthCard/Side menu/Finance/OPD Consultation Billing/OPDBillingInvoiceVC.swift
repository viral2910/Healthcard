//
//  OPDBillingInvoiceVC.swift
//  HealthCard
//
//  Created by Viral on 25/07/22.
//

import UIKit

class OPDBillingInvoiceVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var completeddataValue = [opdCompletedBilling]()
    var isCompleted = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "OPDBillingInvoiceCell", bundle: nil), forCellReuseIdentifier: "OPDBillingInvoiceCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        apiCall()
    }
    
}

extension OPDBillingInvoiceVC{
    
    //MARK: - API CALL
    func apiCall()  {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        
        NetWorker.shared.callAPIService(type: APIV2.OPDCompletedBillingList(patientID: patientID)) { [weak self](data: [opdCompletedBilling]?, error) in
            self?.completeddataValue = data!
            self?.tableView.reloadData()
            
        }
    }
}
extension OPDBillingInvoiceVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OPDBillingInvoiceCell", for: indexPath)as! OPDBillingInvoiceCell
        cell.invoiceNo.text = completeddataValue[indexPath.row].invoiceNo
        cell.billreleaseDate.text = completeddataValue[indexPath.row].billReleaseDate
        cell.Discount.text = completeddataValue[indexPath.row].totalDiscountVal
        cell.paymentHead.text = completeddataValue[indexPath.row].paymentHead
        cell.dueAmt.text = completeddataValue[indexPath.row].totalDueAmount
        cell.receivedAmt.text = completeddataValue[indexPath.row].receivedAmount
        //        cell.doctorNameLbl.text = dataValue[indexPath.row].
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return completeddataValue.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let value = completeddataValue[indexPath.row].reportLink.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: value) else {
            print(value)
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
}


struct opdCompletedBilling: Codable {
    let id, bookAppBillID, patientID, bookAppID: JSONNull?
    let paymentHead, invoiceNo, billReleaseDate, totalDueAmount: String
    let balance, gstTax: JSONNull?
    let receivedAmount: String
    let totalAmount, totalAfterDisc, stageID: JSONNull?
    let status: String
    let isPendToApprDisc, isDiscount: JSONNull?
    let totalDiscountVal, totalDiscountPer: String
    let paymentMode, createdBy, createdOn, billingComponentID: JSONNull?
    let type, subType, orgCode, amount: JSONNull?
    let percentageBilling, orderNo, isEdit: JSONNull?
    let reportLink: String
    
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
