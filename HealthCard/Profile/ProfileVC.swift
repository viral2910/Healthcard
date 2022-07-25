//
//  ProfileVC.swift
//  HealthCard
//
//  Created by Viral on 11/04/22.
//

import UIKit

class ProfileVC: UIViewController , XIBed, PushViewControllerDelegate {

    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    weak var pushDelegate: PushViewControllerDelegate?
    
    var pageMenu : CAPSPageMenu?
    var isTopConstraint = false
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
        setup()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        let controllers = self.navigationController?.viewControllers
        for vc in controllers! {
            if vc is CustomTabBarViewController {
                _ = self.navigationController?.popToViewController(vc as! CustomTabBarViewController, animated: true)
            }
        }
    }
    @IBAction func editProfileAction(_ sender: UIButton) {
        let otpvc = EditProfileVC(nibName: "EditProfileVC", bundle: nil)
        self.navigationController?.pushViewController(otpvc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        if isTopConstraint == true {
            
            let window = UIApplication.shared.windows.first
            let topPadding = window?.safeAreaInsets.top
            topConstraint.constant = (topPadding ?? 0) + 50
            mainview.isHidden = false
            
            view.layoutIfNeeded()
        } else {
                topConstraint.constant = 0
                mainview.isHidden = true
        }
        self.nameLabel.text = UserDefaults.standard.string(forKey: "patientFullName") ?? ""
    }
    func setup()
    {
        var controllerArray : [UIViewController] = []
        let controller1 = PersonalVC(nibName: "PersonalVC", bundle: nil)
        controller1.title = "PERSONAL"
        controllerArray.append(controller1)
        
        let controller2 = InsuranceVC(nibName: "InsuranceVC", bundle: nil)
        controller2.title = "INSURANCE"
        controllerArray.append(controller2)
        
        let controller3 = ProcedureReportsVC(nibName: "ProcedureReportsVC", bundle: nil)
        controller3.title = "DOCUMENTS"
        controller3.isHeaderVisible = true
        controllerArray.append(controller3)
        
        let controller4 = RelationVC(nibName: "RelationVC", bundle: nil)
        controller4.title = "RELATION"
        controllerArray.append(controller4)
        
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(.white),
            .viewBackgroundColor(.white),
            .selectionIndicatorColor(.blue),
            .bottomMenuHairlineColor(.lightGray),
            .menuItemFont(UIFont.systemFont(ofSize: 13.0)),
            .menuHeight(40.0),
            .menuItemWidth(100.0),
            .selectedMenuItemLabelColor(.black),
            .centerMenuItems(true),
            .selectionIndicatorHeight(1.0),
            .unselectedMenuItemLabelColor(.gray)
        ]
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.mainView.frame.width, height: self.mainView.frame.height
                ), pageMenuOptions: parameters)
                
                
            case 1334:
                pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.mainView.frame.width, height: self.mainView.frame.height
                ), pageMenuOptions: parameters)
                print("iPhone 6/6S/7/8")
                
            case 1920, 2208:
                pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.mainView.frame.width, height: self.mainView.frame.height
                ), pageMenuOptions: parameters)
                
                print("iPhone 6plus /6s plus /7 plus /8 plus")
                
            case 2436:
                pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.mainView.frame.width, height: self.mainView.frame.height
                ), pageMenuOptions: parameters)
                
                print("iPhone X, Xs")
                
            case 2688:
                pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.mainView.frame.width, height: self.mainView.frame.height
                ), pageMenuOptions: parameters)
                print("iPhone Xs Max")
                
            case 1792:
                pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.mainView.frame.width, height: self.mainView.frame.height
                ), pageMenuOptions: parameters)
                
                print("iPhone Xr")
                
                
            default:
                pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.mainView.frame.width, height: self.mainView.frame.height
                ), pageMenuOptions: parameters)
                
                print("unknown")
            }
        }
        self.addChild(pageMenu!)
        
        self.mainView.addSubview(pageMenu!.view)
        
        pageMenu!.didMove(toParent: self)
    }
}
