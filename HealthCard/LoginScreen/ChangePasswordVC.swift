//
//  ChangePasswordVC.swift
//  HealthCard
//
//  Created by Viral on 19/07/22.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var oldpasswordTextField: UITextField!
    @IBOutlet weak var newpasswordTextField: UITextField!
    @IBOutlet weak var confirmpasswordTextField: UITextField!
    @IBOutlet weak var oldPasswordVisible: UIButton!
    @IBOutlet weak var newPasswordVisible: UIButton!
    @IBOutlet weak var confirmPasswordVisible: UIButton!
    @IBOutlet weak var procedButton: UIButton!
    var isOldPassword = false
    var isNewPassword = false
    var isConfirmPassword = false
    var mobileNumber = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oldpasswordTextField.isHidden = mobileNumber == "" ? false : true
        oldPasswordVisible.isHidden = mobileNumber == "" ? false : true
        titleLabel.text = mobileNumber == "" ?  "Change Password" : "Update Password"
        if mobileNumber == ""
        {
            procedButton.setTitle("Change Password", for: .normal)
        } else {
            
            procedButton.setTitle("Update Password", for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @available(iOS 13.0, *)
    @IBAction func oldPasswordVisibleAction(_ sender: UIButton) {
        if isOldPassword {
            isOldPassword = !isOldPassword
            oldpasswordTextField.isSecureTextEntry = false
            oldPasswordVisible.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            isOldPassword = !isOldPassword
            oldpasswordTextField.isSecureTextEntry = true
            oldPasswordVisible.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    @available(iOS 13.0, *)
    @IBAction func newPasswordVisibleAction(_ sender: UIButton) {
        if isNewPassword {
            isNewPassword = !isNewPassword
            newpasswordTextField.isSecureTextEntry = false
            newPasswordVisible.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            isNewPassword = !isNewPassword
            newpasswordTextField.isSecureTextEntry = true
            newPasswordVisible.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    @available(iOS 13.0, *)
    @IBAction func confirmPasswordVisibleAction(_ sender: UIButton) {
        if isConfirmPassword {
            isConfirmPassword = !isConfirmPassword
            confirmpasswordTextField.isSecureTextEntry = false
            confirmPasswordVisible.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            isConfirmPassword = !isConfirmPassword
            confirmpasswordTextField.isSecureTextEntry = true
            confirmPasswordVisible.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    @IBAction func procedButtonClick(_ sender: Any) {
        if mobileNumber == "" {
            guard let oldpassword =  oldpasswordTextField.text,oldpassword != "" else {
                AppManager.shared.showAlert(title: "Error", msg: "please Enter old password", vc: self)
                return;
            }
            guard let newpassword =  newpasswordTextField.text,newpassword != "" else {
                AppManager.shared.showAlert(title: "Error", msg: "please Enter New password", vc: self)
                return;
            }
            ChangePassword(oldPassowrd: oldpassword, newPassword: newpassword)
        } else {
            guard let newpassword =  newpasswordTextField.text,newpassword != "" else {
                AppManager.shared.showAlert(title: "Error", msg: "please Enter New password", vc: self)
                return;
            }
            updatePassword(mobile: Int(mobileNumber) ?? 0, newPassword: newpassword)
        }
    }
    
    func ChangePassword(oldPassowrd: String, newPassword: String) {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.changepassword(patientID: patientID, oldPassword: oldPassowrd, newPassword: newPassword)) { (data: ForgotPasswordOtpGenerateDataResponse?, error) in
            guard self == self else { return }
            let status = data?[0].status ?? ""
            if status == "1" {
                
                self.navigationController?.popViewController(animated: true)
                AppManager.shared.showAlert(title: "Success", msg: "Password Changed Successfully", vc: self)
            }
        }
        
    }
    
    func updatePassword(mobile: Int, newPassword: String) {
        NetWorker.shared.callAPIService(type: APIV2.updatepassword(mobileNumber: mobile, Password: newPassword)) { (data: ForgotPasswordOtpGenerateDataResponse?, error) in
            guard self == self else { return }
            let status = data?[0].status ?? ""
            if status == "1" {
                self.navigationController?.popViewController(animated: true)
                AppManager.shared.showAlert(title: "Success", msg: "Password Update Successfully", vc: self)
            }
        }
    }
}
