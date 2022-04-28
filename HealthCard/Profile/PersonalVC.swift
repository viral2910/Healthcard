//
//  PersonalVC.swift
//  HealthCard
//
//  Created by Viral on 11/04/22.
//

import UIKit

class PersonalVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var datavalue : WelcomePatientDetails? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.register(UINib(nibName: "ProfileTableviewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableviewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        GetDetailsApiCall()
    }
    func GetDetailsApiCall(){
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "")
        NetWorker.shared.callAPIService(type: APIV2.PatientGetById(patientId: patientID ?? 0)) { (data:WelcomePatientDetails?, error) in
            let patientIDval = data?.soapEnvelope.soapBody.patientGetByIDResponse.patientGetByIDResult.patientSC.patientID
            if UserDefaults.standard.string(forKey: "patientID") ?? "" == patientIDval {
                self.datavalue = data
                self.tableview.reloadData()
                
            }
            else {
                AppManager.shared.showAlert(title: "Error", msg: "Something went wrong!!", vc: self)
            }
        }
    }
}
extension PersonalVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "ProfileTableviewCell") as! ProfileTableviewCell
        
        if indexPath.row % 2 == 0 {
            cell.mainview.backgroundColor = .white
        } else {
            if #available(iOS 13.0, *) {
                cell.mainview.backgroundColor = .systemGray5
            } else {
                // Fallback on earlier versions
            }
        }
        
        switch indexPath.row {
        case 0:
            cell.nameLabel.text = "First Name"
            cell.valueLabel.text = datavalue?.soapEnvelope.soapBody.patientGetByIDResponse.patientGetByIDResult.patientSC.firstName
        case 1:
            cell.nameLabel.text = "Middle Name"
            cell.valueLabel.text = ""
        case 2:
            cell.nameLabel.text = "Last Name"
            cell.valueLabel.text = datavalue?.soapEnvelope.soapBody.patientGetByIDResponse.patientGetByIDResult.patientSC.lastName
        case 3:
            cell.nameLabel.text = "Gender"
            cell.valueLabel.text = datavalue?.soapEnvelope.soapBody.patientGetByIDResponse.patientGetByIDResult.patientSC.gender
        case 4:
            cell.nameLabel.text = "Date of Birth"
            cell.valueLabel.text = datavalue?.soapEnvelope.soapBody.patientGetByIDResponse.patientGetByIDResult.patientSC.dobText
        case 5:
            cell.nameLabel.text = "Mobile No"
            cell.valueLabel.text = datavalue?.soapEnvelope.soapBody.patientGetByIDResponse.patientGetByIDResult.patientSC.mobileNo1
        case 6:
            cell.nameLabel.text = "Email"
            cell.valueLabel.text = ""
        case 7:
            cell.nameLabel.text = "Emergency Contact"
            cell.valueLabel.text = datavalue?.soapEnvelope.soapBody.patientGetByIDResponse.patientGetByIDResult.patientSC.mobileNo2
        case 8:
            cell.nameLabel.text = "Blood Group"
            cell.valueLabel.text = ""
        case 9:
            cell.nameLabel.text = "Education"
            cell.valueLabel.text = ""
        case 10:
            cell.nameLabel.text = "Religion"
            cell.valueLabel.text = ""
        case 11:
            cell.nameLabel.text = "Occupation"
            cell.valueLabel.text = ""
        case 12:
            cell.nameLabel.text = "Aadhaar No"
            cell.valueLabel.text = ""
        default:
            break
        }
        
        return cell
    }
}
// MARK: - Welcome
struct WelcomePatientDetails: Codable {
    let soapEnvelope: SoapEnvelopePatientDetails

    enum CodingKeys: String, CodingKey {
        case soapEnvelope = "soap:Envelope"
    }
}

// MARK: - SoapEnvelope
struct SoapEnvelopePatientDetails: Codable {
    let xmlnsXsi, xmlnsXSD, xmlnsSoap: String
    let soapBody: SoapBodyPatientDetails

    enum CodingKeys: String, CodingKey {
        case xmlnsXsi = "_xmlns:xsi"
        case xmlnsXSD = "_xmlns:xsd"
        case xmlnsSoap = "_xmlns:soap"
        case soapBody = "soap:Body"
    }
}

// MARK: - SoapBody
struct SoapBodyPatientDetails: Codable {
    let patientGetByIDResponse: PatientGetByIDResponse

    enum CodingKeys: String, CodingKey {
        case patientGetByIDResponse = "PatientGetByIdResponse"
    }
}

// MARK: - PatientGetByIDResponse
struct PatientGetByIDResponse: Codable {
    let xmlns: String
    let patientGetByIDResult: PatientGetByIDResult

    enum CodingKeys: String, CodingKey {
        case xmlns = "_xmlns"
        case patientGetByIDResult = "PatientGetByIdResult"
    }
}

// MARK: - PatientGetByIDResult
struct PatientGetByIDResult: Codable {
    let patientSC: PatientSC

    enum CodingKeys: String, CodingKey {
        case patientSC = "PatientSC"
    }
}

// MARK: - PatientSC
struct PatientSC: Codable {
    let patientID, titleID, titleName, firstName: String
    let middleName: AadhaarNo
    let lastName, dob, dobText, age: String
    let gender: String
    let education, religionID, religion: AadhaarNo
    let bloodGroupID: String
    let bloodGroup, aadhaarNo: AadhaarNo
    let mobileNo1, mobileNo2: String
    let occuption, emailId1, emailId2: AadhaarNo
    let flatno, bldg, road, nearby: String
    let area, talukaID, taluka, districtID: String
    let district, stateID, state, countryID: String
    let country, countryCodeID, pincode, isActive: String
    let isActiveText: String
    let companyID, company, plan, amountCovered: AadhaarNo
    let dateOfPremium: String
    let dateOfPremiumText: AadhaarNo
    let renevelOn: String
    let renevelOnText, refUnitID, refUnit: AadhaarNo
    let patientRegNo, currUser: String

    enum CodingKeys: String, CodingKey {
        case patientID = "PatientId"
        case titleID = "TitleId"
        case titleName = "TitleName"
        case firstName = "FirstName"
        case middleName = "MiddleName"
        case lastName = "LastName"
        case dob = "DOB"
        case dobText = "DOBText"
        case age = "Age"
        case gender = "Gender"
        case education = "Education"
        case religionID = "ReligionId"
        case religion = "Religion"
        case bloodGroupID = "BloodGroupId"
        case bloodGroup = "BloodGroup"
        case aadhaarNo = "AadhaarNo"
        case mobileNo1 = "MobileNo1"
        case mobileNo2 = "MobileNo2"
        case occuption = "Occuption"
        case emailId1 = "EmailId1"
        case emailId2 = "EmailId2"
        case flatno = "Flatno"
        case bldg = "Bldg"
        case road = "Road"
        case nearby = "Nearby"
        case area = "Area"
        case talukaID = "TalukaId"
        case taluka = "Taluka"
        case districtID = "DistrictId"
        case district = "District"
        case stateID = "StateId"
        case state = "State"
        case countryID = "CountryId"
        case country = "Country"
        case countryCodeID = "CountryCodeId"
        case pincode = "Pincode"
        case isActive = "IsActive"
        case isActiveText = "IsActiveText"
        case companyID = "CompanyId"
        case company = "Company"
        case plan = "Plan"
        case amountCovered = "AmountCovered"
        case dateOfPremium = "DateOfPremium"
        case dateOfPremiumText = "DateOfPremiumText"
        case renevelOn = "RenevelOn"
        case renevelOnText = "RenevelOnText"
        case refUnitID = "RefUnitId"
        case refUnit = "RefUnit"
        case patientRegNo = "PatientRegNo"
        case currUser = "CurrUser"
    }
}

// MARK: - AadhaarNo
struct AadhaarNo: Codable {
}
