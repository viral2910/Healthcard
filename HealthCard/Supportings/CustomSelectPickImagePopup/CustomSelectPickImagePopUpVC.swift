//
//  CustomSelectPickImagePopUpVC.swift
//  Level
//
//  Created by Pratik Khopkar on 12/05/22.
//

import UIKit
public enum CustomPickImageAlertResult {
    case selectFromGallery
    case clickAPictureNow
}

class CustomSelectPickImagePopUpVC: PannableViewController, XIBed {
    
    static func instantiate(title: String, yesButtonTitle: String, noButtonTitle: String) -> Self {
        let vc = Self.instantiate()
        vc.titleText = title
        vc.yesBtnTitle = yesButtonTitle
        vc.noBtnTitle = noButtonTitle
        return vc
    }
    
    @IBOutlet var backgroundViewRef: UIView!
    @IBOutlet var selectFromGalleryButton: UIButton!
    @IBOutlet var takeAPictureNowButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var cardView: UIView!
    
    public var completion: (CustomPickImageAlertResult) -> () = { _ in }
    
    var titleText = ""
    var desc = ""
    
    var yesBtnTitle = ""
    var noBtnTitle = ""
    var lottieJsonName = ""
    var isYesButtonVisible = true
    
    var isAddCoins = false
    
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
    
    @IBAction func selectFromGalleryBtnTapped(_ sender: UIButton) {
        
        dismissVC(alertResult: .selectFromGallery)
    }
    
    @IBAction func clickAPictureNowBtnTapped(_ sender: UIButton) {
        dismissVC(alertResult: .clickAPictureNow)
    }
    
    @IBAction func backBtnTap(_ sender: UIButton) {
        self.dismissVCCancel()
    }
    
    private func dismissVC(alertResult: CustomPickImageAlertResult) {
        
        
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
        
        titleLabel.text = titleText
                
        selectFromGalleryButton.layer.borderWidth = 2
        takeAPictureNowButton.layer.borderWidth = 2

        selectFromGalleryButton.layer.borderColor = UIColor.init(hexString: "FFFFFF").cgColor
        takeAPictureNowButton.layer.borderColor = UIColor.init(hexString: "FFFFFF").cgColor

        selectFromGalleryButton.layer.cornerRadius = 10
        takeAPictureNowButton.layer.cornerRadius = 10
                
        selectFromGalleryButton.dropBtnShadow()
        takeAPictureNowButton.dropBtnShadow()
        
        selectFromGalleryButton.setTitle(yesBtnTitle, for: .normal)
        takeAPictureNowButton.setTitle(noBtnTitle, for: .normal)
        
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

