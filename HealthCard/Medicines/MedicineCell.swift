//
//  MedicineCell.swift
//  HealthCard
//
//  Created by Viral on 07/05/22.
//

import UIKit

class MedicineCell: UITableViewCell {
    
    @IBOutlet weak var testImageView: UIImageView!
    @IBOutlet weak var selectionImageView: UIImageView!
    @IBOutlet weak var prescriptionLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var packageLabel: UILabel!
    @IBOutlet weak var doseWithUnitLabel: UILabel!
    @IBOutlet weak var genericName: UILabel!
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var mainview: UIView!
    
    @IBOutlet weak var crossBtnRef: UIButton!
    
    @IBOutlet weak var MedicineTyoe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainview.layer.cornerRadius = 10
        mainview.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
