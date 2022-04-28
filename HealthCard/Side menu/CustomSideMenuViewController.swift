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
    var imageArray = ["Icon yellowInfo","Icon yellowHigh-five","Icon yellowLoupe","Icon yellowCalendar","Icon yellowCalendar","Icon yellowLoupe","",""]

    weak var pushDelegate: PushViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            nameLblRef.leadingBuffer = 30.0
            nameLblRef.trailingBuffer = 20.0
            
        }
        
        func setupCorner() {

        }
    }

    //MARK:- Button Action
    extension CustomSideMenuViewController {
        @IBAction func viewAndEditProfileBtnTap(_ sender: UIButton) {

        }
    
        @IBAction func termsAndConditionBtnTap(_ sender: UIButton) {

        }

        @IBAction func privacyPolicyBtnTap(_ sender: UIButton) {

        }

        @IBAction func notificationBtnTap(_ sender: UIButton) {

        }

        @IBAction func aboutAppBtnTap(_ sender: UIButton) {

        }

        @IBAction func settingsBtnTap(_ sender: UIButton) {

        }

        @IBAction func logoutBtnTap(_ sender: UIButton) {

        }

    }
