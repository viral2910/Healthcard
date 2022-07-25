//
//  PharmacyReceiptVC.swift
//  HealthCard
//
//  Created by Dhairya on 30/04/22.
//

import UIKit

typealias pharmacyReceipt = [[String: String?]]
class PharmacyReceiptVC: UIViewController {
    
    var dataValue : [[String: String?]] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "prescriptionDetailsCell", bundle: nil), forCellReuseIdentifier: "prescriptionDetailsCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        ApiCall()
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension PharmacyReceiptVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValue.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prescriptionDetailsCell", for: indexPath)as! prescriptionDetailsCell
        
        cell.planningLbl.text = "\(dataValue[indexPath.row]["TranDate"] as? String ?? "") \(dataValue[indexPath.row]["DocType"] as? String ?? "")"
//        cell.planningLbl.text = dataValue[indexPath.row]["DocType"] as? String ?? ""
        var reportname = dataValue[indexPath.row]["ReportLink"] as? String ?? ""
        reportname = reportname.replacingOccurrences(of: "https://Healthcard.acssel.com/Uploads/Pharmacy_Upload/", with: "")
        cell.pdfLbl.text = reportname
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var stringvalue = dataValue[indexPath.row]["ReportLink"] as? String ?? ""
        stringvalue = stringvalue.replacingOccurrences(of: " ", with: "%20")
         
        
        guard let url = URL(string: stringvalue) else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

//MARK: - Api Call
extension PharmacyReceiptVC{
    
    func ApiCall(){
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.pharmacyReceiptList(patientID: patientID)){ [weak self](data: pharmacyReceipt?, error) in
            
            self?.dataValue = data!
            self?.tableView.reloadData()
        
    }
        
    }
}
