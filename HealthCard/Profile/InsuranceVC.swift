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
                cell.mainview.backgroundColor = .lightGray
        }
        return cell
    }
}
