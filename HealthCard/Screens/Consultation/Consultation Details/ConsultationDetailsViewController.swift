//
//  ConsultationDetailsViewController.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 13/04/22.
//

import UIKit

class ConsultationDetailsViewController: UIViewController , XIBed {
    @IBOutlet weak var searchViewRef: UIView!
    @IBOutlet weak var searchTfRef: UITextField!
    @IBOutlet weak var searchBtnRef: UIButton!
    @IBOutlet weak var titleRef: UILabel!
    @IBOutlet weak var viewRef: UIView!
    @IBOutlet weak var tvRef: UITableView!
    @IBOutlet weak var tvHeightRef: NSLayoutConstraint!
    @IBOutlet weak var cvRef: UICollectionView!
    @IBOutlet weak var cvHeightRef: NSLayoutConstraint!
    @IBOutlet weak var proceedBtnRef: UIButton!
    @IBOutlet weak var navTitleLblRef: UILabel!
    @IBOutlet weak var navViewRef: UIView!
    @IBOutlet weak var backBtnRef: UIButton!
    @IBOutlet weak var homeBtnRef: UIButton!


    private lazy var tableViewManager = { ConsultDetailsTableViewManager(tableVIew: tvRef, tableViewHeight: tvHeightRef) }()
    
    private lazy var collectionViewManager = { SelectedIssueCollectionViewManager() }()

    
    var pushDelegate: PushViewControllerDelegate?
    var presentDelegate: presentViewControllersDelegate?
    
    var concernList: [SymptomsDataResponseElement] = []
    
    var selectedIssueArr:[String] = []
    
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
extension ConsultationDetailsViewController {
    func setupUI() {
        
        tableViewManager.start(data: concernList)

        tableViewManager.presentDelegate = presentDelegate
        tableViewManager.pushDelegate = pushDelegate
        tableViewManager.delegate = self
        
        collectionViewManager.delegate = self

    }
    
    func setupCornerShadow() {
        
        viewRef.dropShadow()
        viewRef.layer.cornerRadius = 10
        
        searchViewRef.layer.borderWidth = 2.0
        searchViewRef.layer.borderColor = UIColor.init(hexString: "007AB8").cgColor
        
        searchViewRef.layer.cornerRadius = searchViewRef.bounds.height * 0.5
        searchBtnRef.layer.cornerRadius = searchBtnRef.bounds.height * 0.5

        proceedBtnRef.layer.cornerRadius = proceedBtnRef.bounds.height * 0.5
        
    }
    


}

//MARK: - Action
extension ConsultationDetailsViewController {
    @IBAction func searchBtnTap(_ sender: UIButton) {
        
    }
    
    @IBAction func proceedBtnTap(_ sender: UIButton) {
        if selectedIssueArr.count != 0 {
        let vc = ConsultationProcessViewController.instantiate()
        vc.selectedIssueArr = selectedIssueArr
        self.navigationController?.pushViewController(vc, animated: true)
        }
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

//MARK: - Selected Issue
extension ConsultationDetailsViewController: selectedIssueDelegate, removeSelectedIssue {
    func selectedIssue(name: String, index: Int) {
        selectedIssueArr.append(name)
        
        let cellCount = selectedIssueArr.count
        
        print(cellCount)
        let count:CGFloat = CGFloat(cellCount)
        let counts:CGFloat = count/2
        let roundedValue = ceil(counts)

        cvHeightRef.constant = roundedValue * 60
    
        
        collectionViewManager.start(collectionView: cvRef, storyData: selectedIssueArr, divideElementBy: 2.0)
    }
    
    func removeIssueAtIndex(index: Int) {
        selectedIssueArr.remove(at: index)
        
        let cellCount = selectedIssueArr.count
        
        print(cellCount)
        let count:CGFloat = CGFloat(cellCount)
        let counts:CGFloat = count/2
        let roundedValue = ceil(counts)

        cvHeightRef.constant = roundedValue * 60
    
        
        collectionViewManager.start(collectionView: cvRef, storyData: selectedIssueArr, divideElementBy: 2.0)
    }
    
}

