//
//  ProcedureBillingPaymentVC.swift
//  HealthCard
//
//  Created by Dhairya on 30/04/22.
//

import UIKit

// MARK: - WelcomeElement
class procedureBillingData: Codable {
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
    let totalAfterDisAmt, advRec, estimateCreationDate: JSONNull?
    let totalDueAmount, finalBilledAmt, payAdvanceAmt, balance: String
    let receivedAmt, paidBilledAmt: String
    let reportLink: JSONNull?

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

class ProcedureBillingPaymentVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataValue = [procedureBillingData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        ApiCall()
    }
    
    private func setup(){
        tableView.register(UINib(nibName: "ProcedurePaymentCell", bundle: nil), forCellReuseIdentifier: "ProcedurePaymentCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
    }

}

//MARK: -Extension of TableView
extension ProcedureBillingPaymentVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProcedurePaymentCell", for: indexPath) as! ProcedurePaymentCell
//        cell.
        return cell
    }
}

//MARK: - API Calling
extension ProcedureBillingPaymentVC{
    func ApiCall() {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.procedureBilling(patientID: patientID)) { [weak self](data: [procedureBillingData]?, error) in
                self?.dataValue = data!
            self!.tableView.reloadData()
              
        }
    }
}
