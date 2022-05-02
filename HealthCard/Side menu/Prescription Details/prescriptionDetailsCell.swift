//
//  prescriptionDetailsCell.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

class prescriptionDetailsCell: UITableViewCell {

    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var planningLbl: UILabel!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet weak var formImg: UIImageView!
    @IBOutlet weak var pdfLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layerView.dropShadowTVC()
        self.selectionStyle = .none
        downloadBtn.setTitle("", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    @IBAction func downloadBtn(_ sender: UIButton) {
    }
}
