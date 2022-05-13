//
//  DoctorAvailableListViewController.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 07/05/22.
//

import UIKit

class DoctorAvailableListViewController: UIViewController, XIBed, PushViewControllerDelegate, presentViewControllersDelegate {
    func present(vc: UIViewController) {
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var navTitleLblRef: UILabel!
    @IBOutlet weak var navViewRef: UIView!
    @IBOutlet weak var backBtnRef: UIButton!
    @IBOutlet weak var homeBtnRef: UIButton!
    @IBOutlet weak var tvRef: UITableView!
    @IBOutlet weak var emptyViewRef: UIView!

    private lazy var tableViewManager = { DoctorAvailableListTableViewManager(tableVIew: tvRef) }()
    
    var pushDelegate: PushViewControllerDelegate?
    var presentDelegate: presentViewControllersDelegate?
    
    var specializationId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

            setupUI()
            setupCornerShadow()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
    }


}

//MARK: - Setup
extension DoctorAvailableListViewController {
    func setupUI() {
                
        tvRef.separatorStyle = .none
        tableViewManager.pushDelegate = self
        tableViewManager.presentDelegate = self
        
        doctorsListApiCall(specializationId: specializationId)
    }
    
    func setupCornerShadow() {


    }
    


}

//MARK: - Action
extension DoctorAvailableListViewController {
    
    @IBAction func backBtnTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeBtnTap(_ sender: UIButton) {
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let homeVC = CustomTabBarViewController.instantiate()        //Below's navigationController is useful if u want NavigationController
        let navigationController = UINavigationController(rootViewController: homeVC)
        appDelegate.window!.rootViewController = navigationController
    }
}

//MARK: - Api Call
extension DoctorAvailableListViewController {
    func doctorsListApiCall(specializationId: Int) {
        NetWorker.shared.callAPIService(type: APIV2.doctorDetailsBySpecialize(id: specializationId)) { [weak self](data: DoctorBySpecializationResponse?, error) in
            guard self == self else { return }
            
            if data?.count == 0 {
                self!.emptyViewRef.isHidden = false
            } else {
                self!.emptyViewRef.isHidden = true

            }
            
            self!.tableViewManager.start(data: data ?? [])
            
        }
    }
}


// MARK: - DoctorBySpecializationResponseElement
struct DoctorBySpecializationResponseElement: Codable {
    let doctorID: Int
    let firstName, middleName, lastName: String
    let dob, dobText, age: JSONNull?
    let gender: String
    let educationID: JSONNull?
    let education: String
    let specialityID: JSONNull?
    let speciality: String
    let mmcRegNo: JSONNull?
    let totalExperience: String
    let mobileNo1, mobileNo2, emailId1, emailId2: JSONNull?
    let aadhaarNo, department, anniversaryDate, anniversaryDateText: JSONNull?
    let flatno, bldg, road, nearby: JSONNull?
    let area, talukaID, taluka, districtID: JSONNull?
    let district, cityID, stateID, state: JSONNull?
    let countryID, country, pincode, isActive: JSONNull?
    let isActiveText, roleID, roleName, userType: JSONNull?
    let doctorDays, doctorSlot, doctorTimeFrom, doctorTimeTo: JSONNull?
    let isReferringDoc, opdProfessionFees, indoorProfessionFees: JSONNull?
    let onlineConsultationFees: String
    let doctorProfilePicURL: String
    let isPatientReg, isEdit, accountName, panCard: JSONNull?
    let bank, accNo, ifscCode, currUser: JSONNull?
    let hospitalID, pwd, cFpwd, isUserExists: JSONNull?
    let isProfile, hiddDocDetails, hiddDocOnlineConsultDetails, timePeriod: JSONNull?
    let bookDate, hiddRMODetails, timePeriodSClist: JSONNull?

    enum CodingKeys: String, CodingKey {
        case doctorID = "DoctorId"
        case firstName = "FirstName"
        case middleName = "MiddleName"
        case lastName = "LastName"
        case dob = "DOB"
        case dobText = "DOBText"
        case age = "Age"
        case gender = "Gender"
        case educationID = "EducationId"
        case education = "Education"
        case specialityID = "SpecialityId"
        case speciality = "Speciality"
        case mmcRegNo = "MMCRegNo"
        case totalExperience = "TotalExperience"
        case mobileNo1 = "MobileNo1"
        case mobileNo2 = "MobileNo2"
        case emailId1 = "EmailId1"
        case emailId2 = "EmailId2"
        case aadhaarNo = "AadhaarNo"
        case department = "Department"
        case anniversaryDate = "AnniversaryDate"
        case anniversaryDateText = "AnniversaryDateText"
        case flatno = "Flatno"
        case bldg = "Bldg"
        case road = "Road"
        case nearby = "Nearby"
        case area = "Area"
        case talukaID = "TalukaId"
        case taluka = "Taluka"
        case districtID = "DistrictId"
        case district = "District"
        case cityID = "CityId"
        case stateID = "StateId"
        case state = "State"
        case countryID = "CountryId"
        case country = "Country"
        case pincode = "Pincode"
        case isActive = "IsActive"
        case isActiveText = "IsActiveText"
        case roleID = "RoleId"
        case roleName = "RoleName"
        case userType = "UserType"
        case doctorDays = "DoctorDays"
        case doctorSlot = "DoctorSlot"
        case doctorTimeFrom = "DoctorTimeFrom"
        case doctorTimeTo = "DoctorTimeTo"
        case isReferringDoc = "IsReferringDoc"
        case opdProfessionFees = "OPDProfessionFees"
        case indoorProfessionFees = "IndoorProfessionFees"
        case onlineConsultationFees = "OnlineConsultationFees"
        case doctorProfilePicURL = "DoctorProfilePicUrl"
        case isPatientReg = "IsPatientReg"
        case isEdit = "IsEdit"
        case accountName = "AccountName"
        case panCard = "PANCard"
        case bank = "Bank"
        case accNo = "AccNo"
        case ifscCode = "IFSCCode"
        case currUser = "CurrUser"
        case hospitalID = "HospitalId"
        case pwd = "Pwd"
        case cFpwd = "CFpwd"
        case isUserExists = "IsUserExists"
        case isProfile = "IsProfile"
        case hiddDocDetails, hiddDocOnlineConsultDetails
        case timePeriod = "TimePeriod"
        case bookDate = "BookDate"
        case hiddRMODetails
        case timePeriodSClist = "TimePeriodSClist"
    }
}

typealias DoctorBySpecializationResponse = [DoctorBySpecializationResponseElement]
