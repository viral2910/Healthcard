//
//  AddressDetailsCell.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

protocol SelectAddressDelegate {
    func getId(value : Int)
    func deleteAction(value : Int)
    func editAction(value : Int)
}
class AddressDetailsCell: UITableViewCell {

    @IBOutlet weak var selectionImage: UIImageView!
    @IBOutlet weak var editStackView: UIStackView!
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
    @IBOutlet weak var deliveryTypeLbl: UILabel!
    var delegate : SelectAddressDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layerView.dropShadowTVC()
        self.selectionStyle = .none
    }
    @IBAction func selectAddressAction(_ sender: UIButton) {
        delegate.getId(value: sender.tag)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func editAction(_ sender: UIButton) {
        delegate.editAction(value: sender.tag)
    }
    @IBAction func deleteAction(_ sender: UIButton) {
        delegate.deleteAction(value: sender.tag)
    }
}
