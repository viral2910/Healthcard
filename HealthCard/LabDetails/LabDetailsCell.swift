//
//  LabDetailsCell.swift
//  HealthCard
//
//  Created by Viral on 13/05/22.
//

import UIKit

protocol LabSelectionDelegate {
    func getId(value : Int)
}
class LabDetailsCell: UITableViewCell {

    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var AddToCartBtn: UIButton!
    @IBOutlet weak var selectionImageView: UIImageView!
    @IBOutlet weak var labNameLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    var delegate:LabSelectionDelegate!
    var labListData : [LabTestDtlslistval] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainview.layer.cornerRadius = 10
        mainview.dropShadow()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "LabCell", bundle: nil), forCellReuseIdentifier: "LabCell")
        // Initialization code
    }
    @IBAction func AddToCartAction(_ sender: UIButton) {
        delegate.getId(value: sender.tag)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension LabDetailsCell : UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "LabCell") as! LabCell
        cell.TestNameLabel.text = labListData[indexPath.row].labTestText
        cell.priceLabel.text = labListData[indexPath.row].discountPer != 0 ? "₹ \(labListData[indexPath.row].charges)" : ""
        cell.discountAmountLabel.text = labListData[indexPath.row].discountPer != 0 ? " \(labListData[indexPath.row].discountPer)% Off " : ""
        cell.MRPLabel.text = "MRP : ₹\(labListData[indexPath.row].mrp)"
        let url = URL(string: "\(labListData[indexPath.row].labTestImageURL)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                cell.labImageView.image = image
            }
        }.resume()
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
