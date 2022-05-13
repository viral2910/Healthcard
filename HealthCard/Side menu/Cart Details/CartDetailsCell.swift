//
//  CartDetailsCell.swift
//  HealthCard
//
//  Created by Dhairya on 30/04/22.
//

import UIKit

class CartDetailsCell: UITableViewCell {

    @IBOutlet weak var tableviewheight: NSLayoutConstraint!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var sellerNameLbl: UILabel!
    var ListData : [CartDtlslist] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "CartSubDetailsCell", bundle: nil), forCellReuseIdentifier: "CartSubDetailsCell")
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
extension CartDetailsCell : UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CartSubDetailsCell") as! CartSubDetailsCell
        cell.titleLbl.text = ListData[indexPath.row].productName
        cell.qtyLbl.text = "Qty: \(ListData[indexPath.row].qty)"
        cell.MRPLbl.text = ListData[indexPath.row].mrp
        cell.totalcostLbl.text = "Total Amount: \(ListData[indexPath.row].totalAmount)"
//        cell.subtitleLabel.text = labListData[indexPath.row].
        let url = URL(string: "\(ListData[indexPath.row].imageURL)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                cell.ImageView.image = image
            }
        }.resume()
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
