//
//  AddressDetailsVC.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

class AddressDetailsVC: UIViewController, XIBed {
    
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var dataValue : [[String: String?]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableCell()
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
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
            return cell
        }
    }
    
}
