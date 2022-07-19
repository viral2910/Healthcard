//
//  SingInVC.swift
//  HealthCard
//
//  Created by Viral on 30/03/22.
//

import UIKit

class SingInVC: UIViewController ,UITextFieldDelegate{// , XIBed, PushViewControllerDelegate {
    
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordVisible: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    var isPassword = true
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileTextField.delegate = self
        passwordTextField.delegate = self
    }
    @IBAction func loginAction(_ sender: Any) {
        guard let mobile =  mobileTextField.text,mobile.count == 10 else {
            AppManager.shared.showAlert(title: "Error", msg: "please Enter Mobile Number", vc: self)
            return;
        }
        guard let password =  passwordTextField.text,password != "" else {
            AppManager.shared.showAlert(title: "Error", msg: "please Enter Password", vc: self)
            return;
        }
        loginApiCall(mobile: mobile, password: password)
    }
    @IBAction func forgotpassswordAction(_ sender: Any) {
        guard let mobile =  mobileTextField.text,mobile.count == 10 else {
            AppManager.shared.showAlert(title: "Error", msg: "please Enter Mobile Number", vc: self)
            return;
        }
        
        forgotPasswordOtpGenerate(mobileNo: mobileTextField.text ?? "", subject: "Forgot Password".replacingOccurrences(of: " ", with: "%20"))

    }
    @IBAction func loginOTPAction(_ sender: Any) {
        guard let mobile =  mobileTextField.text,mobile.count == 10 else {
            AppManager.shared.showAlert(title: "Error", msg: "please Enter Mobile Number", vc: self)
            return;
        }
        
        LoginOtpGenerate(mobileNo: mobileTextField.text ?? "", subject: "Login".replacingOccurrences(of: " ", with: "%20"))

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
    
    func loginApiCall(mobile:String , password: String){
        struct demo : Codable{
            
        }
        NetWorker.shared.callAPIService(type: APIV2.PatientLogin(mobileNo: mobile, password: password, firebaseToken: "")) { (data:Welcome?, error) in
            let message = data?.soapEnvelope.soapBody.patientLoginResponse.patientLoginResult.user.message ?? ""
            if message.lowercased().contains("sucess") {
                let patientid = data?.soapEnvelope.soapBody.patientLoginResponse.patientLoginResult.user.patientID
                UserDefaults.standard.set(true, forKey: "isLogin")
                UserDefaults.standard.set(patientid, forKey: "patientID")
                UIApplication.shared.keyWindow?.rootViewController = self.navigationController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let homeVC = CustomTabBarViewController.instantiate()
                let navigationController = UINavigationController(rootViewController: homeVC)
                appDelegate.window!.rootViewController = navigationController
            } else {
                UserDefaults.standard.set(false, forKey: "isLogin")
                UserDefaults.standard.set(0, forKey: "patientID")
                AppManager.shared.showAlert(title: "Error", msg: message, vc: self)
            }
        }
        
    }
    @available(iOS 13.0, *)
    @IBAction func passwordVisibleAction(_ sender: UIButton) {
        if isPassword {
            isPassword = !isPassword
            passwordTextField.isSecureTextEntry = false
            passwordVisible.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            isPassword = !isPassword
            passwordTextField.isSecureTextEntry = true
            passwordVisible.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    
    func forgotPasswordOtpGenerate(mobileNo: String, subject: String) {
        
        NetWorker.shared.callAPIService(type: APIV2.patientForgotPasswordOTPGenerate(mobileNo: mobileNo, subject: subject)) { (data: ForgotPasswordOtpGenerateDataResponse?, error) in
            guard self == self else { return }
            let status = data?[0].status ?? ""
            if status == "1" {
            let forgotpasswordvc =  UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
                forgotpasswordvc.mobilenumber = self.mobileTextField.text ?? ""
            self.navigationController?.pushViewController(forgotpasswordvc, animated: true)
            }
        }
        
    }
    
    func LoginOtpGenerate(mobileNo: String, subject: String) {
        
        NetWorker.shared.callAPIService(type: APIV2.patientForgotPasswordOTPGenerate(mobileNo: mobileNo, subject: subject)) { (data: ForgotPasswordOtpGenerateDataResponse?, error) in
            guard self == self else { return }
            let status = data?[0].status ?? ""
            if status == "1" {
                let otpvc =  UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                otpvc.mobilenumber = self.mobileTextField.text ?? ""
                self.navigationController?.pushViewController(otpvc, animated: true)

            }
        }
        
    }
}
//lcome
struct Welcome: Codable {
    let soapEnvelope: SoapEnvelopeval

    enum CodingKeys: String, CodingKey {
        case soapEnvelope = "soap:Envelope"
    }
}

// MARK: - SoapEnvelope
struct SoapEnvelopeval: Codable {
    let xmlnsXSD, xmlnsXsi, xmlnsSoap: String
    let soapBody: SoapBodyval

    enum CodingKeys: String, CodingKey {
        case xmlnsXSD = "_xmlns:xsd"
        case xmlnsXsi = "_xmlns:xsi"
        case xmlnsSoap = "_xmlns:soap"
        case soapBody = "soap:Body"
    }
}

// MARK: - SoapBody
struct SoapBodyval: Codable {
    let patientLoginResponse: PatientLoginResponse

    enum CodingKeys: String, CodingKey {
        case patientLoginResponse = "PatientLoginResponse"
    }
}

// MARK: - PatientLoginResponse
struct PatientLoginResponse: Codable {
    let xmlns: String
    let patientLoginResult: PatientLoginResult

    enum CodingKeys: String, CodingKey {
        case xmlns = "_xmlns"
        case patientLoginResult = "PatientLoginResult"
    }
}

// MARK: - PatientLoginResult
struct PatientLoginResult: Codable {
    let user: User

    enum CodingKeys: String, CodingKey {
        case user = "User"
    }
}

// MARK: - User
struct User: Codable {
    let message, status, patientID: String

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case status = "Status"
        case patientID = "PatientId"
    }
}

// MARK: - ForgotPasswordOtpGenerateDataResponseElement
struct ForgotPasswordOtpGenerateDataResponseElement: Codable {
    let message, status: String?


    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case status = "Status"
        
    }
}

typealias ForgotPasswordOtpGenerateDataResponse = [ForgotPasswordOtpGenerateDataResponseElement]
