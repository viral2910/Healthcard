//
//  HomeVC.swift
//  HealthCard
//
//  Created by Viral on 03/04/22.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        // Do any additional setup after loading the view.
    }
    @IBAction func btnaction(_ sender: Any) {
        let Profilevc =  ProfileVC(nibName: "ProfileVC", bundle: nil)
        self.navigationController?.pushViewController(Profilevc, animated: true)
    }
    

}
