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
        
        
        loginApiCall()
//        let mainStoryBoard = UIStoryboard(name: "Home", bundle: nil)
//        let redViewController = ConsultationMainViewController.instantiate()//mainStoryBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//        let navigationController = UINavigationController(rootViewController: redViewController)

        UIApplication.shared.keyWindow?.rootViewController = navigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let homeVC = CustomTabBarViewController.instantiate()        //Below's navigationController is useful if u want NavigationController
        let navigationController = UINavigationController(rootViewController: homeVC)
        appDelegate.window!.rootViewController = navigationController

        
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
    
    func loginApiCall(){
        struct demo : Codable{
            
        }
        NetWorker.shared.callAPIService(type: APIV2.PatientLogin(mobileNo: "8369939171", password: "123", firebaseToken: "cR98J4yMTt6b2f8sd2n-35:APA91bGLVv-1o4hiowbK3cHnCS_Z48x4bt6_pekB0VpVvB1syGRjX95bHzqIpUe6MNiENw93x3gFNntrFrKvOcXLXQgR_7PJu-P0sAgaKE0F127IAZT87FGNawU2Xt4ZMpwIqDXAR-fA")) { [weak self] (data:Welcome?, error) in
            print(data?.soapEnvelope.soapBody.patientLoginResponse)
        }
        
    }
    
}
// MARK: - Welcome
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

