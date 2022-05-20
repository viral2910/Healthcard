//
//  PrescriptionListVC.swift
//  HealthCard
//
//  Created by Viral on 19/05/22.
//

import UIKit

class PrescriptionListVC: UIViewController,XIBed {
    
    var selectedvalue = 0
    var pincode = ""
    var labInvestigation = ""
    var docId = ""
    var docType = ""
    var addressReq = false
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

