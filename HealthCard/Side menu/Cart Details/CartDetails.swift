//
//  CardDetails.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

class CartDetails: UIViewController {

    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var totalRsLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func payBtn(_ sender: UIButton) {
        
    }
}
