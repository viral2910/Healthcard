//
//  LabTestReceiptVc.swift
//  HealthCard
//
//  Created by Dhairya on 30/04/22.
//

import UIKit

//typealias labReceiptData = [[String: String?]]

struct labReceiptData: Codable{
    var DocID: String
    var DocType: String
    var PatientId: String
    var DocGroup: String
    var TranDate: String
    var OrgDate: String
    var SrNo: String
    var ReportLink: String
}

class LabTestReceiptVc: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataValue = [labReceiptData]()
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
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
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prescriptionDetailsCell", for: indexPath)as! prescriptionDetailsCell
        return cell
    }
}

//MARK: - Api Call
extension LabTestReceiptVc{
    
    func ApiCall(){
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.LabTestReceipt(patientId: patientID)){ [weak self](data: [labReceiptData]?, error) in
            
            self?.dataValue = data!
            print(self?.dataValue.first?.DocType)
            self?.tableView.reloadData()
        
    }
        
    }
}
