//
//  MedicineVC.swift
//  HealthCard
//
//  Created by Viral on 07/05/22.
//

import UIKit
import DropDown

class MedicineVC: UIViewController {
    
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var tvHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var BtnLineRef: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchTvHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTableViewOuterView: UIView!

    private lazy var searchTableViewManager = { MedicineSearchTableViewManager(tableVIew: searchTableView, tableViewHeight: searchTvHeightConstraint) }()

    var selectedDocID : [Int] = []
    var LabInvestigationID : [Int] = []
    var docTypeList : [String] = []
    var prescriptionList : [String] = []
    var storyData : [pharmacyList] = []
    let searchDropDown = DropDown()
    var searchDataArr: [PharmacyDtlsSClist] = []
    
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
        searchTF.addTarget(self, action: #selector(self.textFieldValueChanged(_:)), for: UIControl.Event.editingChanged)
        self.searchDropDown.anchorView = self.BtnLineRef
        self.searchDropDown.width = BtnLineRef.bounds.width
        self.searchDropDown.bottomOffset = CGPoint(x: 0, y:(self.searchDropDown.anchorView?.plainView.bounds.height)!)
        self.tableview.keyboardDismissMode = .onDrag
        // Do any additional setup after loading the view.
        
        searchTableViewManager.removeDelegate = self
        
    }
    @objc func textFieldValueChanged(_ textField: UITextField)
    {
        medicineSeachApi(searchVal: textField.text ?? "")
    }
    @IBAction func backVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchBtnAction(_ sender: Any) {
    }
    @IBAction func proceedBtnAction(_ sender: Any) {
        if selectedDocID.count > 0 {
            proceedApiCall()
        } else {
            AppManager.shared.showAlert(title: "Error", msg: "Please Select atleast one medicine", vc: self)
        }
            
    }
    @IBAction func cartAction(_ sender: Any) {
        let vc = CartDetails.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func savePharmacyAction(_ sender: UIButton) {
        let medicineId = searchDataArr.map({$0.medicineID ?? ""}).joined(separator: ",")
        let brandId = searchDataArr.map({$0.brandID ?? ""}).joined(separator: ",")
        let genericId = searchDataArr.map({$0.genericID ?? ""}).joined(separator: ",")
        let doseId = searchDataArr.map({$0.doseID ?? ""}).joined(separator: ",")

        savePharmacyApiCall(medicineId: medicineId, brandId: brandId, genericId: genericId, doseId: doseId)
    }
    
}

extension MedicineVC: medicineSearchDelegate {
    func removeMedicineIndex(index: Int) {
        self.searchDataArr.remove(at: index)
        self.searchTableViewManager.start(data: searchDataArr)
        
        if searchDataArr.count == 0 {
            self.searchTableViewOuterView.isHidden = true
        }
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
        func savePharmacyApiCall(medicineId: String, brandId: String, genericId: String, doseId: String) {
            struct demo: Codable { }
            let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
            NetWorker.shared.callAPIService(type: APIV2.savePharmacyMedicine(patientID: patientID, medicineId: medicineId, brandId: brandId, genericId: genericId, doseId: doseId)) { [weak self](data: demo?, error) in
                
                self!.searchTableViewManager.start(data: [])
                self!.searchTableViewOuterView.isHidden = true
                self!.ApiCall()
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
                    vc.pincode = ""
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
    func medicineSeachApi(searchVal: String) {
            
            NetWorker.shared.callAPIService(type: APIV2.medicineAndEssential(searchVal: searchVal)) { [weak self](data: MedicineSearchDataResponse?, error) in
                guard self == self else { return }
                
                var medicineNameArr: [String] = []
                guard let dataArr = data else { return }
                for medicineName in dataArr {
                    medicineNameArr.append(medicineName.brandName ?? "")
                }
                self!.searchDropDown.dataSource = medicineNameArr
                self!.searchDropDown.show()
                self!.searchDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    self!.searchTF.text = item
                    
                    self!.searchDataArr.append(dataArr[index])
                    self!.searchTF.text = ""
                    if self!.searchDataArr.count != 0 {
                        self!.searchTableViewOuterView.isHidden = false
                    }
                    
                    self!.searchTableViewManager.start(data: self!.searchDataArr)
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
            cell.tableviewHeight.constant = CGFloat(170 * storyData[indexPath.row].pharmacyDtlsSClist.count)
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.layoutIfNeeded()

        self.tvHeightConstraint.constant = tableView.contentSize.height

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
    let docID, docType, docDate, medicineID: String?
    let brandID, brandName, genericID, genericName: String?
    let doseID, dose, medType: String?
    let type, unitID: String?
    let unit: String?
    let route, unitText: String?
    let package: String?
    let marketingComp, manufactComp, frequency, duration: String?
    let remarks, noOfDays, orderNo, currUser: String?
    let usgRemark, hospitalID: String?
    let mrp, noOfStrip, finalAmount, stripCost: String?
    let discountAmount, discountPer, gstAmount, gstPer: String?
    let netCost: String?
    let isPay, balance: String?
    let pharamcyMasterID, pharmacyName: String?
    let isPrescription, prescriptionStatus, manufactureID, manufactureCompany: String?
    let drugImageURL: String?
    
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
// MARK: - MedicineSearchDataResponseElement
struct MedicineSearchDataResponseElement: Codable {
    let docID, docType, docDate: JSONNull?
    let medicineID, brandID, brandName, genericID: String
    let genericName, doseID, dose, medType: String
    let type: JSONNull?
    let unitID, unit: String
    let route, unitText: JSONNull?
    let package: String
    let marketingComp, manufactComp, frequency, duration: JSONNull?
    let remarks, noOfDays, orderNo, currUser: JSONNull?
    let usgRemark, hospitalID, mrp, noOfStrip: JSONNull?
    let finalAmount, stripCost, discountAmount, discountPer: JSONNull?
    let gstAmount, gstPer, netCost, isPay: JSONNull?
    let balance, pharamcyMasterID, pharmacyName: JSONNull?
    let isPrescription: String
    let prescriptionStatus: String
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

typealias MedicineSearchDataResponse = [PharmacyDtlsSClist]
