//
//  ConsultDoctorDetailsViewController.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 07/05/22.
//

import UIKit
import FSCalendar
import Razorpay

class ConsultDoctorDetailsViewController: UIViewController, XIBed, PushViewControllerDelegate, presentViewControllersDelegate {
    func present(vc: UIViewController) {
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var navTitleLblRef: UILabel!
    @IBOutlet weak var navViewRef: UIView!
    @IBOutlet weak var backBtnRef: UIButton!
    @IBOutlet weak var homeBtnRef: UIButton!
    @IBOutlet weak var cvRef: UICollectionView!
    @IBOutlet weak var fsCalendarViewRef: FSCalendar!
    @IBOutlet weak var fsCalendarViewHeightRef: NSLayoutConstraint!
    @IBOutlet weak var calendarBackViewRef: UIView!
    @IBOutlet weak var dateBgViewRef: UIView!
    @IBOutlet weak var dateLblRef: UILabel!
    @IBOutlet weak var beforeDateBtnRef: UIButton!
    @IBOutlet weak var nextDateBtnRef: UIButton!
    
    @IBOutlet weak var viewRef: UIView!
    @IBOutlet weak var imgViewRef: UIImageView!
    @IBOutlet weak var imgViewBgViewRef: UIView!
    @IBOutlet weak var nameLblRef: UILabel!
    @IBOutlet weak var descLblRef: UILabel!
    @IBOutlet weak var totalExpLblRef: UILabel!
    @IBOutlet weak var feeLblRef: UILabel!
    @IBOutlet weak var videoConsultViewRef: UIView!
    
    @IBOutlet weak var emptyViewRef: UIView!
    
    var doctorDetails: DoctorDetailsDataResponseElement?
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MMMM/YYYY"
        return formatter
    }()
    
    fileprivate lazy var selectedDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MMM/yyyy"
        return formatter
    }()
    
    var selectedDate = ""
    
    lazy var collectionViewManager: DoctorsTimingCollectionViewManager = {
        return DoctorsTimingCollectionViewManager()
    }()
    
    var doctorId = 0
    
    var razorpay: RazorpayCheckout!
    var razorpayTestKey = "rzp_live_a06lrHIHAADxOP"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fsCalendarViewRef.select(Date())
        
        setupUI()
        setupCornerShadow()
        
    }
    
    
}

//MARK: - Setup
extension ConsultDoctorDetailsViewController {
    func setupUI() {
        
        razorpay = RazorpayCheckout.initWithKey(razorpayTestKey, andDelegate: self)
        
        collectionViewManager.pushDelegate = self
        collectionViewManager.presentDelegate = self
        collectionViewManager.delegate = self
        
        fsCalendarViewRef.delegate = self
        fsCalendarViewRef.dataSource = self
        
        calendarBackViewRef.isHidden = true
        
        dateLblRef.text = "\(self.dateFormatter.string(from: Date()))"
        
        let dateTapGesture = UITapGestureRecognizer(target: self, action: #selector(showCalendar))
        dateTapGesture.cancelsTouchesInView = false
        dateLblRef.addGestureRecognizer(dateTapGesture)
        
        getDoctorDetailsApi(doctorId: doctorId, date: selectedDateFormatter.string(from: Date()))
    }
    
    func setupCornerShadow() {
        calendarBackViewRef.layer.borderWidth = 5
        calendarBackViewRef.layer.borderColor = UIColor.init(hexString: "F2F2F2").cgColor
        calendarBackViewRef.layer.maskedCorners = [.bottomLeft, .bottomRight]
        calendarBackViewRef.layer.cornerRadius = 10
        
        videoConsultViewRef.layer.cornerRadius = 10
        videoConsultViewRef.dropShadow()
        imgViewRef.layer.cornerRadius = 10
        imgViewBgViewRef.layer.cornerRadius = 10
        
        imgViewBgViewRef.dropShadow()
        
        viewRef.layer.maskedCorners = [.bottomLeft, .bottomRight]
        viewRef.layer.cornerRadius = 10
        viewRef.dropShadow()
    }
    
}

//MARK: - Action
extension ConsultDoctorDetailsViewController {
    
    @objc func showCalendar() {
        fsCalendarViewHeightRef.constant = 194
        calendarBackViewRef.backgroundColor = .white
        
        calendarBackViewRef.isHidden = false
    }
    
    @IBAction func beforeDateBtnTap(_ sender: UIButton) {
        
        //        fsCalendarViewHeightRef.constant = 194
        //        calendarBackViewRef.backgroundColor = .white
        //
        //        calendarBackViewRef.isHidden = false
        
        switchDateComponent(component: .day, isNextDirection: false)
        
    }
    
    @IBAction func nextDateBtnTap(_ sender: UIButton) {
        //        fsCalendarViewHeightRef.constant = 194
        //        calendarBackViewRef.backgroundColor = .white
        //
        //        calendarBackViewRef.isHidden = false
        
        switchDateComponent(component: .day, isNextDirection: true)
    }
    
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
extension ConsultDoctorDetailsViewController {
    func getDoctorDetailsApi(doctorId: Int, date: String) {
        
        guard let url = URL(string: "\(Router.doctorBaseUrl)ConsultDoctorId=\(doctorId)&vConsultDate=\(date)") else { return }
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.allHTTPHeaderFields = ["Content-Type" : "text/json"]
        urlRequest.httpMethod = "GET"//.get, .post, .put
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data ,let responseCode = response as? HTTPURLResponse {
                let decoder = JSONDecoder()
                do {
                    let json = try decoder.decode(DoctorDetailsDataResponse?.self, from: data)
                    DispatchQueue.main.async {
                        
                        self.emptyViewRef.isHidden = true
                        
                        self.collectionViewManager.start(collectionView: self.cvRef, learnData: json?[0].timePeriodSClist ?? [])
                        
                        
                        if let data = json?[0] {
                            self.doctorDetails = data
                            let name = "\(data.firstName) \(data.lastName)"
                            self.nameLblRef.text = name
                            
                            self.feeLblRef.text = "₹ \(data.onlineConsultationFees)"
                            
                            self.descLblRef.text = data.speciality
                            
                            self.totalExpLblRef.text = "\(data.totalExperience) Years of Experience"
                            
                            let imgUrl = data.doctorProfilePicURL
                            self.imgViewRef.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "placeholder.png"))
                            
                        }
                        
                    }
                } catch let error {
                    print("Error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        
                        self.emptyViewRef.isHidden = false
                        
                        self.getDoctor2DetailsApi(doctorId: self.doctorId, date: date)
                    }
                }
            }
        }.resume()
        
        
        //        NetWorker.shared.callAPIService(type: APIV2.doctorOnlineConsultScheduleByDoctor(doctorId: doctorId, date: date)) { [weak self](data: DoctorDetailsDataResponse?, error) in
        //            guard self == self else { return }
        //
        //            self!.collectionViewManager.start(collectionView: self!.cvRef, learnData: data?[0].timePeriodSClist ?? [])
        //
        //
        //            if let data = data?[0] {
        //                let name = "\(data.firstName) \(data.lastName)"
        //                self!.nameLblRef.text = name
        //
        //                self!.feeLblRef.text = "₹ \(data.onlineConsultationFees)"
        //
        //                self!.descLblRef.text = data.speciality
        //
        //                self!.totalExpLblRef.text = "\(data.totalExperience) Years of Experience"
        //
        //                let imgUrl = data.doctorProfilePicURL
        //                self!.imgViewRef.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "placeholder.png"))
        //
        //            }
        //        }
    }
    func getDoctor2DetailsApi(doctorId: Int, date: String) {
        
        
                NetWorker.shared.callAPIService(type: APIV2.doctorOnlineConsultScheduleByDoctor(doctorId: doctorId, date: date)) { [weak self](data: DoctorDetails2DataResponse?, error) in
                    guard self == self else { return }
        
                    if let data = data?[0] {
                        let name = "\(data.firstName) \(data.lastName)"
                        self!.nameLblRef.text = name
        
                        self!.feeLblRef.text = "₹ \(data.onlineConsultationFees)"
        
                        self!.descLblRef.text = data.speciality
        
                        self!.totalExpLblRef.text = "\(data.totalExperience) Years of Experience"
        
                        let imgUrl = data.doctorProfilePicURL
                        self!.imgViewRef.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "placeholder.png"))
        
                    }
                }
    }

    
}

//MARK: - FsCalender
extension ConsultDoctorDetailsViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        
        let sDate = self.dateFormatter.string(from: date)
        
        print("sDate: \(sDate)")
        
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        
        dateLblRef.text = "\(sDate)"
        
        calendarBackViewRef.isHidden = true
        fsCalendarViewHeightRef.constant = 0
        
        getDoctorDetailsApi(doctorId: doctorId, date: selectedDateFormatter.string(from: date))
        
        
    }
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return UIColor.init(hexString: "EC7021")
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return .black
    }
    
    
    //    func minimumDate(for calendar: FSCalendar) -> Date {
    //        return Date()
    //    }
    
    func switchDateComponent(component: Calendar.Component, isNextDirection: Bool) {
        if let nextDate = Calendar.current.date(byAdding: component, value: isNextDirection ? 1 : -1, to: fsCalendarViewRef.selectedDate ?? Date()) {
            fsCalendarViewRef.select(nextDate, scrollToDate: true)
            
            let sDate = self.dateFormatter.string(from: nextDate)
            
            print("sDate: \(sDate)")
            
            
            dateLblRef.text = "\(sDate)"
            
            getDoctorDetailsApi(doctorId: doctorId, date: selectedDateFormatter.string(from: nextDate))
            
        }
    }
}

extension ConsultDoctorDetailsViewController: RazorpayPaymentCompletionProtocol{
    func onPaymentError(_ code: Int32, description str: String) {
        print("Failed \(str)")
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        print("Success \(payment_id)")
        
        
    }
    
    internal func showPaymentForm(amount: Int,orderId: String, desc: String){
        let options: [String:Any] = [
            "amount": "\(amount * 100)", //This is in currency subunits. 100 = 100 paise= INR 1.
            "currency": "INR",//We support more that 92 international currencies.
            "description": "\(desc)",
            //"order_id": orderId,
            "name": "Health Card",
            "theme": [
                "color": "#F37254"
            ]
        ]
        razorpay.open(options)
    }
    
    
}

//MARK: - Delegate
extension ConsultDoctorDetailsViewController: SelectedConsultationDetailsPtotocol {
    func getConsultationDetailsData(data: DoctorOnlineConsultTimeSClist) {
        self.showPaymentForm(amount: Int(doctorDetails?.onlineConsultationFees ?? "") ?? 0, orderId: "154546548", desc: "\(doctorDetails?.speciality ?? "")")
    }
    
    
}

// MARK: - DoctorDetailsDataResponseElement
struct DoctorDetailsDataResponseElement: Codable {
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
    let bookDate: String
    let hiddRMODetails: JSONNull?
    let timePeriodSClist: [TimePeriodSClist]
    
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

// MARK: - TimePeriodSClist
struct TimePeriodSClist: Codable {
    let timePeriod: String
    let doctorID: JSONNull?
    let doctorOnlineConsultTimeSClist: [DoctorOnlineConsultTimeSClist]?
    
    enum CodingKeys: String, CodingKey {
        case timePeriod = "TimePeriod"
        case doctorID = "DoctorId"
        case doctorOnlineConsultTimeSClist = "DoctorOnlineConsultTimeSClist"
    }
}

// MARK: - DoctorOnlineConsultTimeSClist
struct DoctorOnlineConsultTimeSClist: Codable {
    let fromTime: String
    let fromTimeOrg: JSONNull?
    let toTime: String
    let toTimeOrg: JSONNull?
    let frequency: String
    let slot: JSONNull?
    let bookDate: String
    let doctorID, firstName, middleName, lastName: JSONNull?
    let gender, speciality, totalExperience, education: JSONNull?
    let doctorProfilePicURL: JSONNull?
    let timePeriod: String
    let onlineConsultationFees: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case fromTime = "FromTime"
        case fromTimeOrg = "FromTimeOrg"
        case toTime = "ToTime"
        case toTimeOrg = "ToTimeOrg"
        case frequency = "Frequency"
        case slot = "Slot"
        case bookDate = "BookDate"
        case doctorID = "DoctorId"
        case firstName = "FirstName"
        case middleName = "MiddleName"
        case lastName = "LastName"
        case gender = "Gender"
        case speciality = "Speciality"
        case totalExperience = "TotalExperience"
        case education = "Education"
        case doctorProfilePicURL = "DoctorProfilePicUrl"
        case timePeriod = "TimePeriod"
        case onlineConsultationFees = "OnlineConsultationFees"
    }
}

typealias DoctorDetailsDataResponse = [DoctorDetailsDataResponseElement]

// MARK: - DoctorDetails2DataResponseElement
struct DoctorDetails2DataResponseElement: Codable {
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

typealias DoctorDetails2DataResponse = [DoctorDetails2DataResponseElement]
