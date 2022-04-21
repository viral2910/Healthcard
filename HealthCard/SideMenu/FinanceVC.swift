//
//  FinanceVC.swift
//  HealthCard
//
//  Created by Viral on 13/04/22.
//

import UIKit

class FinanceVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "FinanceCell", bundle: nil), forCellReuseIdentifier: "FinanceCell")
    }
}

extension FinanceVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "FinanceCell") as! FinanceCell
        return cell
    }
}
