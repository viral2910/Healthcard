//
//  SingUpVC.swift
//  HealthCard
//
//  Created by Viral on 30/03/22.
//

import UIKit

class SingUpVC: UIViewController, UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var mobilenumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmpasswordTextField: UITextField!
    @IBOutlet weak var pincodeTextField: UITextField!
    
    
    var titlelist = ["1", "2", "3"]
    var selectedtitle = ""
    
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
    @IBAction func registerAction(_ sender: Any) {
        guard let fname =  firstnameTextField.text,fname != "" else {
            AppManager.shared.showAlert(title: "Error", msg: "Please Enter First Name", vc: self)
            return;
        }
        guard let lname =  lastnameTextField.text,lname != "" else {
            AppManager.shared.showAlert(title: "Error", msg: "Please Enter Last Name", vc: self)
            return;
        }
        guard let mobile =  mobilenumberTextField.text,mobile != "" else {
            AppManager.shared.showAlert(title: "Error", msg: "Please Enter Mobile Number", vc: self)
            return;
        }
        guard let password =  confirmpasswordTextField.text,password != "" else {
            AppManager.shared.showAlert(title: "Error", msg: "Please Enter password", vc: self)
            return;
        }
        guard let confirmpassword =  confirmpasswordTextField.text,confirmpassword == password else {
            AppManager.shared.showAlert(title: "Error", msg: "Password does not match", vc: self)
            return;
        }
        guard let pincode =  pincodeTextField.text,pincode != "" else {
            AppManager.shared.showAlert(title: "Error", msg: "Please Enter Pincode", vc: self)
            return;
        }
    }
    @IBAction func signinAction(_ sender: Any) {
        let singin = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "SingInVC") as! SingInVC
        self.navigationController?.pushViewController(singin, animated: true)
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
            titleTextField.text = titlelist[0]
        } else {
        titleTextField.text = selectedtitle
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return titlelist.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titlelist[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedtitle = titlelist[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
}
