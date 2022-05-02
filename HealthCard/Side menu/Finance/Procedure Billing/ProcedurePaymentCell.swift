//
//  ProcedurePaymentCell.swift
//  HealthCard
//
//  Created by Dhairya on 30/04/22.
//

import UIKit

class ProcedurePaymentCell: UITableViewCell {

    @IBOutlet weak var filledBillingAmtLbl: UILabel!
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var totalAmtLbl: UILabel!
    @IBOutlet weak var receivedAmtLbl: UILabel!
    @IBOutlet weak var advPaidLbl: UILabel!
    @IBOutlet weak var discountsLbl: UILabel!
    @IBOutlet weak var procedureNameLbl: UILabel!
    @IBOutlet weak var invoiceReleaseDate: UILabel!
    @IBOutlet weak var balanceAmtLbl: UILabel!
    @IBOutlet weak var initialAmtLbl: UILabel!
    @IBOutlet weak var invoiceNoLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layerView.dropShadowTVC()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
