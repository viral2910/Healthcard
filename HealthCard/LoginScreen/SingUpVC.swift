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
        guard let pincode =  pincodeTextField.text,pincode.count == 6 else {
            AppManager.shared.showAlert(title: "Error", msg: "Please Enter Pincode", vc: self)
            return;
        }
        if gendervalue == "" {
            AppManager.shared.showAlert(title: "Error", msg: "Please Select Proper Gender", vc: self)
            return;
        }
        let index = titlelist.filter{ $0.value == selectedtitle }
        let valueindex = index.first?.id ?? ""
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
        
//        SVProgressHUD.show()
//        NetWorker.shared.callAPIService(type: APIV2.patientRegistration(titleId: titleId, firstName: firstName, lastName: lastName, mobileNo: mobileNo, password: password, gender: gender, pincode: pincode)) { (data:Welcomevalue?, error) in
//            let message = data?.soapEnvelope.soapBody.savePatientResponse.savePatientResult.patientRegSC.message ?? ""
//
//            SVProgressHUD.dismiss()
//            if message.lowercased().contains("sucess") {
//                let alertController = UIAlertController(title: "Your Registeration Is Successfully", message: message, preferredStyle:UIAlertController.Style.alert)
//
//                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
//                                          { action -> Void in
//
//                })
//                self.present(alertController, animated: true, completion: nil)
//
//            } else {
//                self.registerBtnRef.isEnabled = true
//                UserDefaults.standard.set(false, forKey: "isLogin")
//                UserDefaults.standard.set(0, forKey: "patientID")
//                AppManager.shared.showAlert(title: "Error", msg: "Mobile Number already exists", vc: self)
//            }
//        }
        
        let otpvc =  UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
//                    otpvc.mobilenumber = self.mobilenumberTextField.text ?? ""
        otpvc.titleval = titleId
        otpvc.mobilenumber = mobileNo
        otpvc.fname = firstName
        otpvc.lname = lastName
        otpvc.password = password
        otpvc.confirmpassword = password
        otpvc.pincode = pincode
        otpvc.gendervalue = gendervalue
        self.navigationController?.pushViewController(otpvc, animated: true)
        
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
