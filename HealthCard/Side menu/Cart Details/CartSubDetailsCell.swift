//
//  CartSubDetailsCell.swift
//  HealthCard
//
//  Created by Viral on 10/05/22.
//

import UIKit

class CartSubDetailsCell: UITableViewCell {

    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var totalcostLbl: UILabel!
    @IBOutlet weak var MRPLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
