//
//  CustomSideMenuTableViewCell.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 24/04/22.
//

import UIKit

class CustomSideMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var imgViewRef: UIImageView!
    @IBOutlet weak var lblRef: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
