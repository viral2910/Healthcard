//
//  BookLabTestCell.swift
//  HealthCard
//
//  Created by Viral on 26/04/22.
//

import UIKit

protocol BookLabDelegate {
    func getTestId(DocId: Int,LabInvest:Int,docType:String,indexPathRow:Int)
}

class BookLabTestCell: UITableViewCell {
    
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var consDrLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    var delegate:BookLabDelegate!
    var labListData : [LabTestDtlslist] = []
    var selectedID : [Int] = []
    var LabID : [Int] = []
    var LabDocType : [String] = []
    var tableviewreload = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainview.layer.cornerRadius = 10
        mainview.dropShadow()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "LabTestCell", bundle: nil), forCellReuseIdentifier: "LabTestCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension BookLabTestCell : UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "LabTestCell") as! LabTestCell
        cell.titleLabel.text = labListData[indexPath.row].labTestText ?? ""
        let url = URL(string: "\(labListData[indexPath.row].labTestImageURL ?? "")")!
        if selectedID.contains(labListData[indexPath.row].labTestID ?? 0) && LabID.contains(Int(labListData[indexPath.row].docID ?? "") ?? 0){
            cell.selectionImageView.image = UIImage(named: "checkedcircle");
        } else {
            cell.selectionImageView.image = UIImage(named: "circle");
        }
        cell.subtitleLabel.text = "\(labListData[indexPath.row].collectionIn ?? "")"
        cell.testImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "lab.jpeg"))
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.getTestId(DocId: labListData[indexPath.row].labTestID ?? 0, LabInvest: Int(labListData[indexPath.row].docID ?? "") ?? 0, docType: labListData[indexPath.row].docType ?? "", indexPathRow: contentView.tag)
    }
}
