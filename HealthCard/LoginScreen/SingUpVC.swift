//
//  SingUpVC.swift
//  HealthCard
//
//  Created by Viral on 30/03/22.
//

import UIKit
import SVProgressHUD

class SingUpVC: UIViewController, UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var mobilenumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmpasswordTextField: UITextField!
    @IBOutlet weak var pincodeTextField: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    
    @IBOutlet weak var registerBtnRef: UIButton!
    @IBOutlet weak var passwordVisible: UIButton!
    var isPassword = true
    
    @IBOutlet weak var confirmpasswordVisible: UIButton!
    var isConfirmPassword = true
    var titlelist = [CommonSC]()
    var selectedtitle = ""
    var gendervalue = "Male"
    var titlePicker: UIPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPicker()
        self.navigationController?.isNavigationBarHidden = true
        firstnameTextField.delegate = self
        lastnameTextField.delegate = self
        mobilenumberTextField.delegate = self
        passwordTextField.delegate = self
        confirmpasswordTextField.delegate = self
        pincodeTextField.delegate = self
    }
    @IBAction func valuechangeGender(_ sender: UISegmentedControl) {
        gendervalue = genderSegment.titleForSegment(at: genderSegment.selectedSegmentIndex) ?? "Male"
    }
    override func viewWillAppear(_ animated: Bool) {
        GettitleApiCall()
    }
    @IBAction func registerAction(_ sender: Any) {
        guard let fname =  firstnameTextField.text,fname != "" else {
            AppManager.shared.showAlert(title: "Error", msg: "Please Enter First Name", vc: self)
            return;
        }
        guard let lname =  lastnameTextField.text,lname != "" else {
            AppManager.shared.showAlert(title: "Error", msg: "Please Enter Last Name", vc: self)
            return;
        }
        guard let mobile =  mobilenumberTextField.text,mobile.count == 10 else {
            AppManager.shared.showAlert(title: "Error", msg: "Please Enter Mobile Number", vc: self)
            return;
        }
        guard let password =  passwordTextField.text,password != "" else {
            AppManager.shared.showAlert(title: "Error", msg: "Please Enter password", vc: self)
            return;
        }
        guard let confirmpassword =  confirmpasswordTextField.text,confirmpassword == password else {
            AppManager.shared.showAlert(title: "Error", msg: "Password does not match", vc: self)
            return;
        }
        guard let pincode =  pincodeTextField.text,pincode.count == 7 else {
            AppManager.shared.showAlert(title: "Error", msg: "Please Enter Pincode", vc: self)
            return;
        }
        if gendervalue == "" {
            AppManager.shared.showAlert(title: "Error", msg: "Please Select Proper Gender", vc: self)
            return;
        }
        let index = titlelist.filter{ $0.value == selectedtitle }
        let valueindex = index.first?.id ?? ""
        SVProgressHUD.show()
        signUpApiCall(titleId: Int(valueindex) ?? 0 , firstName: fname, lastName: lname, mobileNo: mobile, password: password, gender: gendervalue, pincode: pincode)
    }
    @IBAction func signinAction(_ sender: Any) {
        let singin = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "SingInVC") as! SingInVC
        self.navigationController?.pushViewController(singin, animated: true)
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
    
    @available(iOS 13.0, *)
    @IBAction func ConfirmpasswordVisibleAction(_ sender: UIButton) {
        if isConfirmPassword {
            isConfirmPassword = !isConfirmPassword
            confirmpasswordTextField.isSecureTextEntry = false
            confirmpasswordVisible.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            isConfirmPassword = !isConfirmPassword
            confirmpasswordTextField.isSecureTextEntry = true
            confirmpasswordVisible.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    // MARK: Picker
    func setPicker(){
        
        titlePicker = UIPickerView()
        titlePicker?.delegate = self
        titlePicker?.dataSource = self
        let toolBar = UIToolbar()
        toolBar.setDefaultStyle()
        
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.CancelBtn))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.DoneBtn))
        
        toolBar.setItems([cancelBtn,spacer,doneBtn], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        titleTextField.inputView = titlePicker
        titleTextField.inputAccessoryView = toolBar
        
    }
    
    @objc func CancelBtn(){
        self.view.endEditing(true)
        titleTextField.text = ""
    }
    
    @objc func DoneBtn(){
        self.view.endEditing(true)
        if selectedtitle == "" {
            titleTextField.text = titlelist[0].value
        } else {
        titleTextField.text = selectedtitle
        }
    }
    
    func signUpApiCall(titleId:Int,firstName:String , lastName: String,mobileNo:String , password: String,gender:String , pincode: String){
        self.registerBtnRef.isEnabled = false
        struct demo : Codable{
            
        }
        NetWorker.shared.callAPIService(type: APIV2.patientRegistration(titleId: titleId, firstName: firstName, lastName: lastName, mobileNo: mobileNo, password: password, gender: gender, pincode: pincode)) { (data:Welcomevalue?, error) in
            let message = data?.soapEnvelope.soapBody.savePatientResponse.savePatientResult.patientRegSC.message ?? ""
            if message.lowercased().contains("sucess") {
                let alertController = UIAlertController(title: "Your Registeration Is Successfully", message: message, preferredStyle:UIAlertController.Style.alert)

                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                   { action -> Void in
                     // Put your code here
//                       let patientid = data?.soapEnvelope.soapBody.savePatientResponse.savePatientResult.patientRegSC.patientID
//                       UserDefaults.standard.set(true, forKey: "isLogin")
//                       UserDefaults.standard.set(patientid, forKey: "patientID")
//                       UIApplication.shared.keyWindow?.rootViewController = self.navigationController
//                       let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                       let homeVC = CustomTabBarViewController.instantiate()
//                       let navigationController = UINavigationController(rootViewController: homeVC)
//                       appDelegate.window!.rootViewController = navigationController
                    
                        let otpvc =  UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                        otpvc.mobilenumber = self.mobilenumberTextField.text ?? ""
                        self.navigationController?.pushViewController(otpvc, animated: true)
                   })
                   self.present(alertController, animated: true, completion: nil)
                
            } else {
                self.registerBtnRef.isEnabled = true
                UserDefaults.standard.set(false, forKey: "isLogin")
                UserDefaults.standard.set(0, forKey: "patientID")
                AppManager.shared.showAlert(title: "Error", msg: "Mobile Number already exists", vc: self)
            }
        }
        
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return titlelist.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titlelist[row].value
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedtitle = titlelist[row].value
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
    
    func GettitleApiCall(){
        struct demo : Codable{
            
        }
        NetWorker.shared.callAPIService(type: APIV2.TitleGetByTitleType(titleType: "Title")) { (data:WelcomeTitle?, error) in
            let CommonSCList = data?.soapEnvelope.soapBody.titleGetByTitleTypeResponse.titleGetByTitleTypeResult.commonSC
            self.titlelist.removeAll()
            for item in CommonSCList! {
                self.titlelist.append(CommonSC(id: item.id, value: item.value))
            }
            self.titlePicker?.reloadAllComponents()
        }
        
    }
}
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

