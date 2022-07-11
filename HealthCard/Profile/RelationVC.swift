//
//  RelationVC.swift
//  HealthCard
//
//  Created by Viral on 11/04/22.
//

import UIKit

class RelationVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var dataValue = [patientRelation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCall()
        
        tableview.register(UINib(nibName: "RelationshipTableViewCell", bundle: nil), forCellReuseIdentifier: "RelationshipTableViewCell")
        // Do any additional setup after loading the view.
    }
}

extension RelationVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "RelationshipTableViewCell") as! RelationshipTableViewCell
        cell.patientNoLabel.text = dataValue[0].relativePatientName
        cell.relationLabel.text = dataValue[0].relationName
        return cell
    }
}

extension RelationVC{

    //MARK: - API CALL
    func apiCall()  {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.patientRelation(patientID: patientID)) { [weak self](data: [patientRelation]?, error) in
                self?.dataValue = data!
                self?.tableview.reloadData()
            
        }
    }
}
struct patientRelation: Codable {
    let patientRelationID: Int
    let patientID: JSONNull?
    let relativePatientID: Int
    let relativePatientName, relationID, relationName: String
    let currUser, isActive, isEdit: JSONNull?

    enum CodingKeys: String, CodingKey {
        case patientRelationID = "PatientRelationId"
        case patientID = "PatientId"
        case relativePatientID = "RelativePatientId"
        case relativePatientName = "RelativePatientName"
        case relationID = "RelationId"
        case relationName = "RelationName"
        case currUser = "CurrUser"
        case isActive = "IsActive"
        case isEdit = "IsEdit"
    }
}
