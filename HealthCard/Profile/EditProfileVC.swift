//
//  EditProfileVC.swift
//  HealthCard
//
//  Created by Viral on 13/04/22.
//

import UIKit

class EditProfileVC: UIViewController,XIBed {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileNoTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var middleNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var bloodGroupTextField: UITextField!
    @IBOutlet weak var educationTextField: UITextField!
    @IBOutlet weak var religionTextField: UITextField!
    @IBOutlet weak var occuptionTextField: UITextField!
    @IBOutlet weak var aadharNoTextField: UITextField!
    @IBOutlet weak var emergencyContactTextField: UITextField!
    @IBOutlet weak var alternateEmailTextField: UITextField!
    @IBOutlet weak var referingUnitTextField: UITextField!
    @IBOutlet weak var insuranceCompanyTextField: UITextField!
    @IBOutlet weak var coveredAmountTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        apiCall()
    }
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension EditProfileVC{

    //MARK: - API CALL
    func apiCall()  {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.PatientHistGetById(patientID: patientID)) { [weak self](data: patientDetails?, error) in
//                self?.dataValue = data!
//                self?.tableView.reloadData()
               // print(patientIDval)
            
        }
    }
}

// MARK: - Welcome
struct patientDetails: Codable {
    let id, patientID, weight, height: Int
    let medicalHist: String
    let medicalHistLst: [String]
    let medicalOtherHist, medicalHistDetails, medication, recentExacrebation: String
    let surgicalHist, anaesthesiaHist, allery, addictions: String
    let familyHist, othSighist, isEdit: String
    let currUser: JSONNull?
    let createdBy, createdByText, createdOn: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case patientID = "PatientId"
        case weight = "Weight"
        case height = "Height"
        case medicalHist = "MedicalHist"
        case medicalHistLst = "MedicalHistLst"
        case medicalOtherHist = "MedicalOtherHist"
        case medicalHistDetails = "MedicalHistDetails"
        case medication = "Medication"
        case recentExacrebation = "RecentExacrebation"
        case surgicalHist = "SurgicalHist"
        case anaesthesiaHist = "AnaesthesiaHist"
        case allery = "Allery"
        case addictions = "Addictions"
        case familyHist = "FamilyHist"
        case othSighist = "OthSighist"
        case isEdit = "IsEdit"
        case currUser = "CurrUser"
        case createdBy = "CreatedBy"
        case createdByText = "CreatedByText"
        case createdOn = "CreatedOn"
    }
}
