//
//  AddressDetailsVC.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

class AddressDetailsVC: UIViewController, XIBed {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var dataValue : [[String: String?]] = []
    var addressSelection = false
    var selectedvalue = 0
    var pincode = ""
    var labInvestigation = ""
    var docId = ""
    var docType = ""
    var presciptionID = ""
    var isMedicine = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        setupTableCell()
        bottomConstraint.constant = (addressSelection) ? 60 : 0
        cartBtn.setTitle("", for: .normal)
        apiCall()
    }
    
    /// TableViewCell Setup
    private func setupTableCell(){
        tableView.register(UINib(nibName: "AddNewAddressCell", bundle: nil), forCellReuseIdentifier: "AddNewAddressCell")
        tableView.register(UINib(nibName: "AddressDetailsCell", bundle: nil), forCellReuseIdentifier: "AddressDetailsCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
    }
    
    @IBAction func cartBtn(_ sender: UIButton) {
        let vc = CartDetails.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func proceedAction(_ sender: Any) {
        let vc = LabDetailsVC.instantiate()
        vc.labInvestigation = labInvestigation
        vc.pincode = pincode
        vc.docType = docType
        vc.docId = docId
        vc.presciptionID = presciptionID
        vc.isMedicine = isMedicine
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension AddressDetailsVC{
    
    //MARK: - API CALL
    func apiCall()  {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.addressPatient(patientID: patientID)) { [weak self](data: AddressList?, error) in
            self?.dataValue = data!
            self?.tableView.reloadData()
            // print(patientIDval)
        }
    }
}
typealias AddressList = [[String: String?]]

extension AddressDetailsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 70
        }else{
            return UITableView.automaticDimension
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return dataValue.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewAddressCell", for: indexPath)as! AddNewAddressCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressDetailsCell", for: indexPath)as! AddressDetailsCell
            cell.flatNoLbl.text = dataValue[indexPath.row]["Flatno"] as? String ?? ""
            cell.buildingLbl.text = dataValue[indexPath.row]["Bldg"] as? String ?? ""
            cell.laneLbl.text = dataValue[indexPath.row]["Road"] as? String ?? ""
            cell.nearByLbl.text = dataValue[indexPath.row]["Nearby"] as? String ?? ""
            cell.areaLbl.text = dataValue[indexPath.row]["Area"] as? String ?? ""
            cell.countryLbl.text = dataValue[indexPath.row]["Country"] as? String ?? ""
            cell.stateLbl.text = dataValue[indexPath.row]["State"] as? String ?? ""
            cell.districtLbl.text = dataValue[indexPath.row]["District"] as? String ?? ""
            cell.talukaLbl.text = dataValue[indexPath.row]["Taluka"] as? String ?? ""
            cell.pinCodeLbl.text = dataValue[indexPath.row]["Pincode"] as? String ?? ""
            cell.deliveryTypeLbl.text = dataValue[indexPath.row]["AddressType"] as? String ?? ""
            cell.delegate = self
            if (dataValue[indexPath.row]["AddressType"] as? String ?? "") == "Default" {
                cell.deleteBtn.isHidden = true
            } else {
                cell.deleteBtn.isHidden = false
            }
            cell.editBtn.tag = Int(dataValue[indexPath.row]["PatientAddressId"] as? String ?? "") ?? 0
            cell.deleteBtn.tag = indexPath.row
            cell.checkBoxBtn.tag = Int(dataValue[indexPath.row]["PatientAddressId"] as? String ?? "") ?? 0
            if selectedvalue == Int(dataValue[indexPath.row]["PatientAddressId"] as? String ?? "") ?? 0 {
                cell.selectionImage.image = UIImage(named: "checkedcircle");
                pincode = dataValue[indexPath.row]["Pincode"] as? String ?? ""
            } else {
                cell.selectionImage.image = UIImage(named: "circle");
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = AddAddressViewController.instantiate()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
extension AddressDetailsVC: SelectAddressDelegate {
    func getId(value: Int) {
        selectedvalue = value
        if addressSelection {
            tableView.reloadData()
            bottomConstraint.constant = (addressSelection ) ? 60 : 0
        }
    }
    func deleteAction(value: Int) {
        
        let PatientAddressId = dataValue[value]["PatientAddressId"] as? String ?? ""
        let AddressType = dataValue[value]["AddressType"] as? String ?? ""
        let FlatNo = dataValue[value]["Flatno"] as? String ?? ""
        let Bldg = dataValue[value]["Bldg"] as? String ?? ""
        let Road = dataValue[value]["Road"] as? String ?? ""
        let Nearby = dataValue[value]["Nearby"] as? String ?? ""
        let Area = dataValue[value]["Nearby"] as? String ?? ""
        let TalukaId = dataValue[value]["Taluka"] as? String ?? ""
        let District = dataValue[value]["District"] as? String ?? ""
        let StateId = dataValue[value]["State"] as? String ?? ""
        let CountryId = dataValue[value]["Country"] as? String ?? ""
        let Pincode = dataValue[value]["Pincode"] as? String ?? ""
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.saveAddress(patientAddressID: PatientAddressId, patientID: patientID, vAddressType: AddressType, vFlatNo: FlatNo, vBldg:Bldg, vRoad: Road, vNearby: Nearby, vArea:Area, vTalukaId: TalukaId, vDistrictId: District, vStateId: StateId, vCountryId: CountryId, vPincode: Pincode,iSEdit: "D")) { [weak self] (data: [AddressStore]?, error) in
            
            self?.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func editAction(value: Int) {
        
        let vc = AddAddressViewController.instantiate()
        vc.PatientAddressId = dataValue[value]["PatientAddressId"] as? String ?? ""
        vc.AddressType = dataValue[value]["AddressType"] as? String ?? ""
        vc.FlatNo = dataValue[value]["Flatno"] as? String ?? ""
        vc.Bldg = dataValue[value]["Bldg"] as? String ?? ""
        vc.Road = dataValue[value]["Road"] as? String ?? ""
        vc.Nearby = dataValue[value]["Nearby"] as? String ?? ""
        vc.Area = dataValue[value]["Nearby"] as? String ?? ""
        vc.TalukaId = dataValue[value]["Taluka"] as? String ?? ""
        vc.District = dataValue[value]["District"] as? String ?? ""
        vc.StateId = dataValue[value]["State"] as? String ?? ""
        vc.CountryId = dataValue[value]["Country"] as? String ?? ""
        vc.Pincode = dataValue[value]["Pincode"] as? String ?? ""
        vc.selected = "\(value)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
