//
//  ConsultationProcessViewController.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 30/04/22.
//

import UIKit

class ConsultationProcessViewController: UIViewController, XIBed {
    @IBOutlet weak var textViewRef: UITextView!
    @IBOutlet weak var cvRef: UICollectionView!
    @IBOutlet weak var cvHeightRef: NSLayoutConstraint!
    @IBOutlet weak var consultNowBtnRef: UIButton!
    @IBOutlet weak var submitBtnRef: UIButton!
    @IBOutlet weak var navTitleLblRef: UILabel!
    @IBOutlet weak var navViewRef: UIView!
    @IBOutlet weak var backBtnRef: UIButton!
    @IBOutlet weak var homeBtnRef: UIButton!
    
    var selectedIssueArr:[String] = []
    private lazy var collectionViewManager = { SelectedIssueCollectionViewManager() }()

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
extension ConsultationProcessViewController {
    func setupUI() {
                
        collectionViewManager.delegate = self
        
        collectionViewManager.start(collectionView: cvRef, storyData: selectedIssueArr, divideElementBy: 1.0)

        textViewRef.delegate = self
        textViewRef.text = "Type your Issue Description Here"

        textViewRef.textColor = UIColor.lightGray
        
        let cellCount = selectedIssueArr.count
        
        print(cellCount)
        let count:CGFloat = CGFloat(cellCount)
        let counts:CGFloat = count
        let roundedValue = ceil(counts)

        cvHeightRef.constant = roundedValue * 60

    }
    
    func setupCornerShadow() {

        submitBtnRef.layer.cornerRadius = submitBtnRef.bounds.height * 0.5
        consultNowBtnRef.layer.cornerRadius = consultNowBtnRef.bounds.height * 0.5

    }
    


}

//MARK: - Action
extension ConsultationProcessViewController {
    @IBAction func consultNowBtnTap(_ sender: UIButton) {
        let vc = DoctorAvailableListViewController.instantiate()
        vc.specializationId = specializationId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func submitBtnTap(_ sender: UIButton) {
        saveConcern(patientId: 1, concernId: specializationId, concernDesc: textViewRef.text ?? "")
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
extension ConsultationProcessViewController {
    func saveConcern(patientId: Int, concernId: Int, concernDesc: String) {
        struct demo: Codable { }
        NetWorker.shared.callAPIService(type: APIV2.PatientConcernSave(patientId: patientId, concernId: concernId, concernDesc: concernDesc)) { [weak self](data: demo?, error) in
            guard self == self else { return } 
        }
        
    }
}

//MARK: - Selected Issue
extension ConsultationProcessViewController: removeSelectedIssue {
    
    func removeIssueAtIndex(index: Int) {
        selectedIssueArr.remove(at: index)
        
        let cellCount = selectedIssueArr.count
        
        print(cellCount)
        let count:CGFloat = CGFloat(cellCount)
        let counts:CGFloat = count
        let roundedValue = ceil(counts)

        cvHeightRef.constant = roundedValue * 60
    
        
        collectionViewManager.start(collectionView: cvRef, storyData: selectedIssueArr, divideElementBy: 1.0)
    }
    
}

//MARK: - Textview Delegate
extension ConsultationProcessViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textViewRef.textColor == UIColor.lightGray {
            textViewRef.text = ""
            textViewRef.textColor = UIColor.black
        }
        
        if validate(textView: textViewRef) || textViewRef.text !=  "Type your Issue Description Here"{
           // nextBtnRef.isHidden = false
        }
        
        //textViewRef.adjustUITextViewHeight()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if validate(textView: textViewRef) == false {
            
            textViewRef.text = "Type your Issue Description Here"
            textViewRef.textColor = UIColor.lightGray
        }
    }
    
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//
//        return textView.text.count + (text.count - range.length) <= 250
//
//    }
    
    func textViewDidChange(_ textView: UITextView) {
        //writeHowYouFeelTextViewCountLblRef.text = "\(textView.text.count) / 250"
    }
    
    func validate(textView: UITextView) -> Bool {
        guard let text = textView.text,
            !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
            // this will be reached if the text is nil (unlikely)
            // or if the text only contains white spaces
            // or no text at all
            return false
        }

        return true
    }
    
}

extension UITextView {
    func adjustUITextViewHeight() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
}
