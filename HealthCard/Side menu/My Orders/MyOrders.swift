//
//  MyOrders.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

class MyOrders: UIViewController , XIBed{

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var filterBtn: UIButton!
    var dataValue = [OrderDetailslist]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableview.register(UINib(nibName: "OrderTrackerCell", bundle: nil), forCellReuseIdentifier: "OrderTrackerCell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorColor = .clear
    }
    override func viewWillAppear(_ animated: Bool) {
        apiCall()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cartBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {
        
    }
}

extension MyOrders{

    //MARK: - API CALL
    func apiCall()  {
        let patientID = 2348//Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.myOrderList(patientID: patientID)) { [weak self](data: [orderList]?, error) in
            if data!.count > 0 {
                self?.dataValue = data![0].orderDetailslist
                self?.tableview.reloadData()
            } else {
                self?.dataValue = []
                self?.tableview.reloadData()
            }
        }
    }
}

extension MyOrders: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTrackerCell", for: indexPath)as! OrderTrackerCell
        cell.orderStatusLabel.text = dataValue[indexPath.row].orderStatus
        cell.orderNoLabel.text = dataValue[indexPath.row].orderNo
        cell.orderDateLabel.text = dataValue[indexPath.row].orderDate
        cell.productNameLabel.text = dataValue[indexPath.row].productName
        cell.sellerNameLabel.text = dataValue[indexPath.row].sellerName
        cell.orderAmtLabel.text = dataValue[indexPath.row].orderAmount
        cell.paymentModeLabel.text = dataValue[indexPath.row].paymentMethod
        cell.qtyLabel.text = "\(dataValue[indexPath.row].qty)"
        cell.pricePerUnitLabel.text = "\(dataValue[indexPath.row].pricePerUnit)"
        cell.deliveryPinCodeLabel.text = dataValue[indexPath.row].deliveryPincode
        cell.invoiceurl = dataValue[indexPath.row].orderSummaryReportLink
        let url = URL(string: "\(dataValue[indexPath.row].imageURL)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                cell.productImage.image = image
            }
        }.resume()
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValue.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
