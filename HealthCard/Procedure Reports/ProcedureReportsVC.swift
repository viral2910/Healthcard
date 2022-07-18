//
//  ProcedureReportsVC.swift
//  HealthCard
//
//  Created by Viral on 13/07/22.
//

import UIKit

class ProcedureReportsVC: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    var dataValue : [ProcedureReport] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiCall()
        tableview.register(UINib(nibName: "LabReportsCell", bundle: nil), forCellReuseIdentifier: "LabReportsCell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorColor = .clear
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func ApiCall() {
        
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.ProcedureReport(patientId: 189)) { [weak self](data: ProcedureReportReponse?, error) in
            guard self == self else { return }
            self?.dataValue = data!
            self?.tableview.reloadData()
            
        }
    }
}

extension ProcedureReportsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabReportsCell", for: indexPath) as! LabReportsCell
        cell.selectionStyle = .none
        cell.name.text = dataValue[indexPath.row].filename
        cell.date.text = "\(dataValue[indexPath.row].date) \(dataValue[indexPath.row].type)"
        cell.mainview.backgroundColor = .lightGray
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

struct ProcedureReport: Codable {
    let id, procDocID: Int
    let labTestDocID, labTestID, insuranceID, insuranceDocID: JSONNull?
    let insuranceName: JSONNull?
    let patientID: String
    let patientDocID, patientName, refUnitID, refUnitDocID: JSONNull?
    let refUnitName, userID, userDocID, userName: JSONNull?
    let doctorID, doctorDocID, doctorName, bankID: JSONNull?
    let bankDocID, bankName, pharmacyID, pharmacyDocID: JSONNull?
    let pharmacyName, laboratoryID, laboratoryDocID, laboratoryName: JSONNull?
    let deliveryBoyID, deliveryBoyDocID, deliveryBoyName, pharmacyOutDocID: JSONNull?
    let pharmacyOutID: JSONNull?
    let type, date, filename: String
    let displayFilename: JSONNull?
    let filePath: String
    let fileEXT: FileEXT
    let uploadFileName: String
    let createdBy: CreatedBy
    let createdOn: String
    let updatedBy, updatedOn, orgFile, currUser: JSONNull?
    let investigationAdviseID, isEdit: JSONNull?
    let reportLink: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case procDocID = "ProcDocId"
        case labTestDocID = "LabTestDocId"
        case labTestID = "LabTestId"
        case insuranceID = "InsuranceId"
        case insuranceDocID = "InsuranceDocId"
        case insuranceName = "InsuranceName"
        case patientID = "PatientId"
        case patientDocID = "PatientDocId"
        case patientName = "PatientName"
        case refUnitID = "RefUnitId"
        case refUnitDocID = "RefUnitDocId"
        case refUnitName = "RefUnitName"
        case userID = "UserId"
        case userDocID = "UserDocId"
        case userName = "UserName"
        case doctorID = "DoctorId"
        case doctorDocID = "DoctorDocId"
        case doctorName = "DoctorName"
        case bankID = "BankId"
        case bankDocID = "BankDocId"
        case bankName = "BankName"
        case pharmacyID = "PharmacyId"
        case pharmacyDocID = "PharmacyDocId"
        case pharmacyName = "PharmacyName"
        case laboratoryID = "LaboratoryId"
        case laboratoryDocID = "LaboratoryDocId"
        case laboratoryName = "LaboratoryName"
        case deliveryBoyID = "DeliveryBoyId"
        case deliveryBoyDocID = "DeliveryBoyDocId"
        case deliveryBoyName = "DeliveryBoyName"
        case pharmacyOutDocID = "PharmacyOutDocId"
        case pharmacyOutID = "PharmacyOutId"
        case type = "Type"
        case date = "Date"
        case filename = "Filename"
        case displayFilename = "DisplayFilename"
        case filePath = "FilePath"
        case fileEXT = "FileExt"
        case uploadFileName = "UploadFileName"
        case createdBy = "CreatedBy"
        case createdOn = "CreatedOn"
        case updatedBy = "UpdatedBy"
        case updatedOn = "UpdatedOn"
        case orgFile = "OrgFile"
        case currUser = "CurrUser"
        case investigationAdviseID = "InvestigationAdviseId"
        case isEdit = "IsEdit"
        case reportLink = "ReportLink"
    }
}

enum CreatedBy: String, Codable {
    case dipikaJadhav = "DIPIKA JADHAV"
    case drAjitaBhise = "DR AJITA BHISE"
    case rakshitaShetty = "RAKSHITA SHETTY"
    case superAdmin = "SUPER ADMIN"
}

enum FileEXT: String, Codable {
    case jpg = ".jpg"
    case pdf = ".pdf"
    case png = ".png"
}

typealias ProcedureReportReponse = [ProcedureReport]
