//
//  BookMedicineCell.swift
//  HealthCard
//
//  Created by Viral on 07/05/22.
//

import UIKit

protocol BookMedicineDelegate {
    func getTestId(DocId: Int,LabInvest:Int,docType:String,prescriptionReq:String,indexPathRow:Int)
}

class BookMedicineCell: UITableViewCell {
    
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var consDrLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    var delegate:BookMedicineDelegate!
    var labListData : [PharmacyDtlsSClist] = []
    var selectedID : [Int] = []
    var LabID : [Int] = []
    var LabDocType : [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        mainview.layer.cornerRadius = 10
        mainview.dropShadow()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "MedicineCell", bundle: nil), forCellReuseIdentifier: "MedicineCell")
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension BookMedicineCell : UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "MedicineCell") as! MedicineCell
        cell.brandName.text = labListData[indexPath.row].brandName
        cell.genericName.text = labListData[indexPath.row].genericName
        cell.doseWithUnitLabel.text = labListData[indexPath.row].dose
        cell.packageLabel.text = labListData[indexPath.row].package
        cell.companyLabel.text = labListData[indexPath.row].manufactureCompany
        cell.prescriptionLabel.text = (labListData[indexPath.row].isPrescription == "True") ? "Yes" : "No"
//        cell.subtitleLabel.text = labListData[indexPath.row].
        let url = URL(string: "\(labListData[indexPath.row].drugImageURL ?? "")")!
        
        cell.testImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "medicine.jpeg"))
        if selectedID.contains(Int(labListData[indexPath.row].medicineID ?? "") ?? 0) && LabID.contains(Int(labListData[indexPath.row].docID ?? "") ?? 0){
            cell.selectionImageView.image = UIImage(named: "checkedcircle");
        } else {
            cell.selectionImageView.image = UIImage(named: "circle");
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.getTestId(DocId: Int(labListData[indexPath.row].medicineID ?? "") ?? 0, LabInvest: Int(labListData[indexPath.row].docID ?? "") ?? 0, docType: labListData[indexPath.row].docType ?? "",prescriptionReq: labListData[indexPath.row].isPrescription ?? "" , indexPathRow: contentView.tag)
    }
}
