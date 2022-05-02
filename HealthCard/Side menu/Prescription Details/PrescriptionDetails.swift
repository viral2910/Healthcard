//
//  PrescriptionDetails.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

// MARK: - WelcomeElement
struct prescriptionData: Codable {
    let patientID: Int
    let prescriptionID, bookAppID, complaints, diagnosis: String
    let pulse: String
    let bp: Bp
    let temp: Temp
    let rr: String
    let uterusRemarks, fornixRemarks, cervixRemarks: CervixRemarks
    let otherGenExam: OtherGenExam
    let externalGenitalia: CervixRemarks
    let perVag: PerVag
    let spectrumExam: CervixRemarks
    let uterus, ovariesRight, ovariesLeft, ovariesComm: String
    let endometrial, adnexal, investigationAdvise, medicationAdvice: String
    let procedureAdvice: String
    let procedureAdviseRemarks: ProcedureAdviseRemarks
    let remarks: Remarks
    let prescriptionType: PrescriptionType
    let nfuDay: String
    let nfuDate: NFUDate
    let nfuCreatedDate: NFUCreatedDate
    let bookedFor: String
    let reportLink: String
    let ivfID, planningTreatment: String
    let planningTreatmentName: PlanningTreatmentName
    let planningDate: JSONNull?
    let planningNo, lmpDate, ocpldDate: String

    enum CodingKeys: String, CodingKey {
        case patientID = "PatientId"
        case prescriptionID = "PrescriptionId"
        case bookAppID = "BookAppId"
        case complaints = "Complaints"
        case diagnosis = "Diagnosis"
        case pulse = "Pulse"
        case bp = "BP"
        case temp = "Temp"
        case rr = "RR"
        case uterusRemarks = "UterusRemarks"
        case fornixRemarks = "FornixRemarks"
        case cervixRemarks = "CervixRemarks"
        case otherGenExam = "OtherGenExam"
        case externalGenitalia = "ExternalGenitalia"
        case perVag = "PerVag"
        case spectrumExam = "SpectrumExam"
        case uterus = "Uterus"
        case ovariesRight = "OvariesRight"
        case ovariesLeft = "OvariesLeft"
        case ovariesComm = "OvariesComm"
        case endometrial = "Endometrial"
        case adnexal = "Adnexal"
        case investigationAdvise = "InvestigationAdvise"
        case medicationAdvice = "MedicationAdvice"
        case procedureAdvice = "ProcedureAdvice"
        case procedureAdviseRemarks = "ProcedureAdviseRemarks"
        case remarks = "Remarks"
        case prescriptionType = "PrescriptionType"
        case nfuDay = "NFUDay"
        case nfuDate = "NFUDate"
        case nfuCreatedDate = "NFUCreatedDate"
        case bookedFor = "BookedFor"
        case reportLink = "ReportLink"
        case ivfID = "IVFId"
        case planningTreatment = "PlanningTreatment"
        case planningTreatmentName = "PlanningTreatmentName"
        case planningDate = "PlanningDate"
        case planningNo = "PlanningNo"
        case lmpDate = "LMPDate"
        case ocpldDate = "OCPLDDate"
    }
}

enum Bp: String, Codable {
    case the12080 = "120/80"
}

enum CervixRemarks: String, Codable {
    case demo = "demo"
    case empty = ""
    case normal = "NORMAL"
}

enum NFUCreatedDate: String, Codable {
    case empty = ""
    case the04Mar20210425PM = "04-Mar-2021 04:25 PM"
    case the12Sep20200506PM = "12-Sep-2020 05:06 PM"
}

enum NFUDate: String, Codable {
    case empty = ""
    case the01Jan2021 = "01/Jan/2021"
    case the12Sep2020 = "12/Sep/2020"
}

enum OtherGenExam: String, Codable {
    case normal = "Normal"
}

enum PerVag: String, Codable {
    case empty = ""
    case the8081 = "80,81"
}

enum PlanningTreatmentName: String, Codable {
    case empty = ""
    case iuiSelfSemen = "IUI SELF SEMEN"
    case plannedRelations = "PLANNED RELATIONS"
}

enum PrescriptionType: String, Codable {
    case opd = "OPD"
    case planning = "PLANNING"
    case planningDay2 = "PLANNING/DAY2"
}

enum ProcedureAdviseRemarks: String, Codable {
    case empty = ""
    case takeMedicines = "TAKE MEDICINES "
}

enum Remarks: String, Codable {
    case empty = ""
    case foloowUpOnMonday = "FOLOOW UP ON MONDAY "
}

enum Temp: String, Codable {
    case afebrile = "Afebrile"
}

//typealias Welcome = [prescriptionData]

// MARK: - Encode/decode helpers



class PrescriptionDetails: UIViewController, XIBed {

    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var pencilBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var dataValue = [prescriptionData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        pencilBtn.setTitle("", for: .normal)
        homeBtn.setTitle("", for: .normal)
        tableView.register(UINib(nibName: "prescriptionDetailsCell", bundle: nil), forCellReuseIdentifier: "prescriptionDetailsCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        apiCall()
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func homeBtn(_ sender: UIButton) {
        
    }
}

// MARK: - Prescription Details Data
extension PrescriptionDetails{
    
    
    //MARK: - API CALL
    func apiCall()  {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.MyPrescription(patientId: patientID)) { [weak self](data: [prescriptionData]?, error) in
                
                self?.dataValue = data!
                self?.tableView.reloadData()
               // print(patientIDval)
            
        }
    }
}

// MARK: - Extension OF TableView
extension PrescriptionDetails: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prescriptionDetailsCell", for: indexPath)as! prescriptionDetailsCell
        cell.pdfLbl.text = "\(dataValue[indexPath.row].prescriptionID).pdf"
        if dataValue[indexPath.row].lmpDate == ""{
            cell.planningLbl.text = "\(dataValue[indexPath.row].prescriptionType)"
        }else{
            cell.planningLbl.text = dataValue[indexPath.row].lmpDate
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValue.count
    }
}
