//
//  LabTestReceiptVc.swift
//  HealthCard
//
//  Created by Dhairya on 30/04/22.
//

import UIKit

typealias labReceiptData = [[String: String?]]


class LabTestReceiptVc: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataValue : [[String: String?]] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        ApiCall()
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setup(){
        tableView.register(UINib(nibName: "prescriptionDetailsCell", bundle: nil), forCellReuseIdentifier: "prescriptionDetailsCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
    }

}


extension LabTestReceiptVc: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prescriptionDetailsCell", for: indexPath)as! prescriptionDetailsCell
        cell.planningLbl.text = dataValue[indexPath.row]["DocType"] as? String ?? ""
        var reportname = dataValue[indexPath.row]["ReportLink"] as? String ?? ""
        reportname = reportname.replacingOccurrences(of: "https://Healthcard.acssel.com/Uploads/Pathology/", with: "")
        cell.pdfLbl.text = reportname
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string:  dataValue[indexPath.row]["ReportLink"] as? String ?? "") else {
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
extension LabTestReceiptVc{
    
    func ApiCall(){
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.LabTestReceipt(patientId: patientID)){ [weak self](data: labReceiptData?, error) in
            
            self?.dataValue = data!
            self?.tableView.reloadData()
        
    }
        
    }
}
