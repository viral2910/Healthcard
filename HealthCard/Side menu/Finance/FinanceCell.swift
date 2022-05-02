//
//  FinanceCell.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

class FinanceCell: UITableViewCell {

    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var financeImg: UIImageView!
    @IBOutlet weak var financeDataLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layerView.dropShadowTVC()
        self.selectionStyle = .none
    }

   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
