//
//  CartDetailsCell.swift
//  HealthCard
//
//  Created by Dhairya on 30/04/22.
//

import UIKit

protocol cartDetailsDelegate {
    func getId(id : Int)
}
class CartDetailsCell: UITableViewCell, cartSubDetailsDelegate {
    
    

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableviewheight: NSLayoutConstraint!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var sellerNameLbl: UILabel!
    var ListData : [CartDtlslist] = []
    var delegate : cartDetailsDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.layer.cornerRadius = 10
        mainView.dropShadow()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "CartSubDetailsCell", bundle: nil), forCellReuseIdentifier: "CartSubDetailsCell")
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func getId(cartId: Int) {
        self.delegate.getId(id: cartId)
    }
    
}
extension CartDetailsCell : UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CartSubDetailsCell") as! CartSubDetailsCell
        cell.titleLbl.text = ListData[indexPath.row].productName
        cell.MRPLbl.text = "₹\(ListData[indexPath.row].mrp)/unit"
        cell.totalcostLbl.text = "₹\(ListData[indexPath.row].totalAmount).00 X \(ListData[indexPath.row].qty) = ₹\(ListData[indexPath.row].totalAmount).00"
        cell.delegate = self
        cell.removeClick.tag = ListData[indexPath.row].cartID
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
        return 120
    }
}
