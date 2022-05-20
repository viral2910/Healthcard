//
//  MedicineVC.swift
//  HealthCard
//
//  Created by Viral on 07/05/22.
//

import UIKit

class MedicineVC: UIViewController {
    
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var BtnLineRef: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var selectedDocID : [Int] = []
    var LabInvestigationID : [Int] = []
    var docTypeList : [String] = []
    var prescriptionList : [String] = []
    var storyData : [pharmacyList] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiCall()
        self.navigationController?.navigationBar.isHidden = false
        tableview.dataSource = self
        tableview.delegate = self
        BtnLineRef.layer.borderColor = UIColor.init(hexString: "007AB8").cgColor
        BtnLineRef.layer.borderWidth = 2
        tableview.register(UINib(nibName: "BookMedicineCell", bundle: nil), forCellReuseIdentifier: "BookMedicineCell")
        // Do any additional setup after loading the view.
    }
    @IBAction func backVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchBtnAction(_ sender: Any) {
    }
    @IBAction func proceedBtnAction(_ sender: Any) {
        proceedApiCall()
    }
    @IBAction func cartAction(_ sender: Any) {
        let vc = CartDetails.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension MedicineVC {
    
    func ApiCall() {
        struct demo: Codable { }
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.PatientMedicineDetails(patientId: patientID)) { [weak self](data: [pharmacyList]?, error) in
            self?.storyData = data!
            self?.tableview.reloadData()
            
        }
    }
    
    //MARK: - API CALL
    func proceedApiCall() {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.myCartList(patientID: patientID)) { [weak self](data: [cartDetails]?, error) in
            if data?.count ?? 0 > 0 {
                if data?[0].cartDtlslist.count ?? 0 > 0 {
                    if (self?.prescriptionList.contains("True") ?? false) {
                        let vc = PrescriptionListVC.instantiate()
                        vc.pincode = "\(data?[0].cartDtlslist[0].deliveryPincode ?? 0)"
                        vc.docId = (self?.LabInvestigationID.map{String($0)})?.joined(separator: ",") ?? ""
                        vc.labInvestigation = (self?.selectedDocID.map{String($0)})?.joined(separator: ",") ?? ""
                        vc.docType = self?.docTypeList.joined(separator: ",") ?? ""
                        vc.addressReq = false
                        self?.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        let vc = LabDetailsVC.instantiate()
                        vc.pincode = "\(data?[0].cartDtlslist[0].deliveryPincode ?? 0)"
                        vc.docId = (self?.LabInvestigationID.map{String($0)})?.joined(separator: ",") ?? ""
                        vc.labInvestigation = (self?.selectedDocID.map{String($0)})?.joined(separator: ",") ?? ""
                        vc.docType = self?.docTypeList.joined(separator: ",") ?? ""
                        vc.presciptionID = ""
                        vc.isMedicine = true
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    if (self?.prescriptionList.contains("True") ?? false) {
                        let vc = PrescriptionListVC.instantiate()
                        vc.pincode = "\(data?[0].cartDtlslist[0].deliveryPincode ?? 0)"
                        vc.docId = (self?.LabInvestigationID.map{String($0)})?.joined(separator: ",") ?? ""
                        vc.labInvestigation = (self?.selectedDocID.map{String($0)})?.joined(separator: ",") ?? ""
                        vc.docType = self?.docTypeList.joined(separator: ",") ?? ""
                        vc.addressReq = true
                        self?.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        let vc = AddressDetailsVC.instantiate()
                        vc.addressSelection = true
                        vc.docId = (self?.LabInvestigationID.map{String($0)})?.joined(separator: ",") ?? ""
                        vc.labInvestigation = (self?.selectedDocID.map{String($0)})?.joined(separator: ",") ?? ""
                        vc.docType = self?.docTypeList.joined(separator: ",") ?? ""
                        vc.isMedicine = true
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            } else {
                if (self?.prescriptionList.contains("True") ?? false) {
                    let vc = PrescriptionListVC.instantiate()
                    vc.pincode = "\(data?[0].cartDtlslist[0].deliveryPincode ?? 0)"
                    vc.docId = (self?.LabInvestigationID.map{String($0)})?.joined(separator: ",") ?? ""
                    vc.labInvestigation = (self?.selectedDocID.map{String($0)})?.joined(separator: ",") ?? ""
                    vc.docType = self?.docTypeList.joined(separator: ",") ?? ""
                    vc.addressReq = true
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let vc = AddressDetailsVC.instantiate()
                    vc.addressSelection = true
                    vc.docId = (self?.LabInvestigationID.map{String($0)})?.joined(separator: ",") ?? ""
                    vc.labInvestigation = (self?.selectedDocID.map{String($0)})?.joined(separator: ",") ?? ""
                    vc.docType = self?.docTypeList.joined(separator: ",") ?? ""
                    vc.isMedicine = true
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
}

extension MedicineVC : UITableViewDataSource ,UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return storyData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableview.dequeueReusableCell(withIdentifier: "BookMedicineCell") as! BookMedicineCell
            cell.tableviewHeight.constant = CGFloat(160 * storyData[indexPath.row].pharmacyDtlsSClist.count)
            cell.consDrLabel.text = storyData[indexPath.row].consultingDoctor
            cell.dateLabel.text = storyData[indexPath.row].docDate
            cell.labListData = storyData[indexPath.row].pharmacyDtlsSClist
            cell.delegate = self
            cell.tableview.reloadData()
            cell.selectedID = selectedDocID
            cell.LabID = LabInvestigationID
            cell.LabDocType = docTypeList
            cell.contentView.tag = indexPath.row
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension MedicineVC : BookMedicineDelegate {
    func getTestId(DocId: Int,LabInvest:Int,docType:String,prescriptionReq:String,indexPathRow:Int) {
        
        if selectedDocID.contains(DocId) && LabInvestigationID.contains(LabInvest) {
            if let index = LabInvestigationID.firstIndex(of: LabInvest) {
                selectedDocID.remove(at: index)
                LabInvestigationID.remove(at: index)
                docTypeList.remove(at: index)
                prescriptionList.remove(at: index)
            }
        } else {
            selectedDocID.append(DocId)
            LabInvestigationID.append(LabInvest)
            docTypeList.append(docType)
            prescriptionList.append(prescriptionReq)
        }
        if selectedDocID.count > 0 {
            bottomConstraint.constant = 60
        } else {
            bottomConstraint.constant = -5
        }
        tableview.reloadRows(at: [IndexPath(row: indexPathRow, section: 0)], with: .none)
    }
}

struct pharmacyList: Codable {
    let patientName, uhid: String
    let docID: JSONNull?
    let opdno, consultingDoctor: String
    let docType, brandName, genericName, dose: JSONNull?
    let medType, type, unit, route: JSONNull?
    let docDate: String
    let unitText, package, marketingComp, manufactComp: JSONNull?
    let frequency, duration, remarks, noOfDays: JSONNull?
    let orderNo, currUser, usgRemark, hospitalID: JSONNull?
    let mrp, noOfStrip, finalAmount, stripCost: JSONNull?
    let discountAmount, discountPer, gstAmount, gstPer: JSONNull?
    let netCost, balance, pharmacyName: JSONNull?
    let pharmacyDtlsSClist: [PharmacyDtlsSClist]

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
struct PharmacyDtlsSClist: Codable {
    let docID, docType, docDate, medicineID: String
    let brandID, brandName, genericID, genericName: String
    let doseID, dose, medType: String
    let type, unitID: JSONNull?
    let unit: String
    let route, unitText: JSONNull?
    let package: String
    let marketingComp, manufactComp, frequency, duration: JSONNull?
    let remarks, noOfDays, orderNo, currUser: JSONNull?
    let usgRemark, hospitalID: JSONNull?
    let mrp, noOfStrip, finalAmount, stripCost: String
    let discountAmount, discountPer, gstAmount, gstPer: String
    let netCost: JSONNull?
    let isPay, balance: String
    let pharamcyMasterID, pharmacyName: JSONNull?
    let isPrescription, prescriptionStatus, manufactureID, manufactureCompany: String
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
