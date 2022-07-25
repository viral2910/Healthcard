//
//  AdvanceBillingReceiptVC.swift
//  HealthCard
//
//  Created by Viral on 25/07/22.
//

import UIKit


class AdvanceBillingReceiptVC: UIViewController {

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
extension AdvanceBillingReceiptVC{

    //MARK: - API CALL
    func apiCall()  {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.estimateAdvanceBillingList(patientID: patientID)) { [weak self](data: [advanceBilling]?, error) in
                self?.dataValue = data!
                self?.tableView.reloadData()
        }
    }
}
extension AdvanceBillingReceiptVC: UITableViewDelegate, UITableViewDataSource{
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let value = dataValue[indexPath.row].reportLink.replacingOccurrences(of: " ", with: "%20")
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

struct advanceBilling: Codable {
    let estimatePlanID, patientID, patientName, surgeonID: String
    let surgeonName: String
    let planDate: JSONNull?
    let procedureTypeID, procedureTypeValue, specialityID, specialityValue: String
    let procedureName, procedureCodeName: String
    let opdprTimeSlot, otTimeSlot, rrTimeSlot, hospitalStay: JSONNull?
    let patientCat, wardType, wardNoOfDays, specialInstrument: JSONNull?
    let specialInstrumentName, isActive, isActiveText, currUserID: JSONNull?
    let currUserRole, hospitalID, isEdit, hiddProcedureBillingList: JSONNull?
    let hiddSpecialInst: JSONNull?
    let estimatePlanRefNo: String
    let isRelease, isAllRelease, releaseType: JSONNull?
    let releaseDate, releaseCode: String
    let discountPer: JSONNull?
    let discountAmt: String
    let totalAfterDisAmt, advRec: JSONNull?
    let estimateCreationDate, totalDueAmount, finalBilledAmt, payAdvanceAmt: String
    let balance, receivedAmt, paidBilledAmt: String
    let reportLink: String

    enum CodingKeys: String, CodingKey {
        case estimatePlanID = "EstimatePlanId"
        case patientID = "PatientId"
        case patientName = "PatientName"
        case surgeonID = "SurgeonId"
        case surgeonName = "SurgeonName"
        case planDate = "PlanDate"
        case procedureTypeID = "ProcedureTypeId"
        case procedureTypeValue = "ProcedureTypeValue"
        case specialityID = "SpecialityId"
        case specialityValue = "SpecialityValue"
        case procedureName = "ProcedureName"
        case procedureCodeName = "ProcedureCodeName"
        case opdprTimeSlot = "OPDPRTimeSlot"
        case otTimeSlot = "OtTimeSlot"
        case rrTimeSlot = "RrTimeSlot"
        case hospitalStay = "HospitalStay"
        case patientCat = "PatientCat"
        case wardType = "WardType"
        case wardNoOfDays = "WardNoOfDays"
        case specialInstrument = "SpecialInstrument"
        case specialInstrumentName = "SpecialInstrumentName"
        case isActive = "IsActive"
        case isActiveText = "IsActiveText"
        case currUserID = "CurrUserId"
        case currUserRole = "CurrUserRole"
        case hospitalID = "HospitalId"
        case isEdit = "IsEdit"
        case hiddProcedureBillingList, hiddSpecialInst
        case estimatePlanRefNo = "EstimatePlanRefNo"
        case isRelease = "IsRelease"
        case isAllRelease = "IsAllRelease"
        case releaseType = "ReleaseType"
        case releaseDate = "ReleaseDate"
        case releaseCode = "ReleaseCode"
        case discountPer = "DiscountPer"
        case discountAmt = "DiscountAmt"
        case totalAfterDisAmt = "TotalAfterDisAmt"
        case advRec = "AdvRec"
        case estimateCreationDate = "EstimateCreationDate"
        case totalDueAmount = "TotalDueAmount"
        case finalBilledAmt = "FinalBilledAmt"
        case payAdvanceAmt = "PayAdvanceAmt"
        case balance = "Balance"
        case receivedAmt = "ReceivedAmt"
        case paidBilledAmt = "PaidBilledAmt"
        case reportLink = "ReportLink"
    }
}


