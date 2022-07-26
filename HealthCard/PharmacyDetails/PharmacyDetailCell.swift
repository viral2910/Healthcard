//
//  PharmacyDetailCell.swift
//  HealthCard
//
//  Created by Viral on 20/05/22.
//

import UIKit

protocol PharmacySelectionDelegate {
    func getIdval(value : Int)
}
class PharmacyDetailCell: UITableViewCell {

    
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var AddToCartBtn: UIButton!
    @IBOutlet weak var selectionImageView: UIImageView!
    @IBOutlet weak var labNameLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    var delegate:PharmacySelectionDelegate!
    var labListData : [PharmacyDtlsSClistval] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainview.layer.cornerRadius = 10
        mainview.dropShadow()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "PharmacyCell", bundle: nil), forCellReuseIdentifier: "PharmacyCell")
        // Initialization code
    }
    @IBAction func AddToCartAction(_ sender: UIButton) {
        delegate.getIdval(value: sender.tag)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PharmacyDetailCell : UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "PharmacyCell") as! PharmacyCell
        print(Int(labListData[indexPath.row].discountPer) ?? 0)
        print("₹ \(labListData[indexPath.row].mrp)")
        cell.originalPrice.text = "₹ \(labListData[indexPath.row].mrp)"
        cell.discountPer.text = Int(labListData[indexPath.row].discountPer) ?? 0 != 0 ? " \(labListData[indexPath.row].discountPer)% Off " : ""
        cell.discountPrice.text = Int(labListData[indexPath.row].discountPer) ?? 0 != 0 ? "\(labListData[indexPath.row].discountAmount)" : ""
//        cell.mr.text = "MRP : ₹\(labListData[indexPath.row].mrp)"
        cell.brandName.text = labListData[indexPath.row].brandName
        cell.genericName.text = labListData[indexPath.row].genericName
        cell.doseWithUnitLabel.text = labListData[indexPath.row].dose
        cell.packageLabel.text = labListData[indexPath.row].package
        cell.companyLabel.text = labListData[indexPath.row].manufactureCompany
        cell.prescriptionLabel.text = (labListData[indexPath.row].isPrescription == "True") ? "Yes" : "No"
//        cell.subtitleLabel.text = labListData[indexPath.row].
        let url = URL(string: "\(labListData[indexPath.row].drugImageURL)")!
        cell.testImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "medicine.jpeg"))
        
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
