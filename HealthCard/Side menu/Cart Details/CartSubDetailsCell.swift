//
//  CartSubDetailsCell.swift
//  HealthCard
//
//  Created by Viral on 10/05/22.
//

import UIKit


protocol cartSubDetailsDelegate {
    func getId(cartId : Int)
    func updateQty(id : Int,qty:Int)
}
class CartSubDetailsCell: UITableViewCell {

    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var qtyControlStack: UIStackView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var totalcostLbl: UILabel!
    @IBOutlet weak var MRPLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var removeClick: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    var delegate : cartSubDetailsDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 10
        mainView.dropShadow()
        // Initialization code
    }
    @IBAction func removeAction(_ sender: UIButton) {
        delegate.getId(cartId: sender.tag)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func plusAction(_ sender: UIButton) {
        let qty = (Int(qtyLabel.text ?? "") ?? 0) + 1
        delegate.updateQty(id: removeClick.tag, qty: qty)
    }
    
    @IBAction func minusAction(_ sender: UIButton) {
        let qty = (Int(qtyLabel.text ?? "") ?? 0) - 1
        delegate.updateQty(id: removeClick.tag, qty: qty)
    }
}
