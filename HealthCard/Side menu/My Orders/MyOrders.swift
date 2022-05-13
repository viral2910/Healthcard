//
//  MyOrders.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

class MyOrders: UIViewController , XIBed{

    @IBOutlet weak var filterBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        apiCall()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cartBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {
        
    }
}

extension MyOrders{

    //MARK: - API CALL
    func apiCall()  {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.myOrderList(patientID: patientID)) { [weak self](data: [Consultation]?, error) in
//                self?.dataValue = data!
//                self?.tableView.reloadData()
               // print(patientIDval)
        }
    }
}
