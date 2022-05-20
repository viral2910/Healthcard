//
//  PharmacyCell.swift
//  HealthCard
//
//  Created by Viral on 20/05/22.
//

import UIKit

class PharmacyCell: UITableViewCell {
    
    @IBOutlet weak var discountPer: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var originalPrice: UILabel!
    @IBOutlet weak var testImageView: UIImageView!
    @IBOutlet weak var prescriptionLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var packageLabel: UILabel!
    @IBOutlet weak var doseWithUnitLabel: UILabel!
    @IBOutlet weak var genericName: UILabel!
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var mainview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainview.layer.cornerRadius = 10
        mainview.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
