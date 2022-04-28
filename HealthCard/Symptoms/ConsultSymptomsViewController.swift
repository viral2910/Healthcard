//
//  ConsultSymptomsViewController.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 13/04/22.
//

import UIKit

class ConsultSymptomsViewController: UIViewController, XIBed {
    @IBOutlet weak var searchViewRef: UIView!
    @IBOutlet weak var searchTfRef: UITextField!
    @IBOutlet weak var searchBtnRef: UIButton!
    @IBOutlet weak var tvRef: UITableView!
    
    private lazy var tableViewManager = { ConsultSymptomsTableViewManager(tableVIew: tvRef) }()
    
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
extension ConsultSymptomsViewController {
    func setupUI() {
        

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
extension ConsultSymptomsViewController {
    
    @IBAction func searchBtnTap(_ sender: UIButton) {
        
    }
}

//MARK: - API CALL
extension ConsultSymptomsViewController {
    func apiCall() {
        struct demo: Codable { }
        
        NetWorker.shared.callAPIService(type: APIV2.Symptoms) { [weak self](data: SymptomsDataResponse?, error) in
         
            self!.tableViewManager.start(data: data ?? [])

        }
    }
}
