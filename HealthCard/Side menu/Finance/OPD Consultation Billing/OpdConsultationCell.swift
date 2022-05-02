//
//  OpdConsultationCell.swift
//  HealthCard
//
//  Created by Dhairya on 30/04/22.
//

import UIKit

class OpdConsultationCell: UITableViewCell {

    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var doctorNameLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var amountDueLbl: UILabel!
    @IBOutlet weak var totalDiscountLbl: UILabel!
    @IBOutlet weak var billReleaseDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layerView.dropShadowTVC()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
