//
//  LabTestCell.swift
//  HealthCard
//
//  Created by Viral on 26/04/22.
//

import UIKit

class LabTestCell: UITableViewCell {

    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var testImageView: UIImageView!
    @IBOutlet weak var selectionImageView: UIImageView!
    
    @IBOutlet weak var crossBtnRef: UIButton!

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
