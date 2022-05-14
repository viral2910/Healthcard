//
//  LabDetailsVC.swift
//  HealthCard
//
//  Created by Viral on 13/05/22.
//

import UIKit

class LabDetailsVC: UIViewController,XIBed {
    
    @IBOutlet weak var tableview: UITableView!
    var selectedvalue = 0
    var pincode = ""
    var labInvestigation = ""
    var docId = ""
    var docType = ""
    //    var dataValue : [[String: String?]] = []
    
    var dataValue : [LabTestList] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCall()
        setupTableCell()
        // Do any additional setup after loading the view.
    }
    /// TableViewCell Setup
    private func setupTableCell(){
        tableview.register(UINib(nibName: "LabDetailsCell", bundle: nil), forCellReuseIdentifier: "LabDetailsCell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorColor = .clear
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addToCartAction(_ sender: Any) {
        addToCartapiCall()
    }
}

extension LabDetailsVC{
    
    //MARK: - API CALL
    func apiCall()  {
        docType = docType.replacingOccurrences(of: " ", with: "%20")
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.pathologyLabList(pincode: pincode, labInvestigation: labInvestigation, docId: docId, docType: docType)) { [weak self](data: [LabTestList]?, error) in
            if data?.count == 0 {
                AppManager.shared.showAlert(title: "Error", msg: "No Labs Available!", vc: self!)
                return
            }
            self?.dataValue = data!
            self?.tableview.reloadData()
            // print(patientIDval)
        }
    }
    
    
    //MARK: - API CALL
    func addToCartapiCall()  {
        docType = docType.replacingOccurrences(of: " ", with: "%20")
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.addLabToCart(patientID: patientID, addressID: 0, labMasterID: selectedvalue, pincode: pincode, labInvestigation: labInvestigation, docId: docId, docType: docType, qty: 1)) { [weak self](data: [addToCart]?, error) in
            
            if data?[0].status == "1" {
                let vc = CartDetails.instantiate()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
extension LabDetailsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabDetailsCell", for: indexPath)as! LabDetailsCell
        cell.labNameLabel.text = dataValue[indexPath.row].labName
        cell.totalPriceLabel.text = "Total: ₹ \(dataValue[indexPath.row].labTestDtlslist.compactMap{ $0.charges }.reduce(0, +))"
        cell.tableviewHeight.constant = CGFloat(dataValue[indexPath.row].labTestDtlslist.count * 110)
        cell.AddToCartBtn.tag = Int(dataValue[indexPath.row].labTestDtlslist[0].labMasterID) ?? 0
        cell.selectionImageView.image = (selectedvalue == Int(dataValue[indexPath.row].labTestDtlslist[0].labMasterID) ?? 0) ? UIImage(named: "checkedcircle") : UIImage(named: "circle")
        cell.delegate = self
        cell.labListData = dataValue[indexPath.row].labTestDtlslist
        cell.tableview.reloadData()
        cell.selectionStyle = .none
        return cell
    }
}
extension LabDetailsVC:LabSelectionDelegate
{
    func getId(value: Int) {
        selectedvalue = selectedvalue != value ? value : 0
        tableview.reloadData()
    }
}
struct LabTestList: Codable {
    let patientName, uhid, opdno, consultingDoctor: JSONNull?
    let docDate: JSONNull?
    let labName: String
    let labTestID, testCode, labTestText: JSONNull?
    let labTestDtlslist: [LabTestDtlslistval]
    
    enum CodingKeys: String, CodingKey {
        case patientName = "PatientName"
        case uhid = "UHID"
        case opdno = "OPDNO"
        case consultingDoctor = "ConsultingDoctor"
        case docDate = "DocDate"
        case labName = "LabName"
        case labTestID = "LabTestId"
        case testCode = "TestCode"
        case labTestText = "LabTestText"
        case labTestDtlslist = "LabTestDtlslist"
    }
}

// MARK: - LabTestDtlslist
struct LabTestDtlslistval: Codable {
    let docID: String
    let docType, docDate: JSONNull?
    let id: Int
    let testCode: String
    let labTestID: Int
    let labTestText: String
    let mrp, discountPer, discountAmt, charges: Int
    let labMasterID, labName: String
    let collectionIn, sampleDetails, method: JSONNull?
    let labTestImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case docID = "DocId"
        case docType = "DocType"
        case docDate = "DocDate"
        case id = "Id"
        case testCode = "TestCode"
        case labTestID = "LabTestId"
        case labTestText = "LabTestText"
        case mrp = "MRP"
        case discountPer = "DiscountPer"
        case discountAmt = "DiscountAmt"
        case charges = "Charges"
        case labMasterID = "LabMasterId"
        case labName = "LabName"
        case collectionIn = "CollectionIn"
        case sampleDetails = "SampleDetails"
        case method = "Method"
        case labTestImageURL = "LabTestImageURL"
    }
}
struct addToCart: Codable {
    let message, status: String
    let patientID, gender, firstName, middleName: JSONNull?
    let lastName, patientName, pincode, patientProfilePicURL: JSONNull?
    let patientDocumentURL, deliveryBoyID, deliveryBoy, doctorID: JSONNull?
    let doctor, doctorProfilePicURL, labMasterID, labConcernPerson: JSONNull?
    let pharmacyID, pharmacyCoordinator: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case status = "Status"
        case patientID = "PatientId"
        case gender = "Gender"
        case firstName = "FirstName"
        case middleName = "MiddleName"
        case lastName = "LastName"
        case patientName = "PatientName"
        case pincode = "Pincode"
        case patientProfilePicURL = "PatientProfilePicURL"
        case patientDocumentURL = "PatientDocumentURL"
        case deliveryBoyID = "DeliveryBoyId"
        case deliveryBoy = "DeliveryBoy"
        case doctorID = "DoctorId"
        case doctor = "Doctor"
        case doctorProfilePicURL = "DoctorProfilePicURL"
        case labMasterID = "LabMasterId"
        case labConcernPerson = "LabConcernPerson"
        case pharmacyID = "PharmacyId"
        case pharmacyCoordinator = "PharmacyCoordinator"
    }
}
