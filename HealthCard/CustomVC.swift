//
//  CustomVC.swift
//  HealthCard
//
//  Created by Viral on 11/04/22.
//

import UIKit
import WebKit

class CustomVC: UIViewController {

    @IBOutlet weak var Webview: WKWebView!
    var value = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if value == 0 {
            self.title = ""
            let urlval = URL(string: "")
            let urlrequest = URLRequest(url: urlval!)
            Webview.load(urlrequest)
        }

        // Do any additional setup after loading the view.
    }

}
