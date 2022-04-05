//
//  ForgotPasswordVC.swift
//  HealthCard
//
//  Created by Viral on 02/04/22.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var mobilenumberTextfield: UITextField!
    @IBOutlet weak var otpTextfield: UITextField!
    var mobilenumber = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        mobilenumberTextfield.text = mobilenumber
        // Do any additional setup after loading the view.
    }
    @IBAction func sumbitAction(_ sender: Any) {
    }
    @IBAction func resendAction(_ sender: Any) {
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
