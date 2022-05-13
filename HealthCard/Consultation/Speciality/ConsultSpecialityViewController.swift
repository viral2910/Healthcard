//
//  ConsultSpecialityViewController.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 12/04/22.
//

import UIKit
import DropDown

class ConsultSpecialityViewController: UIViewController, XIBed {
    @IBOutlet weak var searchViewRef: UIView!
    @IBOutlet weak var searchTfRef: UITextField!
    @IBOutlet weak var searchBtnRef: UIButton!
    @IBOutlet weak var tvRef: UITableView!
    @IBOutlet weak var cvRef: UICollectionView!
    @IBOutlet weak var cvHeightRef: NSLayoutConstraint!
    @IBOutlet weak var proceedBtnRef: UIButton!

    private lazy var tableViewManager = { ConsultSpecialityTableViewManager(tableVIew: tvRef) }()
    
    var pushDelegate: PushViewControllerDelegate?
    var presentDelegate: presentViewControllersDelegate?
    
    let searchDropDown = DropDown()
    
    var selectedSearchSymptom: [String] = []
    
    var specializationId = 0
    
    private lazy var collectionViewManager = { SelectedIssueCollectionViewManager() }()
    
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
extension ConsultSpecialityViewController {
    func setupUI() {
        
        collectionViewManager.delegate = self
        
        collectionViewManager.start(collectionView: cvRef, storyData: selectedSearchSymptom, divideElementBy: 2.0)
        let cellCount = selectedSearchSymptom.count
        
        print(cellCount)
        let count:CGFloat = CGFloat(cellCount)
        let counts:CGFloat = count/2.0
        let roundedValue = ceil(counts)

        cvHeightRef.constant = roundedValue * 60
        
        tableViewManager.presentDelegate = presentDelegate
        tableViewManager.pushDelegate = pushDelegate
        
        apiCall()

        searchTfRef.addTarget(self, action: #selector(self.textFieldValueChanged(_:)), for: UIControl.Event.editingChanged)

        if selectedSearchSymptom.count == 0 {
            proceedBtnRef.isHidden = true
        } else {
            proceedBtnRef.isHidden = false
        }
    }
    
    func setupCornerShadow() {
        
        searchViewRef.layer.borderWidth = 2.0
        searchViewRef.layer.borderColor = UIColor.init(hexString: "007AB8").cgColor
        
        searchViewRef.layer.cornerRadius = searchViewRef.bounds.height * 0.5
        searchBtnRef.layer.cornerRadius = searchBtnRef.bounds.height * 0.5

        proceedBtnRef.layer.cornerRadius = proceedBtnRef.bounds.height * 0.5
        proceedBtnRef.dropBtnShadow()
    }
    


}

//MARK: - Action
extension ConsultSpecialityViewController {
    @IBAction func searchBtnTap(_ sender: UIButton) {
        
    }
    
    @objc func textFieldValueChanged(_ textField: UITextField)
    {
        searchSymptomsApiCall(searchVal: searchTfRef.text ?? "")
        
    }
    
    @IBAction func proceedtBtnTap(_ sender: UIButton) {
        if selectedSearchSymptom.count != 0 {
        let vc = ConsultationProcessViewController.instantiate()
        vc.selectedIssueArr = selectedSearchSymptom
            vc.specializationId = specializationId
            self.pushDelegate?.pushViewController(vc: vc)
        }
    }
}

//MARK: - API CALL
extension ConsultSpecialityViewController {
    func apiCall() {
        struct demo: Codable { }
        
        NetWorker.shared.callAPIService(type: APIV2.Specialization) { [weak self](data: SpecilizationResponse?, error) in
         
            self!.tableViewManager.start(data: data ?? [])

        }
    }
    
    func searchSymptomsApiCall(searchVal: String) {
        struct demo: Codable { }
        
        NetWorker.shared.callAPIService(type: APIV2.SymptomsSearching(searchVal: searchVal)) { [weak self](data: [SymptomsDataResponseElement]?, error) in
         
            var searchData:[String] = []
            guard let data = data else { return }
            for searchVal in data {
                searchData.append(searchVal.concern ?? "")
            }
            
            // The list of items to display. Can be changed dynamically
            self?.searchDropDown.dataSource = searchData
            
            self?.searchDropDown.show()
            self?.searchDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self?.selectedSearchSymptom.append(item)
                self?.specializationId = Int(data[index].concernCatagoryID ?? "") ?? 0

                if self!.selectedSearchSymptom.count == 0 {
                    self!.proceedBtnRef.isHidden = true
                } else {
                    self!.proceedBtnRef.isHidden = false
                }
                
                let cellCount = self!.selectedSearchSymptom.count
                
                print(cellCount)
                let count:CGFloat = CGFloat(cellCount)
                let counts:CGFloat = count/2.0
                let roundedValue = ceil(counts)

                self!.cvHeightRef.constant = roundedValue * 60
                self?.collectionViewManager.start(collectionView: self!.cvRef, storyData: self!.selectedSearchSymptom, divideElementBy: 2.0)

            }
            
            // The view to which the drop down will appear on
            self?.searchDropDown.anchorView = self!.searchViewRef

            self?.searchDropDown.bottomOffset = CGPoint(x: 0, y:(self?.searchDropDown.anchorView?.plainView.bounds.height)!)
        }
    }
}

//MARK: - Selected Issue
extension ConsultSpecialityViewController: removeSelectedIssue {
    
    func removeIssueAtIndex(index: Int) {
        selectedSearchSymptom.remove(at: index)
        
        if selectedSearchSymptom.count == 0 {
            proceedBtnRef.isHidden = true
        } else {
            proceedBtnRef.isHidden = false
        }
        
        let cellCount = selectedSearchSymptom.count
        
        print(cellCount)
        let count:CGFloat = CGFloat(cellCount)
        let counts:CGFloat = count/2.0
        let roundedValue = ceil(counts)

        cvHeightRef.constant = roundedValue * 60
    
        
        collectionViewManager.start(collectionView: cvRef, storyData: selectedSearchSymptom, divideElementBy: 2.0)
    }
    
}

// MARK: - ConcernDetailsListResponse
struct ConcernDetailsListResponse: Codable {
    let soapEnvelope: SoapEnvelope

    enum CodingKeys: String, CodingKey {
        case soapEnvelope = "soap:Envelope"
    }
}

// MARK: - SoapEnvelope
struct SoapEnvelope: Codable {
    let xmlnsXSD, xmlnsXsi, xmlnsSoap: String
    let soapBody: SoapBody

    enum CodingKeys: String, CodingKey {
        case xmlnsXSD = "_xmlns:xsd"
        case xmlnsXsi = "_xmlns:xsi"
        case xmlnsSoap = "_xmlns:soap"
        case soapBody = "soap:Body"
    }
}

// MARK: - SoapBody
struct SoapBody: Codable {
    let concernDtlsListResponse: ConcernDtlsListResponse

    enum CodingKeys: String, CodingKey {
        case concernDtlsListResponse = "ConcernDtlsListResponse"
    }
}

// MARK: - ConcernDtlsListResponse
struct ConcernDtlsListResponse: Codable {
    let xmlns: String
    let concernDtlsListResult: ConcernDtlsListResult

    enum CodingKeys: String, CodingKey {
        case xmlns = "_xmlns"
        case concernDtlsListResult = "ConcernDtlsListResult"
    }
}

// MARK: - ConcernDtlsListResult
struct ConcernDtlsListResult: Codable {
    let concernSC: [ConcernSC]

    enum CodingKeys: String, CodingKey {
        case concernSC = "ConcernSC"
    }
}

// MARK: - ConcernSC
struct ConcernSC: Codable {
    let concernID: ConcernID
    let concernCatagory: String
    let concernDetailslist: ConcernDetailslist

    enum CodingKeys: String, CodingKey {
        case concernID = "ConcernId"
        case concernCatagory = "ConcernCatagory"
        case concernDetailslist = "ConcernDetailslist"
    }
}

// MARK: - ConcernDetailslist
struct ConcernDetailslist: Codable {
    let concernDetailsSC: [ConcernDetailsSC]

    enum CodingKeys: String, CodingKey {
        case concernDetailsSC = "ConcernDetailsSC"
    }
}

// MARK: - ConcernDetailsSC
struct ConcernDetailsSC: Codable {
    let concernID, concern, concernCatagoryID, concernCatagory: String

    enum CodingKeys: String, CodingKey {
        case concernID = "ConcernId"
        case concern = "Concern"
        case concernCatagoryID = "ConcernCatagoryId"
        case concernCatagory = "ConcernCatagory"
    }
}

// MARK: - ConcernID
struct ConcernID: Codable {
    let xsiNil: String

    enum CodingKeys: String, CodingKey {
        case xsiNil = "_xsi:nil"
    }
}
