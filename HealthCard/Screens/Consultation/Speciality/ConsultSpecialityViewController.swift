//
//  ConsultSpecialityViewController.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 12/04/22.
//

import UIKit

class ConsultSpecialityViewController: UIViewController, XIBed {
    @IBOutlet weak var searchViewRef: UIView!
    @IBOutlet weak var searchTfRef: UITextField!
    @IBOutlet weak var searchBtnRef: UIButton!
    @IBOutlet weak var tvRef: UITableView!
    
    private lazy var tableViewManager = { ConsultSpecialityTableViewManager(tableVIew: tvRef) }()
    
    var pushDelegate: PushViewControllerDelegate?
    var presentDelegate: presentViewControllersDelegate?
    
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
        
        tableViewManager.start(data: ["","","","","",""])

        tableViewManager.presentDelegate = presentDelegate
        tableViewManager.pushDelegate = pushDelegate
        
        apiCall()

    }
    
    func setupCornerShadow() {
        
        searchViewRef.layer.borderWidth = 2.0
        searchViewRef.layer.borderColor = UIColor.init(hexString: "007AB8").cgColor
        
        searchViewRef.layer.cornerRadius = searchViewRef.bounds.height * 0.5
        searchBtnRef.layer.cornerRadius = searchBtnRef.bounds.height * 0.5

        
    }
    


}

//MARK: - Action
extension ConsultSpecialityViewController {
    @IBAction func searchBtnTap(_ sender: UIButton) {
        
    }
}

//MARK: - API CALL
extension ConsultSpecialityViewController {
    func apiCall() {
        struct demo: Codable { }
        
        NetWorker.shared.callAPIService(type: APIV2.concernDetailsList) { [weak self](data: ConcernDetailsListResponse?, error) in
            print(data?.soapEnvelope.soapBody.concernDtlsListResponse)
        }
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
