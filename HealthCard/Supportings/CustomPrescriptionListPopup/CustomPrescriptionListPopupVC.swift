//
//  CustomPrescriptionListPopupVC.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 21/05/22.
//

import UIKit
public enum CustomPrescriptionListAlertResult {
    case add
    
}
class CustomPrescriptionListPopupVC: PannableViewController, XIBed {
    
    static func instantiate(arrData: PatientPrescriptionResponseData) -> Self {
        let vc = Self.instantiate()
        vc.arrData = arrData
        
        return vc
    }
    
    @IBOutlet var backgroundViewRef: UIView!
    @IBOutlet var cvRef: UICollectionView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var addBtnRef: UIButton!
    @IBOutlet var cancelBtnRef: UIButton!
    public var completion: (CustomPrescriptionListAlertResult) -> () = { _ in }
    
    var arrData: PatientPrescriptionResponseData = []
    
    weak var pushDelegate: PushViewControllerDelegate?
    weak var presentDelegate: presentViewControllersDelegate?
    
    private lazy var collectionViewManager = { PrescriptionListCollectionViewManager() }()
    
    var selectedId: [Int] = []
    
    var selectedPresIdDelegate: GetSelectedPrescriptionId?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
        setupUI()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundViewRef.alpha = 1
            self.view.layoutIfNeeded()
        })
        
    }
    
    @IBAction func backBtnTap(_ sender: UIButton) {
        self.dismissVCCancel()
    }
    
    @IBAction func addBtnTap(_ sender: UIButton) {
        dismissVC(alertResult: .add)
    }
    
    private func dismissVC(alertResult: CustomPrescriptionListAlertResult) {
        
        
        UIView.animate(withDuration: 0.4, animations: {
            
            self.dismissVCCancel()
            self.view.layoutIfNeeded()
            
        }) { (complete) in
            
            self.completion(alertResult)
            self.dismiss(animated: false)
            
        }
        
    }
    
    private func setupUI() {
        //cardView.layer.cornerRadius = 10
        
        addBtnRef.dropBtnShadow()
        cancelBtnRef.dropBtnShadow()
        addBtnRef.layer.cornerRadius = 10
        cancelBtnRef.layer.cornerRadius = 10
        
        collectionViewManager.start(data: arrData, collectionVIew: cvRef)
        collectionViewManager.selectedPresDelegate = self
        cardView.dropShadow()
        cardView.layer.borderColor = UIColor.init(hexString: "FAFAFA").cgColor
        cardView.layer.borderWidth = 3.0
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        cardView.backgroundColor = .white
        
        self.view.layoutIfNeeded()
    }
    
    @objc func dismissVCCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func slideViewVerticallyTo(_ y: CGFloat) {
        
        let alpha = 1 - y/44
        guard y <= 44, y >= 0, alpha <= 1 else { return }
        
        print(alpha)
        self.backgroundViewRef.alpha = alpha
        
    }

}

extension CustomPrescriptionListPopupVC: GetSelectedPrescriptionId {
    func selectedPrescriptionIds(id: [Int], imageUrl: String) {
        print("DelegateId: \(id)")
        selectedId = id
        selectedPresIdDelegate?.selectedPrescriptionIds(id: id, imageUrl: imageUrl)
    }
    
    
}
