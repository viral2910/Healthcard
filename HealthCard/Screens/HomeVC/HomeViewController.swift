//
//  HomeViewController.swift
//  HealthCard
//
//  Created by Pratik on 09/04/22.
//

import UIKit

class HomeViewController: UIViewController , XIBed, PushViewControllerDelegate {

    ///Nav Bar
    @IBOutlet weak var sideMenuBtnRef: UIButton!
    @IBOutlet weak var navViewRef: UIView!
    @IBOutlet weak var navTitleLblRef: UILabel!
    @IBOutlet weak var cartBtnRef: UIButton!

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

            setupUI()
            setupCornerShadow()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetDetailsApiCall()
        self.navigationController?.isNavigationBarHidden = true
        
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
        
        sliderCollectionViewManager.start(data: ["Track-Your-Order","500_hassle_free_consult","24x7-Health-Support_long"], collectionVIew: sliderBanner1CvRef)
        lookingForTestSliderCollectionViewManager.start(data: ["lab_test_hc_banner","40_off_home_checkup",], collectionVIew: lookingForTestSliderBannerCvRef)
        medicineYouAreLookingSlider1CvManager.start(data: ["top_doc_online"], collectionVIew: medicineYouAreLookingSliderBanner1CvRef)
        medicineYouAreLookingSlider2CollectionViewManager.start(data: ["upto_25_off"], collectionVIew: medicineYouAreLookingSliderBanner2CvRef)
        lookingForConsultationInSlider1CollectionViewManager.start(data: ["10_40_off", "online_consult_from_certified_doc"], collectionVIew: lookingForConsultationsInSliderBanner1CvRef)
        lookingForConsultationInSlider2CollectionViewManager.start(data: ["online_consultation_2"], collectionVIew: lookingForConsultationsInSliderBanner2CvRef)
        patientExperienceWithUsSliderCollectionViewManager.start(data: ["",""], collectionVIew: patientsExperienceSliderBanner1CvRef)


        blogsCollectionViewManager.start(data: ["","","",""], collectionVIew: blogsFromExpertCvRef, totalItemToShow: 1.8)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.bookLabTestOuterViewRef.addGestureRecognizer(gesture)

    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        
        let vc = BookLabTest(nibName: "BookLabTest", bundle: nil)
        self.pushDelegate?.pushViewController(vc: vc)
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

        }
    }
    
    func issueConsultationApi() {
        struct demo: Codable { }
        NetWorker.shared.callAPIService(type: APIV2.FrequentSpeciality) { [weak self](data: LookinForConsultationDataResponse?, error) in
            guard self == self else { return }

            self!.categoryCollectionViewManager.start(data: data ?? [], collectionVIew: self!.consultCvRef)

        }
    }
    
    func lookingForTestInApi() {
        struct demo: Codable { }
        NetWorker.shared.callAPIService(type: APIV2.FrequentLabTest) { [weak self](data: LookingForTestInDataResponse?, error) in
            guard self == self else { return }

            self!.lookingForTestInCollectionViewManager.start(data: data ?? [], collectionVIew: self!.lookingForTestCvRef, totalItemToShow: 3.2)

        }
    }

    func lookingForMedicineInApi() {
        struct demo: Codable { }
        NetWorker.shared.callAPIService(type: APIV2.FrequentLabTest) { [weak self](data: LookingForTestInDataResponse?, error) in
            guard self == self else { return }

            self!.collectionViewManager.start(data: data ?? [], collectionVIew: self!.medicineYouAreLookingCvRef, totalItemToShow: 2.5)

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

typealias LookingForTestInDataResponse = [LookingForTestInDataResponseElement]
