//
//  SymptomsInsideTableViewCell.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 13/04/22.
//

import UIKit

class SymptomsInsideTableViewCell: UITableViewCell {
    @IBOutlet weak var viewRef: UIView!
    @IBOutlet weak var lblRef: UILabel!
    @IBOutlet weak var imgViewRef: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
