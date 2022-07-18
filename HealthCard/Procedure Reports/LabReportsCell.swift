//
//  LabReportsCell.swift
//  HealthCard
//
//  Created by Viral on 13/07/22.
//

import UIKit

class LabReportsCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var downloadImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var prescriptionImage: UIImageView!
    @IBOutlet weak var mainview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        downloadImage.layer.cornerRadius = 5
        mainview.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
