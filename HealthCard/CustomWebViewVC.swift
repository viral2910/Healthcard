//
//  CustomWebViewVC.swift
//  HealthCard
//
//  Created by Viral on 08/05/22.
//

import UIKit
import WebKit

class CustomWebViewVC: UIViewController {

    var screen = 0
    @IBOutlet weak var webview: WKWebView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "AppColor")
        if screen == 0 {
            webview.load(URLRequest(url: URL(string: "https://acssel.com/Terms-and-conditions-Healthcard-200821.pdf")!))
            self.title = "Terms and Condition"
        } else if screen == 1 {
            webview.load(URLRequest(url: URL(string: "https://acssel.com/Policy-Healthcard-200821.pdfn")!))
            self.title = "Privacy Policy"
        } else if screen == 2 {
            webview.load(URLRequest(url: URL(string: "https://acssel.com/about-healthcard-hcp.php")!))
            self.title = "About App"
        }

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

}
