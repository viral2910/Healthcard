//
//  RelationshipTableViewCell.swift
//  HealthCard
//
//  Created by Viral on 11/04/22.
//

import UIKit

class RelationshipTableViewCell: UITableViewCell {

    @IBOutlet weak var relationLabel: UILabel!
    @IBOutlet weak var patientNoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
