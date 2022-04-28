//
//  InsuranceVC.swift
//  HealthCard
//
//  Created by Viral on 11/04/22.
//

import UIKit

class InsuranceVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "ProfileTableviewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableviewCell")
    }
}
extension InsuranceVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "ProfileTableviewCell") as! ProfileTableviewCell
        if indexPath.row % 2 == 0 {
            cell.mainview.backgroundColor = .white
        } else {
            if #available(iOS 13.0, *) {
                cell.mainview.backgroundColor = .systemGray5
            } else {
                // Fallback on earlier versions
            }
            switch indexPath.row {
            case 0:
                cell.nameLabel.text = "Insurance Company"
                cell.valueLabel.text = ""
            case 1:
                cell.nameLabel.text = "Amount Covered"
                cell.valueLabel.text = ""
            default:
                break
            }
        }
        return cell
    }
}
