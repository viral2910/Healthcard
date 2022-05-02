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
    let planDate: String
    let procedureTypeID, procedureTypeValue, specialityID, specialityValue: String
    let procedureName, procedureCodeName: String
    let opdprTimeSlot, otTimeSlot, rrTimeSlot, hospitalStay: String
    let patientCat, wardType, wardNoOfDays, specialInstrument: String
    let specialInstrumentName, isActive, isActiveText, currUserID: String
    let currUserRole, hospitalID, isEdit, hiddProcedureBillingList: String
    let hiddSpecialInst: String
    let estimatePlanRefNo: String
    let isRelease, isAllRelease, releaseType: String
    let releaseDate, releaseCode: String
    let discountPer: String
    let discountAmt: String
    let totalAfterDisAmt, advRec, estimateCreationDate: String
    let totalDueAmount, finalBilledAmt, payAdvanceAmt, balance: String
    let receivedAmt, paidBilledAmt: String
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

    init(estimatePlanID: String, patientID: String, patientName: String, surgeonID: String, surgeonName: String, planDate: String, procedureTypeID: String, procedureTypeValue: String, specialityID: String, specialityValue: String, procedureName: String, procedureCodeName: String, opdprTimeSlot: String, otTimeSlot: String, rrTimeSlot: String, hospitalStay: String, patientCat: String, wardType: String, wardNoOfDays: String, specialInstrument: String, specialInstrumentName: String, isActive: String, isActiveText: String, currUserID: String, currUserRole: String, hospitalID: String, isEdit: String, hiddProcedureBillingList: String, hiddSpecialInst: String, estimatePlanRefNo: String, isRelease: String, isAllRelease: String, releaseType: String, releaseDate: String, releaseCode: String, discountPer: String, discountAmt: String, totalAfterDisAmt: String, advRec: String, estimateCreationDate: String, totalDueAmount: String, finalBilledAmt: String, payAdvanceAmt: String, balance: String, receivedAmt: String, paidBilledAmt: String, reportLink: String) {
        self.estimatePlanID = estimatePlanID
        self.patientID = patientID
        self.patientName = patientName
        self.surgeonID = surgeonID
        self.surgeonName = surgeonName
        self.planDate = planDate
        self.procedureTypeID = procedureTypeID
        self.procedureTypeValue = procedureTypeValue
        self.specialityID = specialityID
        self.specialityValue = specialityValue
        self.procedureName = procedureName
        self.procedureCodeName = procedureCodeName
        self.opdprTimeSlot = opdprTimeSlot
        self.otTimeSlot = otTimeSlot
        self.rrTimeSlot = rrTimeSlot
        self.hospitalStay = hospitalStay
        self.patientCat = patientCat
        self.wardType = wardType
        self.wardNoOfDays = wardNoOfDays
        self.specialInstrument = specialInstrument
        self.specialInstrumentName = specialInstrumentName
        self.isActive = isActive
        self.isActiveText = isActiveText
        self.currUserID = currUserID
        self.currUserRole = currUserRole
        self.hospitalID = hospitalID
        self.isEdit = isEdit
        self.hiddProcedureBillingList = hiddProcedureBillingList
        self.hiddSpecialInst = hiddSpecialInst
        self.estimatePlanRefNo = estimatePlanRefNo
        self.isRelease = isRelease
        self.isAllRelease = isAllRelease
        self.releaseType = releaseType
        self.releaseDate = releaseDate
        self.releaseCode = releaseCode
        self.discountPer = discountPer
        self.discountAmt = discountAmt
        self.totalAfterDisAmt = totalAfterDisAmt
        self.advRec = advRec
        self.estimateCreationDate = estimateCreationDate
        self.totalDueAmount = totalDueAmount
        self.finalBilledAmt = finalBilledAmt
        self.payAdvanceAmt = payAdvanceAmt
        self.balance = balance
        self.receivedAmt = receivedAmt
        self.paidBilledAmt = paidBilledAmt
        self.reportLink = reportLink
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProcedurePaymentCell", for: indexPath)as! ProcedurePaymentCell
        return cell
    }
}

//MARK: - API Calling
extension ProcedureBillingPaymentVC{
    func ApiCall() {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.MyPrescription(patientId: patientID)) { [weak self](data: [procedureBillingData]?, error) in
           print(data?.first?.patientID)
                self?.dataValue = data!
                self?.tableView.reloadData()
              
        }
    }
}
