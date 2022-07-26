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
    var presciptionID = ""
    var isMedicine = false
    //    var dataValue : [[String: String?]] = []
    
    var dataValue : [LabTestList] = []
    var dataValuepharmacy : [pharmacyListdetails] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if isMedicine {
            apiCallPharmacy()
        } else {
        apiCall()
        }
        setupTableCell()
        // Do any additional setup after loading the view.
    }
    /// TableViewCell Setup
    private func setupTableCell(){
        tableview.register(UINib(nibName: "LabDetailsCell", bundle: nil), forCellReuseIdentifier: "LabDetailsCell")
        tableview.register(UINib(nibName: "PharmacyDetailCell", bundle: nil), forCellReuseIdentifier: "PharmacyDetailCell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorColor = .clear
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addToCartAction(_ sender: Any) {
        if isMedicine {
            addToCartPharmacyapiCall()
        } else {
        addToCartapiCall()
        }
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
    func apiCallPharmacy()  {
        docType = docType.replacingOccurrences(of: " ", with: "%20")
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.pharmacyList(pincode: pincode, labInvestigation: labInvestigation, docId: docId, docType: docType)) { [weak self](data: [pharmacyListdetails]?, error) in
            
            if data?.count == 0 || data == nil{
                AppManager.shared.showAlert(title: "Error", msg: "No Pharmacy Available!", vc: self!)
                return
            }
            self?.dataValuepharmacy = data!
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
    //MARK: - API CALL
    func addToCartPharmacyapiCall()  {
        docType = docType.replacingOccurrences(of: " ", with: "%20")
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.addPharmacyToCart(patientID: patientID, addressID: 0, labMasterID: selectedvalue, pincode: pincode, labInvestigation: labInvestigation, docId: docId, docType: docType, qty: 1)) { [weak self](data: [addToCart]?, error) in
            
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
        if !isMedicine {
            return dataValue.count
        } else {
            return dataValuepharmacy.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !isMedicine {
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
        } else {
            print(dataValuepharmacy[indexPath.row])
            let cell = tableView.dequeueReusableCell(withIdentifier: "PharmacyDetailCell", for: indexPath)as! PharmacyDetailCell
            cell.labNameLabel.text = dataValuepharmacy[indexPath.row].pharmacyName
            cell.totalPriceLabel.text = "Total: ₹ \(dataValuepharmacy[indexPath.row].pharmacyDtlsSClist.compactMap{ Double($0.mrp) ?? 0.0 }.reduce(0.0, +))"
            cell.tableviewHeight.constant = CGFloat(dataValuepharmacy[indexPath.row].pharmacyDtlsSClist.count * 170)
            cell.AddToCartBtn.tag = Int(dataValuepharmacy[indexPath.row].pharmacyDtlsSClist[0].pharamcyMasterID) ?? 0
            cell.selectionImageView.image = (selectedvalue == Int(dataValuepharmacy[indexPath.row].pharmacyDtlsSClist[0].pharamcyMasterID) ?? 0) ? UIImage(named: "checkedcircle") : UIImage(named: "circle")
            cell.delegate = self
            cell.labListData = dataValuepharmacy[indexPath.row].pharmacyDtlsSClist
            cell.tableview.reloadData()
            cell.selectionStyle = .none
            return cell
        }
    }
}
extension LabDetailsVC:LabSelectionDelegate
{
    func getId(value: Int) {
        selectedvalue = selectedvalue != value ? value : 0
        tableview.reloadData()
    }
}
extension LabDetailsVC : PharmacySelectionDelegate {
    func getIdval(value: Int) {
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
struct pharmacyListdetails: Codable {
    let patientName, uhid, docID, opdno: JSONNull?
    let consultingDoctor, docType, brandName, genericName: JSONNull?
    let dose, medType, type, unit: JSONNull?
    let route, docDate, unitText, package: JSONNull?
    let marketingComp, manufactComp, frequency, duration: JSONNull?
    let remarks, noOfDays, orderNo, currUser: JSONNull?
    let usgRemark, hospitalID, mrp, noOfStrip: JSONNull?
    let finalAmount, stripCost, discountAmount, discountPer: JSONNull?
    let gstAmount, gstPer, netCost, balance: JSONNull?
    let pharmacyName: String
    let pharmacyDtlsSClist: [PharmacyDtlsSClistval]

    enum CodingKeys: String, CodingKey {
        case patientName = "PatientName"
        case uhid = "UHID"
        case docID = "DocId"
        case opdno = "OPDNO"
        case consultingDoctor = "ConsultingDoctor"
        case docType = "DocType"
        case brandName = "BrandName"
        case genericName = "GenericName"
        case dose = "Dose"
        case medType = "MedType"
        case type = "Type"
        case unit = "Unit"
        case route = "Route"
        case docDate = "DocDate"
        case unitText = "UnitText"
        case package = "Package"
        case marketingComp = "MarketingComp"
        case manufactComp = "ManufactComp"
        case frequency = "Frequency"
        case duration = "Duration"
        case remarks = "Remarks"
        case noOfDays = "NoOfDays"
        case orderNo = "OrderNo"
        case currUser = "CurrUser"
        case usgRemark = "USGRemark"
        case hospitalID = "HospitalId"
        case mrp = "MRP"
        case noOfStrip = "NoOfStrip"
        case finalAmount = "FinalAmount"
        case stripCost = "StripCost"
        case discountAmount = "DiscountAmount"
        case discountPer = "DiscountPer"
        case gstAmount = "GSTAmount"
        case gstPer = "GSTPer"
        case netCost = "NetCost"
        case balance = "Balance"
        case pharmacyName = "PharmacyName"
        case pharmacyDtlsSClist = "PharmacyDtlsSClist"
    }
}

// MARK: - PharmacyDtlsSClist
struct PharmacyDtlsSClistval: Codable {
    let docID, docType: String
    let docDate: JSONNull?
    let medicineID, brandID, brandName, genericID: String
    let genericName, doseID, dose, medType: String
    let type: JSONNull?
    let unitID, unit: String
    let route, unitText: JSONNull?
    let package: String
    let marketingComp, manufactComp, frequency, duration: JSONNull?
    let remarks, noOfDays, orderNo, currUser: JSONNull?
    let usgRemark, hospitalID: JSONNull?
    let mrp: String
    let noOfStrip, finalAmount, stripCost: JSONNull?
    let discountAmount, discountPer, gstAmount, gstPer: String
    let netCost: String
    let isPay, balance: JSONNull?
    let pharamcyMasterID, pharmacyName, isPrescription, prescriptionStatus: String
    let manufactureID, manufactureCompany: String
    let drugImageURL: String

    enum CodingKeys: String, CodingKey {
        case docID = "DocId"
        case docType = "DocType"
        case docDate = "DocDate"
        case medicineID = "MedicineId"
        case brandID = "BrandId"
        case brandName = "BrandName"
        case genericID = "GenericId"
        case genericName = "GenericName"
        case doseID = "DoseId"
        case dose = "Dose"
        case medType = "MedType"
        case type = "Type"
        case unitID = "UnitId"
        case unit = "Unit"
        case route = "Route"
        case unitText = "UnitText"
        case package = "Package"
        case marketingComp = "MarketingComp"
        case manufactComp = "ManufactComp"
        case frequency = "Frequency"
        case duration = "Duration"
        case remarks = "Remarks"
        case noOfDays = "NoOfDays"
        case orderNo = "OrderNo"
        case currUser = "CurrUser"
        case usgRemark = "USGRemark"
        case hospitalID = "HospitalId"
        case mrp = "MRP"
        case noOfStrip = "NoOfStrip"
        case finalAmount = "FinalAmount"
        case stripCost = "StripCost"
        case discountAmount = "DiscountAmount"
        case discountPer = "DiscountPer"
        case gstAmount = "GSTAmount"
        case gstPer = "GSTPer"
        case netCost = "NetCost"
        case isPay = "IsPay"
        case balance = "Balance"
        case pharamcyMasterID = "PharamcyMasterId"
        case pharmacyName = "PharmacyName"
        case isPrescription = "IsPrescription"
        case prescriptionStatus = "PrescriptionStatus"
        case manufactureID = "ManufactureId"
        case manufactureCompany = "ManufactureCompany"
        case drugImageURL = "DrugImageURL"
    }
}
