//
//  BookLabTestCell.swift
//  HealthCard
//
//  Created by Viral on 26/04/22.
//

import UIKit

class BookLabTestCell: UITableViewCell {
    
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var consDrLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainview.layer.cornerRadius = 10
        mainview.dropShadow()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "LabTestCell", bundle: nil), forCellReuseIdentifier: "LabTestCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension BookLabTestCell : UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "LabTestCell") as! LabTestCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
