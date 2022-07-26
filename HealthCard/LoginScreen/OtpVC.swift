//
//  OtpVC.swift
//  HealthCard
//
//  Created by Viral on 02/04/22.
//

import UIKit
import SVProgressHUD

class OtpVC: UIViewController {
    @IBOutlet weak var otpsendmessage: UILabel!
    
    @IBOutlet weak var otpTextfield: UITextField!
    @IBOutlet weak var mobilenumberTextfield: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var sendBtn: UIButton!
    var titleval = 0
    var mobilenumber = ""
    var fname = ""
    var lname = ""
    var password = ""
    var confirmpassword = ""
    var pincode = ""
    var gendervalue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mobilenumberTextfield.text = mobilenumber
        loginOtpGenerate(mobileNo: mobilenumber, subject: "Login")
    }
    @IBAction func sendAction(_ sender: Any) {
        guard let mobile =  mobilenumberTextfield.text,mobile.count == 10 else {
            AppManager.shared.showAlert(title: "Error", msg: "please Enter Mobile Number", vc: self)
            return;
        }
        loginOtpGenerate(mobileNo: mobile, subject: "Login")
    }
    @IBAction func loginAction(_ sender: Any) {
        guard let mobile =  mobilenumberTextfield.text,mobile.count == 10 else {
            AppManager.shared.showAlert(title: "Error", msg: "please Enter Mobile Number", vc: self)
            return;
        }
        guard let otp =  otpTextfield.text,otp != "" else {
            AppManager.shared.showAlert(title: "Error", msg: "please Enter OTP", vc: self)
            return;
        }
        //OTPAuthenticationApiCall(mobile: mobile, otp: Int(otp) ?? 0000)
        loginOtpAuthenticate(mobileNo: mobile, subject: "Login", otpNo: otpTextfield.text ?? "", firebaseToken: "")
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func OTPAuthenticationApiCall(mobile:String , otp: Int){
        struct demo : Codable{
            
        }
        NetWorker.shared.callAPIService(type: APIV2.OTPAuthentication(mobileNo: mobile, subject: "Patient Register", otpNo: otp, firebaseToken: "")) { (data:WelcomeOtp?, error) in
            let message = data?.soapEnvelope.soapBody.otpAuthenticationResponse.otpAuthenticationResult.user.message ?? ""
            if message.lowercased().contains("sucess") {
                let patientid = data?.soapEnvelope.soapBody.otpAuthenticationResponse.otpAuthenticationResult.user.patientID
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
}

extension OtpVC {
    
    func loginOtpGenerate(mobileNo: String, subject: String) {
        
        NetWorker.shared.callAPIService(type: APIV2.patientForgotPasswordOTPGenerate(mobileNo: mobileNo, subject: subject)) { (data: ForgotPasswordOtpGenerateDataResponse?, error) in
            guard self == self else { return }
            
            let status = data?[0].status ?? ""
            if status == "1" {
                self.otpsendmessage.text = "OTP send Successfully"
            }
        }
        
    }
    
    func loginOtpAuthenticate(mobileNo: String, subject: String, otpNo: String, firebaseToken: String) {
        
        NetWorker.shared.callAPIService(type: APIV2.patientForgotPasswordOTPAuthenticate(mobileNo: mobileNo, subject: subject, otpNo: otpNo, firebaseToken: firebaseToken)) { (data: LoginOtpAuthenticatwDataResponse?, error) in
            guard self == self else { return }
            
            let status = data?[0].status ?? ""
            if status == "1" {
                
                if self.gendervalue != "" {
                    self.signUpApiCall()
                } else {
                    
                    let patientid = data?[0].patientID
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    UserDefaults.standard.set(patientid, forKey: "patientID")
                    UIApplication.shared.keyWindow?.rootViewController = self.navigationController
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let homeVC = CustomTabBarViewController.instantiate()
                    let navigationController = UINavigationController(rootViewController: homeVC)
                    appDelegate.window!.rootViewController = navigationController
                }
            } else {
                UserDefaults.standard.set(false, forKey: "isLogin")
                UserDefaults.standard.set(0, forKey: "patientID")
                
                self.otpsendmessage.text = data?[0].message ?? ""
            }
        }
        
    }
    
    func signUpApiCall(){
        struct demo : Codable{
            
        }
        
        SVProgressHUD.show()
        NetWorker.shared.callAPIService(type: APIV2.patientRegistration(titleId: titleval, firstName: fname, lastName: lname, mobileNo: mobilenumber, password: password, gender: gendervalue, pincode: pincode)) { (data:Welcomevalue?, error) in
            let message = data?.soapEnvelope.soapBody.savePatientResponse.savePatientResult.patientRegSC.message ?? ""
            
            SVProgressHUD.dismiss()
            if message.lowercased().contains("sucess") {
                
                                       let patientid = data?.soapEnvelope.soapBody.savePatientResponse.savePatientResult.patientRegSC.patientID
//                let patientid = data?.soapEnvelope.soapBody.otpAuthenticationResponse..user.patientID
                UserDefaults.standard.set(true, forKey: "isLogin")
                UserDefaults.standard.set(patientid, forKey: "patientID")
                UIApplication.shared.keyWindow?.rootViewController = self.navigationController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let homeVC = CustomTabBarViewController.instantiate()
                let navigationController = UINavigationController(rootViewController: homeVC)
                appDelegate.window!.rootViewController = navigationController
                
            } else {
//                self.registerBtnRef.isEnabled = true
                UserDefaults.standard.set(false, forKey: "isLogin")
                UserDefaults.standard.set(0, forKey: "patientID")
                AppManager.shared.showAlert(title: "Error", msg: "Mobile Number already exists", vc: self)
            }
        }
        
    }
    
}



struct WelcomeOtp: Codable {
    let soapEnvelope: SoapEnvelopeOtp
    
    enum CodingKeys: String, CodingKey {
        case soapEnvelope = "soap:Envelope"
    }
}

// MARK: - SoapEnvelope
struct SoapEnvelopeOtp: Codable {
    let xmlnsSoap, xmlnsXsi, xmlnsXSD: String
    let soapBody: SoapBodyOtp
    
    enum CodingKeys: String, CodingKey {
        case xmlnsSoap = "-xmlns:soap"
        case xmlnsXsi = "-xmlns:xsi"
        case xmlnsXSD = "-xmlns:xsd"
        case soapBody = "soap:Body"
    }
}

// MARK: - SoapBody
struct SoapBodyOtp: Codable {
    let otpAuthenticationResponse: OTPAuthenticationResponse
    
    enum CodingKeys: String, CodingKey {
        case otpAuthenticationResponse = "OTPAuthenticationResponse"
    }
}

// MARK: - OTPAuthenticationResponse
struct OTPAuthenticationResponse: Codable {
    let xmlns: String
    let otpAuthenticationResult: OTPAuthenticationResult
    
    enum CodingKeys: String, CodingKey {
        case xmlns = "-xmlns"
        case otpAuthenticationResult = "OTPAuthenticationResult"
    }
}

// MARK: - OTPAuthenticationResult
struct OTPAuthenticationResult: Codable {
    let user: UserOtp
    
    enum CodingKeys: String, CodingKey {
        case user = "User"
    }
}

// MARK: - User
struct UserOtp: Codable {
    let message, status, patientID, gender: String
    let firstName: String
    let middleName: DeliveryBoy
    let lastName: String
    let deliveryBoyID, deliveryBoy, labMasterID, labConcernPerson: DeliveryBoy
    let pharmacyID, pharmacyCoordinator: DeliveryBoy
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case status = "Status"
        case patientID = "PatientId"
        case gender = "Gender"
        case firstName = "FirstName"
        case middleName = "MiddleName"
        case lastName = "LastName"
        case deliveryBoyID = "DeliveryBoyId"
        case deliveryBoy = "DeliveryBoy"
        case labMasterID = "LabMasterId"
        case labConcernPerson = "LabConcernPerson"
        case pharmacyID = "PharmacyId"
        case pharmacyCoordinator = "PharmacyCoordinator"
    }
}

// MARK: - DeliveryBoy
struct DeliveryBoy: Codable {
    let selfClosing: String
    
    enum CodingKeys: String, CodingKey {
        case selfClosing = "-self-closing"
    }
}

// MARK: - LoginOtpAuthenticatwDataResponseElement
struct LoginOtpAuthenticatwDataResponseElement: Codable {
    let message, status, patientID, gender: String?
    let firstName, middleName, lastName: String?
    let patientName, pincode: JSONNull?
    let patientProfilePicURL: String?
    let patientDocumentURL: JSONNull?
    let deliveryBoyID, deliveryBoy, doctorID, doctor: String?
    let doctorProfilePicURL: String?
    let labMasterID, labConcernPerson, pharmacyID, pharmacyCoordinator: String?
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case status = "Status"
        case patientID = "PatientId"
        case gender = "Gender"
        case firstName = "FirstName"
        case middleName = "MiddleName"
        case lastName = "LastName"
        case patientName = "PatientName"
        case pincode = "Pincode"
        case patientProfilePicURL = "PatientProfilePicURL"
        case patientDocumentURL = "PatientDocumentURL"
        case deliveryBoyID = "DeliveryBoyId"
        case deliveryBoy = "DeliveryBoy"
        case doctorID = "DoctorId"
        case doctor = "Doctor"
        case doctorProfilePicURL = "DoctorProfilePicURL"
        case labMasterID = "LabMasterId"
        case labConcernPerson = "LabConcernPerson"
        case pharmacyID = "PharmacyId"
        case pharmacyCoordinator = "PharmacyCoordinator"
    }
}

typealias LoginOtpAuthenticatwDataResponse = [LoginOtpAuthenticatwDataResponseElement]

struct Welcomevalue: Codable {
    let soapEnvelope: SoapEnvelopevalue
    
    enum CodingKeys: String, CodingKey {
        case soapEnvelope = "soap:Envelope"
    }
}

// MARK: - SoapEnvelope
struct SoapEnvelopevalue: Codable {
    let xmlnsXsi, xmlnsXSD, xmlnsSoap: String
    let soapBody: SoapBodyvalue
    
    enum CodingKeys: String, CodingKey {
        case xmlnsXsi = "_xmlns:xsi"
        case xmlnsXSD = "_xmlns:xsd"
        case xmlnsSoap = "_xmlns:soap"
        case soapBody = "soap:Body"
    }
}

// MARK: - SoapBody
struct SoapBodyvalue: Codable {
    let savePatientResponse: SavePatientResponse
    
    enum CodingKeys: String, CodingKey {
        case savePatientResponse = "SavePatientResponse"
    }
}

// MARK: - SavePatientResponse
struct SavePatientResponse: Codable {
    let xmlns: String
    let savePatientResult: SavePatientResult
    
    enum CodingKeys: String, CodingKey {
        case xmlns = "_xmlns"
        case savePatientResult = "SavePatientResult"
    }
}

// MARK: - SavePatientResult
struct SavePatientResult: Codable {
    let patientRegSC: PatientRegSC
    
    enum CodingKeys: String, CodingKey {
        case patientRegSC = "PatientRegSC"
    }
}


// MARK: - PatientRegSC
struct PatientRegSC: Codable {
    let patientID, status, message: String
    
    enum CodingKeys: String, CodingKey {
        case patientID = "PatientId"
        case status = "Status"
        case message = "Message"
    }
}
struct WelcomeTitle: Codable {
    let soapEnvelope: SoapEnvelopeTitle
    
    enum CodingKeys: String, CodingKey {
        case soapEnvelope = "soap:Envelope"
    }
}

// MARK: - SoapEnvelope
struct SoapEnvelopeTitle: Codable {
    let xmlnsXSD, xmlnsXsi, xmlnsSoap: String
    let soapBody: SoapBodyTitle
    
    enum CodingKeys: String, CodingKey {
        case xmlnsXSD = "_xmlns:xsd"
        case xmlnsXsi = "_xmlns:xsi"
        case xmlnsSoap = "_xmlns:soap"
        case soapBody = "soap:Body"
    }
}

// MARK: - SoapBody
struct SoapBodyTitle: Codable {
    let titleGetByTitleTypeResponse: TitleGetByTitleTypeResponse
    
    enum CodingKeys: String, CodingKey {
        case titleGetByTitleTypeResponse = "TitleGetByTitleTypeResponse"
    }
}

// MARK: - TitleGetByTitleTypeResponse
struct TitleGetByTitleTypeResponse: Codable {
    let xmlns: String
    let titleGetByTitleTypeResult: TitleGetByTitleTypeResult
    
    enum CodingKeys: String, CodingKey {
        case xmlns = "_xmlns"
        case titleGetByTitleTypeResult = "TitleGetByTitleTypeResult"
    }
}

// MARK: - TitleGetByTitleTypeResult
struct TitleGetByTitleTypeResult: Codable {
    let commonSC: [CommonSC]
    
    enum CodingKeys: String, CodingKey {
        case commonSC = "CommonSC"
    }
}

// MARK: - CommonSC
struct CommonSC: Codable {
    let id, value: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case value = "Value"
    }
}

