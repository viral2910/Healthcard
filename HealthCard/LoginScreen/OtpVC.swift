//
//  OtpVC.swift
//  HealthCard
//
//  Created by Viral on 02/04/22.
//

import UIKit

class OtpVC: UIViewController {

    @IBOutlet weak var otpTextfield: UITextField!
    @IBOutlet weak var mobilenumberTextfield: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var sendBtn: UIButton!
    var mobilenumber = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        mobilenumberTextfield.text = mobilenumber
    }
    @IBAction func sendAction(_ sender: Any) {
    }
    @IBAction func loginAction(_ sender: Any) {
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
