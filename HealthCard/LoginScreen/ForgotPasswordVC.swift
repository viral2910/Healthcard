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
        if (otpTextfield.text ?? "") != "" {
            forgotPasswordOtpAuthenticate(mobileNo: mobilenumber, subject: "Forgot Password".replacingOccurrences(of: " ", with: "%20"), otpNo: otpTextfield.text ?? "", firebaseToken: "")
        }
    }
    @IBAction func resendAction(_ sender: Any) {
        forgotPasswordOtpGenerate(mobileNo: mobilenumberTextfield.text ?? "", subject: "Forgot Password".replacingOccurrences(of: " ", with: "%20"))
        
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ForgotPasswordVC {
    
    func forgotPasswordOtpGenerate(mobileNo: String, subject: String) {
        
        NetWorker.shared.callAPIService(type: APIV2.patientForgotPasswordOTPGenerate(mobileNo: mobileNo, subject: subject)) { (data: ForgotPasswordOtpGenerateDataResponse?, error) in
            guard self == self else { return }
            
            let status = data?[0].status ?? ""
            if status == "1" {
                UIAlertController.showAlert(titleString: "OTP Resend Successfully")
            }
        }
        
    }
    
    func forgotPasswordOtpAuthenticate(mobileNo: String, subject: String, otpNo: String, firebaseToken: String) {
        
        NetWorker.shared.callAPIService(type: APIV2.patientForgotPasswordOTPAuthenticate(mobileNo: mobileNo, subject: subject, otpNo: otpNo, firebaseToken: firebaseToken)) { (data: ForgotPasswordOtpGenerateDataResponse?, error) in
            guard self == self else { return }
            
            let status = data?[0].status ?? ""
            if status == "1" {
//                UIAlertController.showAlert(titleString: data?[0].message ?? "")
                let singup = ChangePasswordVC(nibName: "ChangePasswordVC", bundle: nil)
                singup.mobileNumber = mobileNo
                self.navigationController?.pushViewController(singup, animated: true)
            }
        }
        
    }
    
    
}

struct demo: Codable { }
