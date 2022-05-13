//
//  BookMedicineCell.swift
//  HealthCard
//
//  Created by Viral on 07/05/22.
//

import UIKit

protocol BookMedicineDelegate {
    func getTestId(value : [Int])
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
        cell.prescriptionLabel.text = (labListData[indexPath.row].isPrescription) //? "Yes" : "No"
//        cell.subtitleLabel.text = labListData[indexPath.row].
        let url = URL(string: "\(labListData[indexPath.row].drugImageURL)")!
//        if selectedID.contains(labListData[indexPath.row].id)
//        {
//            cell.selectionImageView.image = UIImage(named: "checkedcircle");
//        }
//        else
//        {
//            cell.selectionImageView.image = UIImage(named: "circle");
//        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                cell.testImageView.image = image
            }
        }.resume()
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if selectedID.contains(labListData[indexPath.row].id) {
//            if let index = selectedID.firstIndex(of: labListData[indexPath.row].id) {
//                selectedID.remove(at: index)
//            }
//        } else {
//            selectedID.append(labListData[indexPath.row].id)
//        }
        delegate.getTestId(value: selectedID)
        tableview.reloadData()
    }
}
