//
//  AdvanceBillingPaymentCell.swift
//  HealthCard
//
//  Created by Dhairya on 30/04/22.
//

import UIKit

class AdvanceBillingPaymentCell: UITableViewCell {

    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var balanceAmtLbl: UILabel!
    @IBOutlet weak var AdvancePaideLbl: UILabel!
    @IBOutlet weak var discountAmtLbl: UILabel!
    @IBOutlet weak var initialAmtLbl: UILabel!
    @IBOutlet weak var creationDateLbl: UILabel!
    @IBOutlet weak var procedureNameLbl: UILabel!
    @IBOutlet weak var surgeonName: UILabel!
    @IBOutlet weak var invoiceNoLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        layerView.dropShadowTVC()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
