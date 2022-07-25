//
//  OPDBillingInvoiceCell.swift
//  HealthCard
//
//  Created by Viral on 25/07/22.
//

import UIKit

class OPDBillingInvoiceCell: UITableViewCell {

    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var receivedAmt: UILabel!
    @IBOutlet weak var dueAmt: UILabel!
    @IBOutlet weak var paymentHead: UILabel!
    @IBOutlet weak var Discount: UILabel!
    @IBOutlet weak var billreleaseDate: UILabel!
    @IBOutlet weak var invoiceNo: UILabel!
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
