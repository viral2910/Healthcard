//
//  MyConsultationCell.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

class MyConsultationCell: UITableViewCell {

    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var consultDateLbl: UILabel!
    @IBOutlet weak var FromTimeLbl: UILabel!
    @IBOutlet weak var ToTimeLbl: UILabel!
    @IBOutlet weak var DocNameLbl: UILabel!
    @IBOutlet weak var paymentMethodLbl: UILabel!
    @IBOutlet weak var paymentAmtLbl: UILabel!
    @IBOutlet weak var getInvoiceBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
      
        layerView.dropShadowTVC()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
