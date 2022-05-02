//
//  AddressDetailsCell.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

class AddressDetailsCell: UITableViewCell {

    @IBOutlet weak var buildingLbl: UILabel!
    @IBOutlet weak var nearByLbl: UILabel!
    @IBOutlet weak var pinCodeLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var talukaLbl: UILabel!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var areaLbl: UILabel!
    @IBOutlet weak var laneLbl: UILabel!
    @IBOutlet weak var flatNoLbl: UILabel!
    @IBOutlet weak var districtLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBoxBtn.setTitle("", for: .normal)
        layerView.dropShadowTVC()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
