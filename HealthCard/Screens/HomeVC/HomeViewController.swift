//
//  HomeViewController.swift
//  HealthCard
//
//  Created by Pratik on 09/04/22.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController , XIBed, PushViewControllerDelegate ,CLLocationManagerDelegate{

    ///Nav Bar
    @IBOutlet weak var sideMenuBtnRef: UIButton!
    @IBOutlet weak var navViewRef: UIView!
    @IBOutlet weak var navTitleLblRef: UILabel!
    @IBOutlet weak var cartBtnRef: UIButton!

    @IBOutlet weak var currentlocationValue: UILabel!
    @IBOutlet weak var sliderBanner1CvRef: UICollectionView!
    @IBOutlet weak var userNameLblRef: UILabel!
    @IBOutlet weak var currentLocationBtnRef: UIButton!
    @IBOutlet weak var bookLabTestOuterViewRef: UIView!
    @IBOutlet weak var bookLabTestLblRef: UILabel!
    @IBOutlet weak var bookLabTestImgViewRef: UIImageView!
    @IBOutlet weak var medicinesAndEssentialsOuterViewRef: UIView!
    @IBOutlet weak var medicinesAndEssentialsLblRef: UILabel!
    @IBOutlet weak var medicinesAndEssentialsImgViewRef: UIImageView!

    ///Looking for test
    @IBOutlet weak var lookingForTestHeaderLblRef: UILabel!
    @IBOutlet weak var lookingForTestCvRef: UICollectionView!
    @IBOutlet weak var lookingForTestSliderBannerCvRef: UICollectionView!
    @IBOutlet weak var labReportsOuterViewRef: UIView!
    @IBOutlet weak var labReportsLblRef: UILabel!
    @IBOutlet weak var labReportsImgViewRef: UIImageView!
    @IBOutlet weak var procedureReportsOuterViewRef: UIView!
    @IBOutlet weak var procedureReportsLblRef: UILabel!
    @IBOutlet weak var procedureReportsImgViewRef: UIImageView!
    
    ///Medicine you are looking for
    @IBOutlet weak var medicineYouAreLookingHeaderLblRef: UILabel!
    @IBOutlet weak var medicineYouAreLookingCvRef: UICollectionView!
    @IBOutlet weak var medicineYouAreLookingSliderBanner1CvRef: UICollectionView!
    @IBOutlet weak var medicineYouAreLookingSliderBanner2CvRef: UICollectionView!

    ///Looking for consultation in
    @IBOutlet weak var lookingForConsultationsInHeaderLblRef: UILabel!
    @IBOutlet weak var lookingForConsultationsInCvRef: UICollectionView!
    @IBOutlet weak var lookingForConsultationsInSliderBanner1CvRef: UICollectionView!
    @IBOutlet weak var lookingForConsultationsInSliderBanner2CvRef: UICollectionView!
    
    ///Any of these issue please consult
    @IBOutlet weak var consultHeaderLblRef: UILabel!
    @IBOutlet weak var consultCvRef: UICollectionView!

    ///Patients Experience with us
    @IBOutlet weak var patientsExperienceHeaderLblRef: UILabel!
    @IBOutlet weak var patientsExperienceSliderBanner1CvRef: UICollectionView!
    
    ///Blogs from Expert
    @IBOutlet weak var blogsFromExpertHeaderLblRef: UILabel!
    @IBOutlet weak var blogsFromExpertCvRef: UICollectionView!
    
    private lazy var collectionViewManager = { DashboardCollectionViewManager() }()
    
    private lazy var lookingForTestInCollectionViewManager = { LookingForTestInCollectionViewManager() }()
    
    private lazy var sliderCollectionViewManager = { SliderBannerCollectionViewManager() }()

    private lazy var lookingForTestSliderCollectionViewManager = { LookingForTestSliderCollectionViewManager() }()

    private lazy var patientExperienceWithUsSliderCollectionViewManager = { PatientExperienceWithUsSliderCollectionViewManager() }()

    private lazy var lookingForConsultationInSlider2CollectionViewManager = { LookingForConsultationInSlider2CollectionViewManager() }()

    private lazy var lookingForConsultationInSlider1CollectionViewManager = { LookingForConsultationInSlider1CollectionViewManager() }()

    private lazy var medicineYouAreLookingSlider2CollectionViewManager = { MedicineYouAreLookingSlider2CollectionViewManager() }()

    private lazy var medicineYouAreLookingSlider1CvManager = { MedicineYouAreLookingSlider1CvManager() }()

    
    private lazy var blogsCollectionViewManager = { BlogsCollectionViewManager() }()

    private lazy var categoryCollectionViewManager = { CategoryCollectionViewManager() }()
    
    private lazy var consultationCategoryCollectionViewManager = { ConsultationCategoryCollectionViewManager() }()

    weak var pushDelegate: PushViewControllerDelegate?
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

            setupUI()
            setupCornerShadow()
        

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetDetailsApiCall()
        self.navigationController?.isNavigationBarHidden = true
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
        if currentlocationValue.text == " " || currentlocationValue.text == "" {
        getAddressFromLatLon(pdblLatitude: "\(locValue.latitude)", withLongitude: "\(locValue.longitude)")
        }
    }

    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat: Double = Double("\(pdblLatitude)")!
            //21.228124
            let lon: Double = Double("\(pdblLongitude)")!
            //72.833770
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = placemarks! as [CLPlacemark]

                    if pm.count > 0 {
                        let pm = placemarks![0]
                        var addressString : String = ""
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
//                        if pm.thoroughfare != nil {
//                            addressString = addressString + pm.thoroughfare! + ", "
//                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality!
                        }
                        self.currentlocationValue.text = addressString
                  }
            })
        }
    func GetDetailsApiCall(){
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "")
        NetWorker.shared.callAPIService(type: APIV2.PatientGetById(patientId: patientID ?? 0)) { (data:WelcomePatientDetails?, error) in
            let patientIDval = data?.soapEnvelope.soapBody.patientGetByIDResponse.patientGetByIDResult.patientSC.patientID
            
                let firstname = data?.soapEnvelope.soapBody.patientGetByIDResponse.patientGetByIDResult.patientSC.firstName ?? ""
            let lastname = data?.soapEnvelope.soapBody.patientGetByIDResponse.patientGetByIDResult.patientSC.lastName ?? ""
            UserDefaults.standard.set("\(firstname) \(lastname)", forKey: "patientFullName")
            if UserDefaults.standard.string(forKey: "patientID") ?? "" == patientIDval {
                self.userNameLblRef.text = "\(firstname) \(lastname)"
            }
            else {
                AppManager.shared.showAlert(title: "Error", msg: "Something went wrong!!", vc: self)
            }
        }
    }
}

//MARK: - Setup
extension HomeViewController {
    func setupUI() {
        

        lookingForConsultationApi()
        lookingForTestInApi()
        lookingForMedicineInApi()
        issueConsultationApi()
        collectionViewManager.delegate = self
        sliderCollectionViewManager.pushDelegate = self
        
        sliderCollectionViewManager.start(data: ["upto_25_off","Track-Your-Order","24x7-Health-Support_long"], collectionVIew: sliderBanner1CvRef)
        lookingForTestSliderCollectionViewManager.start(data: ["lab_test_hc_banner","40_off_home_checkup","lab_test_hc_banner"], collectionVIew: lookingForTestSliderBannerCvRef)
        medicineYouAreLookingSlider1CvManager.start(data: ["40_off_home_checkup","All-Payment","top_doc_online"], collectionVIew: medicineYouAreLookingSliderBanner1CvRef)
        medicineYouAreLookingSlider2CollectionViewManager.start(data: ["finance-1"], collectionVIew: medicineYouAreLookingSliderBanner2CvRef)
        lookingForConsultationInSlider1CollectionViewManager.start(data: ["online_consult_from_certified_doc","home11","10_40_off" ], collectionVIew: lookingForConsultationsInSliderBanner1CvRef)
        lookingForConsultationInSlider2CollectionViewManager.start(data: ["online_consultation_2"], collectionVIew: lookingForConsultationsInSliderBanner2CvRef)
        patientExperienceWithUsSliderCollectionViewManager.start(data: ["This app is really flawless. Good for elderly people. Best part of the app is home delivery of medicine at a discounted price.","I got lab tests done for my parents on HealthCard since we couldn’t travel. Sample was collected at home & I got both reports on the app. Very convenient.","I booked an appointment for an CBC (COMPLETE BLOOD COUNT) via HealthCard. Got my CBC (COMPLETE BLOOD COUNT) done immediately at my home. Didn’t have to wait or stand in a queue.","My mother  was unwell late at night and I had to speak to a doctor immediately. i chose a doctor  and got to consult in 10 minutes.It was very helpful for us."], nameData: ["Abhay thakur","Rohit Dixit","Praksah budhe","Saurabh KONKAR"], collectionVIew: patientsExperienceSliderBanner1CvRef)


        blogsCollectionViewManager.start(data: ["YOmC5Tyk-nU.jpeg","UKM2SVBhtNs.jpeg","Ax4fAvR-C_c.jpeg","xDJ8FE43aP0.jpeg","SuNc0QRTvGA.jpeg","9VtxCxtsMAI.jpeg"], collectionVIew: blogsFromExpertCvRef, totalItemToShow: 1.8)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.LabAction))
        self.bookLabTestOuterViewRef.addGestureRecognizer(gesture)
        let gesture1 = UITapGestureRecognizer(target: self, action:  #selector(self.MedicineAction))
        self.medicinesAndEssentialsOuterViewRef.addGestureRecognizer(gesture1)
        
        
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector(self.LabReportAction))
        self.labReportsOuterViewRef.addGestureRecognizer(gesture2)
        let gesture3 = UITapGestureRecognizer(target: self, action:  #selector(self.ProcedureReportsAction))
        self.procedureReportsOuterViewRef.addGestureRecognizer(gesture3)

    }
    
    @objc func LabAction(sender : UITapGestureRecognizer) {
        let vc = BookLabTest(nibName: "BookLabTest", bundle: nil)
        self.pushDelegate?.pushViewController(vc: vc)
    }
    
    @objc func MedicineAction(sender : UITapGestureRecognizer) {
        let vc = MedicineVC(nibName: "MedicineVC", bundle: nil)
        self.pushDelegate?.pushViewController(vc: vc)
    }
    @objc func LabReportAction(sender : UITapGestureRecognizer) {
        let controller3 = ProcedureReportsVC(nibName: "ProcedureReportsVC", bundle: nil)
        self.pushDelegate?.pushViewController(vc: controller3)
    }
    
    @objc func ProcedureReportsAction(sender : UITapGestureRecognizer) {
//        let vc = UIStoryboard.Finance.controller(withClass: PharmacyReceiptVC.self)
//        self.navigationController?.pushViewController(vc, animated: true)
        
        
        let controller3 = ProcedureReportsVC(nibName: "ProcedureReportsVC", bundle: nil)
        self.pushDelegate?.pushViewController(vc: controller3)
    }
    func setupCornerShadow() {
        
        sliderBanner1CvRef.layer.cornerRadius = 10
        sliderBanner1CvRef.dropShadow()
        bookLabTestOuterViewRef.layer.cornerRadius = 10
        bookLabTestOuterViewRef.dropShadow()
        medicinesAndEssentialsOuterViewRef.layer.cornerRadius = 10
        medicinesAndEssentialsOuterViewRef.dropShadow()
        
        ///Looking for test
        labReportsOuterViewRef.layer.cornerRadius = 10
        labReportsOuterViewRef.dropShadow()
        procedureReportsOuterViewRef.layer.cornerRadius = 10
        procedureReportsOuterViewRef.dropShadow()

        ///Medicine you are looking for

        
    }
    
//    @objc func sideMenuSwipe() {
//
//        let vc = SideMenuViewController.instantiate()
//
//        let menu = SideMenuNavigationController(rootViewController:vc)
//        menu.leftSide = true
//        menu.presentationStyle = .menuSlideIn
//        present(menu, animated: true, completion: nil)
//
//    }
//
//    @IBAction func sideMenuBtnTap(_ sender: UIButton) {
//
//        let vc = SideMenuViewController.instantiate()
//
//        let menu = SideMenuNavigationController(rootViewController:vc)
//        menu.leftSide = true
//        menu.presentationStyle = .menuSlideIn
//        present(menu, animated: true, completion: nil)
//
//    }

}

//MARK: - Api Call
extension HomeViewController {
    
    func lookingForConsultationApi() {
        struct demo: Codable { }
        NetWorker.shared.callAPIService(type: APIV2.FrequentSpeciality) { [weak self](data: LookinForConsultationDataResponse?, error) in
            guard self == self else { return }

            self!.consultationCategoryCollectionViewManager.start(data: data ?? [], collectionVIew: self!.lookingForConsultationsInCvRef)
            self!.consultationCategoryCollectionViewManager.delegate = self!.pushDelegate

        }
    }
    
    func issueConsultationApi() {
        struct demo: Codable { }
        NetWorker.shared.callAPIService(type: APIV2.FrequentConcernList) { [weak self](data: LookinForConcernDataResponse?, error) in
            guard self == self else { return }

            self!.categoryCollectionViewManager.start(data: data ?? [], collectionVIew: self!.consultCvRef)
            self!.categoryCollectionViewManager.delegate = self!.pushDelegate

        }
    }
    
    func lookingForTestInApi() {
        struct demo: Codable { }
        NetWorker.shared.callAPIService(type: APIV2.FrequentLabTest) { [weak self](data: LookingForTestInDataResponse?, error) in
            guard self == self else { return }

            self!.lookingForTestInCollectionViewManager.start(data: data ?? [], collectionVIew: self!.lookingForTestCvRef, totalItemToShow: 3.2)
            self!.lookingForTestInCollectionViewManager.delegate = self!.pushDelegate
        }
    }

    func lookingForMedicineInApi() {
        struct demo: Codable { }
        NetWorker.shared.callAPIService(type: APIV2.FrequentMedicine) { [weak self](data: LookingForMedicineInData?, error) in
            guard self == self else { return }

            self!.collectionViewManager.start(data: data ?? [], collectionVIew: self!.medicineYouAreLookingCvRef, totalItemToShow: 2.5)
            self!.collectionViewManager.delegate = self!.pushDelegate

        }
    }
}

//MARK: - Action
extension HomeViewController {
    @IBAction func sideMenuBtnTap(_ sender: UIButton) {
    }
    
    @IBAction func cartBtnTap(_ sender: UIButton) {
    }
}


// MARK: - LookinForConsultationDataResponseElement
struct LookinForConsultationDataResponseElement: Codable {
    let id: Int
    let pValue: JSONNull?
    let value: String
    let type, sortOrder, parentType, isActive: JSONNull?
    let isActiveText, isEdit, remark, createdBy: JSONNull?
    let createdOn: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case pValue = "PValue"
        case value = "Value"
        case type = "Type"
        case sortOrder = "SortOrder"
        case parentType = "ParentType"
        case isActive = "IsActive"
        case isActiveText = "IsActiveText"
        case isEdit = "IsEdit"
        case remark = "Remark"
        case createdBy = "CreatedBy"
        case createdOn = "CreatedOn"
    }
}

typealias LookinForConsultationDataResponse = [LookinForConsultationDataResponseElement]

struct LookinForConcernData: Codable {
    let concernID: Int
    let concern, concernCatagoryID, concernCatagory: String
    let concernDetailslist: JSONNull?

    enum CodingKeys: String, CodingKey {
        case concernID = "ConcernId"
        case concern = "Concern"
        case concernCatagoryID = "ConcernCatagoryId"
        case concernCatagory = "ConcernCatagory"
        case concernDetailslist = "ConcernDetailslist"
    }
}

typealias LookinForConcernDataResponse = [LookinForConcernData]

// MARK: - LookingForTestInDataResponseElement
struct LookingForTestInDataResponseElement: Codable {
    let docID, docType, docDate: JSONNull?
    let id: Int
    let testCode: String
    let labTestID: Int
    let labTestText: String
    let mrp, discountPer, discountAmt, charges: Int
    let labMasterID, labName: JSONNull?
    let collectionIn, sampleDetails, method: String
    let labTestImageURL: String

    enum CodingKeys: String, CodingKey {
        case docID = "DocId"
        case docType = "DocType"
        case docDate = "DocDate"
        case id = "Id"
        case testCode = "TestCode"
        case labTestID = "LabTestId"
        case labTestText = "LabTestText"
        case mrp = "MRP"
        case discountPer = "DiscountPer"
        case discountAmt = "DiscountAmt"
        case charges = "Charges"
        case labMasterID = "LabMasterId"
        case labName = "LabName"
        case collectionIn = "CollectionIn"
        case sampleDetails = "SampleDetails"
        case method = "Method"
        case labTestImageURL = "LabTestImageURL"
    }
}

typealias LookingForTestInDataResponse = [LabTestDtlslist]

// MARK: - WelcomeElement
struct LookingForMedicineInDataResponse: Codable {
    let docID, docType, docDate: JSONNull?
    let medicineID, brandID, brandName, genericID: String
    let genericName, doseID, dose: String
    let medType: MedType
    let type: JSONNull?
    let unitID: String
    let unit: Unit
    let route, unitText: JSONNull?
    let package: String
    let marketingComp, manufactComp, frequency, duration: JSONNull?
    let remarks, noOfDays, orderNo, currUser: JSONNull?
    let usgRemark, hospitalID, mrp, noOfStrip: JSONNull?
    let finalAmount, stripCost, discountAmount, discountPer: JSONNull?
    let gstAmount, gstPer, netCost, isPay: JSONNull?
    let balance, pharamcyMasterID, pharmacyName: JSONNull?
    let isPrescription: IsPrescription
    let prescriptionStatus: PrescriptionStatus
    let manufactureID, manufactureCompany: String
    let drugImageURL: String

    enum CodingKeys: String, CodingKey {
        case docID = "DocId"
        case docType = "DocType"
        case docDate = "DocDate"
        case medicineID = "MedicineId"
        case brandID = "BrandId"
        case brandName = "BrandName"
        case genericID = "GenericId"
        case genericName = "GenericName"
        case doseID = "DoseId"
        case dose = "Dose"
        case medType = "MedType"
        case type = "Type"
        case unitID = "UnitId"
        case unit = "Unit"
        case route = "Route"
        case unitText = "UnitText"
        case package = "Package"
        case marketingComp = "MarketingComp"
        case manufactComp = "ManufactComp"
        case frequency = "Frequency"
        case duration = "Duration"
        case remarks = "Remarks"
        case noOfDays = "NoOfDays"
        case orderNo = "OrderNo"
        case currUser = "CurrUser"
        case usgRemark = "USGRemark"
        case hospitalID = "HospitalId"
        case mrp = "MRP"
        case noOfStrip = "NoOfStrip"
        case finalAmount = "FinalAmount"
        case stripCost = "StripCost"
        case discountAmount = "DiscountAmount"
        case discountPer = "DiscountPer"
        case gstAmount = "GSTAmount"
        case gstPer = "GSTPer"
        case netCost = "NetCost"
        case isPay = "IsPay"
        case balance = "Balance"
        case pharamcyMasterID = "PharamcyMasterId"
        case pharmacyName = "PharmacyName"
        case isPrescription = "IsPrescription"
        case prescriptionStatus = "PrescriptionStatus"
        case manufactureID = "ManufactureId"
        case manufactureCompany = "ManufactureCompany"
        case drugImageURL = "DrugImageURL"
    }
}

enum IsPrescription: String, Codable {
    case isPrescriptionTrue = "True"
}

enum MedType: String, Codable {
    case capsule = "CAPSULE"
    case cream = "CREAM"
    case injection = "INJECTION"
    case powder = "POWDER"
    case tablet = "TABLET"
}

enum PrescriptionStatus: String, Codable {
    case prescriptionRequired = "Prescription Required"
}

enum Unit: String, Codable {
    case iu = "IU"
    case mg = "MG"
    case mgMg = "MG+MG"
    case na = "NA"
}

typealias LookingForMedicineInData = [PharmacyDtlsSClist]


