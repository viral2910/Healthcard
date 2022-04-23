//
//  CustomAlertPopupVC.swift
//  Level
//
//  Created by Pratik on 17/01/22.
//

import UIKit
//import SwiftGifOrigin
//import Lottie

public enum CustomAlertResult {
    case yes
    case no
}


class CustomAlertPopupVC: PannableViewController, XIBed {
    
    @IBOutlet var backgroundViewRef: UIView!
    @IBOutlet var logoutView: UIView!
    @IBOutlet var cardView: UIView!
    //@IBOutlet var alertAnimationViewRef: AnimationView!
    
    public var completion: (CustomAlertResult) -> () = { _ in }
    
    var titleText = ""
    var desc = ""
    
    var lottieJsonName = ""
    
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
    
    @objc func logoutBtnTapped() {
        
        dismissVC(alertResult: .yes)
    }
        
    private func dismissVC(alertResult: CustomAlertResult) {
        
        
        UIView.animate(withDuration: 0.4, animations: {
            
            self.dismissVCCancel()
            self.view.layoutIfNeeded()
            
        }) { (complete) in
            
            self.completion(alertResult)
            self.dismiss(animated: false)
            
        }
        
    }
    
    private func setupUI() {
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissVCCancel))
        self.backgroundViewRef.addGestureRecognizer(tapGesture)
            
        logoutView.layer.borderWidth = 2

        logoutView.layer.borderColor = UIColor.init(hexString: "5E8AE5").cgColor

        logoutView.layer.cornerRadius = 10
        
        //alertImgViewRef.image = UIImage.gif(name: alertGifName)
        //animation(animationView: alertAnimationViewRef, animationJson: lottieJsonName)
        
        logoutView.dropShadow()

        let logoutTapGesture = UITapGestureRecognizer(target: self, action: #selector(logoutBtnTapped))
        logoutTapGesture.cancelsTouchesInView = false
        logoutView.addGestureRecognizer(logoutTapGesture)
        
        self.view.layoutIfNeeded()
    }

//    func animation(animationView: AnimationView, animationJson: String){
//        animationView.animation = Animation.named(animationJson)
//        animationView.loopMode = .loop
//        animationView.contentMode = .scaleAspectFill
//        animationView.play()
//
//    }
    
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
