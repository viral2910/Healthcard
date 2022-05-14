//
//  CartSubDetailsCell.swift
//  HealthCard
//
//  Created by Viral on 10/05/22.
//

import UIKit


protocol cartSubDetailsDelegate {
    func getId(cartId : Int)
}
class CartSubDetailsCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var totalcostLbl: UILabel!
    @IBOutlet weak var MRPLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var removeClick: UIButton!
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

        // Configure the view for the selected state
    }
    
}
