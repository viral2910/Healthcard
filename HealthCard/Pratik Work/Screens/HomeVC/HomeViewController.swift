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
    
    private lazy var sliderCollectionViewManager = { SliderBannerCollectionViewManager() }()

    private lazy var blogsCollectionViewManager = { BlogsCollectionViewManager() }()

    private lazy var categoryCollectionViewManager = { CategoryCollectionViewManager() }()
    
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
extension HomeViewController {
    func setupUI() {
        


        
        collectionViewManager.delegate = self
        sliderCollectionViewManager.pushDelegate = self
        
        sliderCollectionViewManager.start(data: ["","","",""], collectionVIew: sliderBanner1CvRef)
        sliderCollectionViewManager.start(data: ["","","",""], collectionVIew: lookingForTestSliderBannerCvRef)
        sliderCollectionViewManager.start(data: ["","","",""], collectionVIew: medicineYouAreLookingSliderBanner1CvRef)
        sliderCollectionViewManager.start(data: [""], collectionVIew: medicineYouAreLookingSliderBanner2CvRef)
        sliderCollectionViewManager.start(data: ["","","",""], collectionVIew: lookingForConsultationsInSliderBanner1CvRef)
        sliderCollectionViewManager.start(data: [""], collectionVIew: lookingForConsultationsInSliderBanner2CvRef)
        sliderCollectionViewManager.start(data: ["","","",""], collectionVIew: patientsExperienceSliderBanner1CvRef)

        collectionViewManager.start(data: ["","","","","","","",""], collectionVIew: lookingForTestCvRef, totalItemToShow: 3.2)
        collectionViewManager.start(data: ["","","","","","","",""], collectionVIew: medicineYouAreLookingCvRef, totalItemToShow: 2.5)

        blogsCollectionViewManager.start(data: ["","","",""], collectionVIew: blogsFromExpertCvRef, totalItemToShow: 1.8)
        
        categoryCollectionViewManager.start(data: ["sfvfzgvd","dgbdsggd","ryhdyd","fzbddgbdgsbgbsbg","dfhdgbfdgnfsfs"], collectionVIew: consultCvRef)
        categoryCollectionViewManager.start(data: ["sfvfzgvd","dgbdsggd","ryhdyd","fzbddgbdgsbgbsbg","dfhdgbfdgnfsfs"], collectionVIew: lookingForConsultationsInCvRef)

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
    
//    func sliderApi() {
//
//        NetWorker.shared.callAPIService(type: APIV2.dashboardSlider) { [weak self](data: DashboardSliderResponse?, error) in
//            guard self == self else { return }
//
//            self?.sliderCollectionViewManager.start(data: data?.data ?? [], collectionVIew: self!.sliderCvRef)
//        }
//    }
    
}

//MARK: - Action
extension HomeViewController {
    @IBAction func sideMenuBtnTap(_ sender: UIButton) {
        
    }
    
    @IBAction func cartBtnTap(_ sender: UIButton) {
        
    }
}
