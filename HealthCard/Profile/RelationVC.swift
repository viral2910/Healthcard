//
//  RelationVC.swift
//  HealthCard
//
//  Created by Viral on 11/04/22.
//

import UIKit

class RelationVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.register(UINib(nibName: "RelationshipTableViewCell", bundle: nil), forCellReuseIdentifier: "RelationshipTableViewCell")
        // Do any additional setup after loading the view.
    }
}

extension RelationVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "RelationshipTableViewCell") as! RelationshipTableViewCell
        return cell
    }
}
