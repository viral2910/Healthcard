//
//  LabCell.swift
//  HealthCard
//
//  Created by Viral on 14/05/22.
//

import UIKit

class LabCell: UITableViewCell {
    
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountAmountLabel: UILabel!
    @IBOutlet weak var MRPLabel: UILabel!
    @IBOutlet weak var TestNameLabel: UILabel!
    @IBOutlet weak var labImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainview.layer.cornerRadius = 10
        mainview.dropShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
