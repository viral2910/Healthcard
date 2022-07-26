//
//  BookLabTest.swift
//  HealthCard
//
//  Created by Viral on 26/04/22.
//

import UIKit
import DropDown

class BookLabTest: UIViewController{
    
    weak var pushDelegate: PushViewControllerDelegate?
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var BtnLineRef: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tvHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchTvHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTableViewOuterView: UIView!
    
    private lazy var searchTableViewManager = { LabTestTableViewManager(tableVIew: searchTableView, tableViewHeight: searchTvHeightConstraint) }()
    
    var selectedDocID : [Int] = []
    var LabInvestigationID : [Int] = []
    var docTypeList : [String] = []
    var storyData : [LabTest] = []
    let searchDropDown = DropDown()
    var searchDataArr: [LabTestDtlslist] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        tableview.dataSource = self
        tableview.delegate = self
        BtnLineRef.layer.borderColor = UIColor.init(hexString: "007AB8").cgColor
        BtnLineRef.layer.borderWidth = 2
        tableview.register(UINib(nibName: "BookLabTestCell", bundle: nil), forCellReuseIdentifier: "BookLabTestCell")
        searchTF.addTarget(self, action: #selector(self.textFieldValueChanged(_:)), for: UIControl.Event.editingChanged)
        self.searchDropDown.anchorView = self.BtnLineRef
        self.searchDropDown.width = BtnLineRef.bounds.width
        self.searchDropDown.bottomOffset = CGPoint(x: 0, y:(self.searchDropDown.anchorView?.plainView.bounds.height)!)
        searchTableViewManager.removeDelegate = self

        if self.searchDataArr.count != 0 {
            self.searchTableViewOuterView.isHidden = false
        }
        
        self.searchTableViewManager.start(data: self.searchDataArr)
        
    }
    @objc func textFieldValueChanged(_ textField: UITextField)
    {
        labTestSeachApi(searchVal: textField.text ?? "")
    }
    override func viewWillAppear(_ animated: Bool) {
        ApiCall()
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cartAction(_ sender: Any) {
        let vc = CartDetails.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func searchBtnAction(_ sender: Any) {
        
    }
    @IBAction func proceedBtnAction(_ sender: Any) {
        proceedApiCall()
    }
    
    @IBAction func savePharmacyAction(_ sender: UIButton) {
        let medicineId = searchDataArr.compactMap {String($0.labTestID ?? 0) }.joined(separator: ",")
        saveLabApiCall(LabId: medicineId)
    }
}

extension BookLabTest: LabTestSearchDelegate {
    func removeLabTestIndex(index: Int) {
        self.searchDataArr.remove(at: index)
        self.searchTableViewManager.start(data: searchDataArr)
        
        if searchDataArr.count == 0 {
            self.searchTableViewOuterView.isHidden = true
        }
    }
    
    
}


extension BookLabTest {
    
        func saveLabApiCall(LabId: String) {
            struct demo: Codable { }
            let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
            print(LabId)
            NetWorker.shared.callAPIService(type: APIV2.saveLabTestsTest(patientID: patientID, GenInvest: LabId)) { [weak self](data: demo?, error) in
                self?.searchDataArr = []
                    self!.searchTableViewManager.start(data: [])
                    self!.searchTableViewOuterView.isHidden = true
                self!.ApiCall()
            }
        }
    func ApiCall() {
        struct demo: Codable { }
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.PatientLabTestAdviceDetails(patientId: patientID)) { [weak self](data: Welcomea?, error) in
            self?.storyData = data!
            self?.tableview.reloadData()
        }
    }
    func labTestSeachApi(searchVal: String) {
        
        NetWorker.shared.callAPIService(type: APIV2.labTestSearch(searchVal: searchVal)) { [weak self](data: LabTestSearchDataResponse?, error) in
            guard self == self else { return }
            var medicineNameArr: [String] = []
            guard let dataArr = data else { return }
            for medicineName in dataArr {
                medicineNameArr.append(medicineName.labTestText ?? "")
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
    //MARK: - API CALL
    func proceedApiCall() {
        
        if LabInvestigationID.count > 0 {
            let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
            NetWorker.shared.callAPIService(type: APIV2.myCartList(patientID: patientID)) { [weak self](data: [cartDetails]?, error) in
                if data?.count ?? 0 > 0 {
                    if data?[0].cartDtlslist.count ?? 0 > 0 {
                        let vc = LabDetailsVC.instantiate()
                        vc.pincode = "\(data?[0].cartDtlslist[0].deliveryPincode ?? 0)"
                        vc.docId = (self?.LabInvestigationID.map{String($0)})?.joined(separator: ",") ?? ""
                        vc.labInvestigation = (self?.selectedDocID.map{String($0)})?.joined(separator: ",") ?? ""
                        vc.docType = self?.docTypeList.joined(separator: ",") ?? ""
                        self?.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        let vc = AddressDetailsVC.instantiate()
                        vc.addressSelection = true
                        vc.docId = (self?.LabInvestigationID.map{String($0)})?.joined(separator: ",") ?? ""
                        vc.labInvestigation = (self?.selectedDocID.map{String($0)})?.joined(separator: ",") ?? ""
                        vc.docType = self?.docTypeList.joined(separator: ",") ?? ""
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    let vc = AddressDetailsVC.instantiate()
                    vc.addressSelection = true
                    vc.docId = (self?.LabInvestigationID.map{String($0)})?.joined(separator: ",") ?? ""
                    vc.labInvestigation = (self?.selectedDocID.map{String($0)})?.joined(separator: ",") ?? ""
                    vc.docType = self?.docTypeList.joined(separator: ",") ?? ""
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        } else
        {
            AppManager.shared.showAlert(title: "Error", msg: "please Select One lab test", vc: self)
        }
    }
}

extension BookLabTest : UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "BookLabTestCell") as! BookLabTestCell
        cell.labListData = storyData[indexPath.row].labTestDtlslist
        cell.tableviewHeight.constant = CGFloat(storyData[indexPath.row].labTestDtlslist.count * 75)
        cell.dateLabel.text = storyData[indexPath.row].docDate
        cell.consDrLabel.text = storyData[indexPath.row].consultingDoctor
        cell.delegate = self
        cell.tableview.reloadData()
        cell.selectedID = selectedDocID
        cell.LabID = LabInvestigationID
        cell.LabDocType = docTypeList
        cell.selectionStyle = .none
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
extension BookLabTest : BookLabDelegate {
    func getTestId(DocId: Int,LabInvest:Int,docType:String,indexPathRow:Int) {
        
        if selectedDocID.contains(DocId) && LabInvestigationID.contains(LabInvest) {
            if let index = LabInvestigationID.firstIndex(of: LabInvest) {
                selectedDocID.remove(at: index)
                LabInvestigationID.remove(at: index)
                docTypeList.remove(at: index)
            }
        } else {
            selectedDocID.append(DocId)
            LabInvestigationID.append(LabInvest)
            docTypeList.append(docType)
        }
        if selectedDocID.count > 0 {
            bottomConstraint.constant = 0
        } else {
            bottomConstraint.constant = -5
        }
        tableview.reloadRows(at: [IndexPath(row: indexPathRow, section: 0)], with: .none)
    }
    
    
    
    
}
struct LabTest: Codable {
    let patientName, uhid, opdno, consultingDoctor: String
    let docDate: String
    let labName, labTestID, testCode, labTestText: JSONNull?
    let labTestDtlslist: [LabTestDtlslist]
    
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
struct LabTestDtlslist: Codable {
    let docID, docType, docDate: String?
    let id: Int?
    let testCode: String?
    let labTestID: Int?
    let labTestText: String?
    let mrp, discountPer, discountAmt, charges: Int?
    let labMasterID, labName: String?
    let collectionIn, sampleDetails, method: String?
    let labTestImageURL: String?
    
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
typealias Welcomea = [LabTest]

struct CartCount: Codable {
    let cartID, patientID, patientAddressID, docID: JSONNull?
    let docType, sellerMasterID, sellerName, sellerType: JSONNull?
    let productID, productName, qty, mrp: JSONNull?
    let discountPer, discountAmt, gstAmt, gstPer: Int
    let pricePerUnit, totalAmount: Int
    let deliveryPincode: JSONNull?
    let cartNoOfProducts: String
    let imageURL: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case cartID = "CartId"
        case patientID = "PatientId"
        case patientAddressID = "PatientAddressId"
        case docID = "DocId"
        case docType = "DocType"
        case sellerMasterID = "SellerMasterId"
        case sellerName = "SellerName"
        case sellerType = "SellerType"
        case productID = "ProductId"
        case productName = "ProductName"
        case qty = "Qty"
        case mrp = "MRP"
        case discountPer = "DiscountPer"
        case discountAmt = "DiscountAmt"
        case gstAmt = "GSTAmt"
        case gstPer = "GSTPer"
        case pricePerUnit = "PricePerUnit"
        case totalAmount = "TotalAmount"
        case deliveryPincode = "DeliveryPincode"
        case cartNoOfProducts = "CartNoOfProducts"
        case imageURL = "ImageUrl"
    }
}
// MARK: - LabTestSearchDataResponseElement
struct LabTestSearchDataResponseElement: Codable {
    let docID, docType, docDate: JSONNull?
    let id: Int
    let testCode: JSONNull?
    let labTestID: Int
    let labTestText: String
    let mrp, discountPer, discountAmt, charges: Int
    let labMasterID, labName: JSONNull?
    let collectionIn, sampleDetails, method: String
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

typealias LabTestSearchDataResponse = [LabTestDtlslist]
