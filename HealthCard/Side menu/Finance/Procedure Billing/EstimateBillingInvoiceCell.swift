//
//  EstimateBillingInvoiceCell.swift
//  HealthCard
//
//  Created by Viral on 25/07/22.
//

import UIKit

class EstimateBillingInvoiceCell: UITableViewCell {

    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var procedureName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var procTypeid: UILabel!
    @IBOutlet weak var paidAmt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layerView.dropShadowTVC()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
