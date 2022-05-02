//
//  AddNewAddressCell.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

class AddNewAddressCell: UITableViewCell {

    @IBOutlet weak var layerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
