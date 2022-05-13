//
//  BookLabTest.swift
//  HealthCard
//
//  Created by Viral on 26/04/22.
//

import UIKit

class BookLabTest: UIViewController{
    

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var BtnLineRef: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var selectedID : [Int] = []
    var storyData : [LabTest] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        tableview.dataSource = self
        tableview.delegate = self
        BtnLineRef.layer.borderColor = UIColor.init(hexString: "007AB8").cgColor
        BtnLineRef.layer.borderWidth = 2
        tableview.register(UINib(nibName: "BookLabTestCell", bundle: nil), forCellReuseIdentifier: "BookLabTestCell")
      

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        ApiCall()
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func searchBtnAction(_ sender: Any) {
        
    }
    @IBAction func proceedBtnAction(_ sender: Any) {
    }
}

extension BookLabTest {
    
    func ApiCall() {
        struct demo: Codable { }
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.PatientLabTestAdviceDetails(patientId: patientID)) { [weak self](data: Welcomea?, error) in
            self?.storyData = data!
            self?.tableview.reloadData()
            
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
            cell.tableviewHeight.constant = CGFloat(storyData[indexPath.row].labTestDtlslist.count * 60)
            cell.dateLabel.text = storyData[indexPath.row].docDate
            cell.consDrLabel.text = storyData[indexPath.row].consultingDoctor
            cell.delegate = self
            cell.tableview.reloadData()
            cell.selectionStyle = .none
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension BookLabTest : BookLabDelegate {
    func getTestId(value: [Int]) {
        selectedID = value
        if value.count > 0 {
            bottomConstraint.constant = 60
        } else {
            bottomConstraint.constant = -5
        }
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
    let docID, docType, docDate: String
    let id: Int
    let testCode: String
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
typealias Welcomea = [LabTest]
