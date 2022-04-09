//
//  SingInVC.swift
//  HealthCard
//
//  Created by Viral on 30/03/22.
//

import UIKit

class SingInVC: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileTextField.delegate = self
        passwordTextField.delegate = self
    }
    @IBAction func loginAction(_ sender: Any) {
        guard let mobile =  mobileTextField.text,mobile != "" else {
            AppManager.shared.showAlert(title: "Error", msg: "please Enter Mobile Number", vc: self)
            return;
        }
        guard let mobile =  passwordTextField.text,mobile != "" else {
            AppManager.shared.showAlert(title: "Error", msg: "please Enter Password", vc: self)
            return;
        }
        
        let mainStoryBoard = UIStoryboard(name: "Home", bundle: nil)
        let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        UIApplication.shared.keyWindow?.rootViewController = redViewController
        
    }
    @IBAction func forgotpassswordAction(_ sender: Any) {
        guard let mobile =  mobileTextField.text,mobile != "" else {
            AppManager.shared.showAlert(title: "Error", msg: "please Enter Mobile Number", vc: self)
            return;
        }
        
        let forgotpasswordvc =  UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        forgotpasswordvc.mobilenumber = mobile
        self.navigationController?.pushViewController(forgotpasswordvc, animated: true)
    }
    @IBAction func loginOTPAction(_ sender: Any) {
        guard let mobile =  mobileTextField.text,mobile != "" else {
            AppManager.shared.showAlert(title: "Error", msg: "please Enter Mobile Number", vc: self)
            return;
        }
        
        let otpvc =  UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
        otpvc.mobilenumber = mobile
        self.navigationController?.pushViewController(otpvc, animated: true)
    }
    
    @IBAction func singupAction(_ sender: Any) {
        let singup = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "SingUpVC") as! SingUpVC
        self.navigationController?.pushViewController(singup, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
}
