//
//  MyConsultationCell.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

protocol consultationDelegate {
    func getInvoiceFunction(value : Int)
}
class MyConsultationCell: UITableViewCell {

    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var consultDateLbl: UILabel!
    @IBOutlet weak var FromTimeLbl: UILabel!
    @IBOutlet weak var ToTimeLbl: UILabel!
    @IBOutlet weak var DocNameLbl: UILabel!
    @IBOutlet weak var paymentMethodLbl: UILabel!
    @IBOutlet weak var paymentAmtLbl: UILabel!
    @IBOutlet weak var getInvoiceBtn: UIButton!
    
    var delegate:consultationDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        getInvoiceBtn.layer.borderColor = UIColor.init(hexString: "007AB8").cgColor
        getInvoiceBtn.layer.borderWidth = 2
        getInvoiceBtn.layer.cornerRadius = 20
        layerView.dropShadowTVC()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func getInvoiceAction(_ sender: UIButton) {
        delegate.getInvoiceFunction(value: sender.tag)
    }
}
