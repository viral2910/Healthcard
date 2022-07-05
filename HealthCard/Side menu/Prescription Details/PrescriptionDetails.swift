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
    let bp: String
    let temp: String
    let rr: String
    let uterusRemarks, fornixRemarks, cervixRemarks: String
    let otherGenExam: String
    let externalGenitalia: String
    let perVag: String
    let spectrumExam: String
    let uterus, ovariesRight, ovariesLeft, ovariesComm: String
    let endometrial, adnexal, investigationAdvise, medicationAdvice: String
    let procedureAdvice: String
    let procedureAdviseRemarks: String
    let remarks: String
    let prescriptionType: String
    let nfuDay: String
    let nfuDate: String
    let nfuCreatedDate: String
    let bookedFor: String
    let reportLink: String
    let ivfID, planningTreatment: String
    let planningTreatmentName: String
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
        
            self.navigationController?.popViewController(animated: true)
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
