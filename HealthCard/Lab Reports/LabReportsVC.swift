//
//  LabReportsVC.swift
//  HealthCard
//
//  Created by Viral on 13/07/22.
//

import UIKit

class LabReportsVC: UIViewController {
    var pageMenu : CAPSPageMenu?

    @IBOutlet weak var mainView: UIView!
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup()
    {
        var controllerArray : [UIViewController] = []
        let controller1 = UploadLabTestVC(nibName: "UploadLabTestVC", bundle: nil)
        controller1.title = "VIEW LAB TEST"
        controllerArray.append(controller1)
        
        let controller2 = UploadLabTestVC(nibName: "UploadLabTestVC", bundle: nil)
        controller2.title = "UPLOAD LAB TEST"
        controllerArray.append(controller2)
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(.white),
            .viewBackgroundColor(.white),
            .selectionIndicatorColor(.green),
            .bottomMenuHairlineColor(.lightGray),
            .menuItemFont(UIFont.systemFont(ofSize: 13.0)),
            .menuHeight(60.0),
            .menuItemWidth(200.0),
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
                pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.mainView.frame.width, height: self.mainView.bounds.height
                ), pageMenuOptions: parameters)
                
                print("unknown")
            }
        }
        self.addChild(pageMenu!)
        
        self.mainView.addSubview(pageMenu!.view)
        
        pageMenu!.didMove(toParent: self)
    }



}
