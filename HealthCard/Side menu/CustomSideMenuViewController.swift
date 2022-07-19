//
//  CustomSideMenuViewController.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 24/04/22.
//

import UIKit
import MarqueeLabel

class CustomSideMenuViewController: UIViewController, XIBed , PushViewControllerDelegate {
    @IBOutlet weak var viewAndEditPofileBtnRef: UIButton!
    @IBOutlet weak var nameLblRef: MarqueeLabel!
    @IBOutlet weak var userPofileImgViewRef: UIImageView!
    @IBOutlet weak var tvRef: UITableView!
    @IBOutlet weak var tvHeightRef: NSLayoutConstraint!

    private lazy var sideMenuTableViewManager = { SideMenuTableViewManager(tableVIew: tvRef, tableViewheight: tvHeightRef) }()
    
    var titleArray = ["My Profile","Basic History","My Prescription","Finance","My Orders","My Addresses","My Consultations","My Cart"]
    var imageArray = ["My Profile","Basic history","My Prescription","Finance","My Orders","My Address","Myconsultation","My Cart"]

    weak var pushDelegate: PushViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLblRef.text = UserDefaults.standard.string(forKey: "patientFullName") ?? ""

//        nameLblRef.text = UserDefaults.standard.string(forKey: "patientName")
            setupUI()
            setupCorner()
            
        }



    }

    //MARK:- Setup
    extension CustomSideMenuViewController {
        func setupUI() {
            self.navigationController?.isNavigationBarHidden = true
            sideMenuTableViewManager.start(data: titleArray, iconData: imageArray)
            sideMenuTableViewManager.pushDelegate = self
            nameLblRef.type = .continuous
            nameLblRef.speed = .duration(4)
            nameLblRef.animationCurve = .easeInOut
            nameLblRef.fadeLength = 10.0
//            nameLblRef.leadingBuffer = 30.0
//            nameLblRef.trailingBuffer = 20.0
            
        }
        
        func setupCorner() {

        }
    }

    //MARK:- Button Action
    extension CustomSideMenuViewController {
        @IBAction func viewAndEditProfileBtnTap(_ sender: UIButton) {
            
                let vc = EditProfileVC.instantiate()
//                self.pushDelegate?.pushViewController(vc: vc)
            self.navigationController?.pushViewController(vc, animated: true)
//                print("Button Tap")
        }
    
        @IBAction func termsAndConditionBtnTap(_ sender: UIButton) {
            let vc = CustomWebViewVC(nibName: "CustomWebViewVC", bundle: nil)
            vc.screen = 0
            self.navigationController?.pushViewController(vc, animated: true)
        }

        @IBAction func privacyPolicyBtnTap(_ sender: UIButton) {
            let vc = CustomWebViewVC(nibName: "CustomWebViewVC", bundle: nil)
            vc.screen = 1
            self.navigationController?.pushViewController(vc, animated: true)

        }

        @IBAction func notificationBtnTap(_ sender: UIButton) {

        }

        @IBAction func aboutAppBtnTap(_ sender: UIButton) {
            
                let vc = CustomWebViewVC(nibName: "CustomWebViewVC", bundle: nil)
                vc.screen = 2
                self.navigationController?.pushViewController(vc, animated: true)
        }

        @IBAction func settingsBtnTap(_ sender: UIButton) {
            let singup = ChangePasswordVC(nibName: "ChangePasswordVC", bundle: nil)
            self.navigationController?.pushViewController(singup, animated: true)
        }

        @IBAction func logoutBtnTap(_ sender: UIButton) {
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            
                let singin = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "SingInVC") as! SingInVC
                self.navigationController?.pushViewController(singin, animated: true)
        }

    }
