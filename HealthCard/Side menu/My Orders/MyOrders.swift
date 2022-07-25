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
    var selected = "Out For Delivery"
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
        
            let vc = CartDetails.instantiate()
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "All Order", style: .default , handler:{ (UIAlertAction)in
            self.selected = "All Order"
            self.apiCall()
        }))
        
        alert.addAction(UIAlertAction(title: "Delivered", style: .default , handler:{ (UIAlertAction)in
            self.selected = "Delivered"
            self.apiCall()
        }))
        
        alert.addAction(UIAlertAction(title: "Out For Delivery", style: .default , handler:{ (UIAlertAction)in
            self.selected = "Out For Delivery"
            self.apiCall()
        }))
        
        alert.addAction(UIAlertAction(title: "Not Pick Up", style: .default, handler:{ (UIAlertAction)in
            self.selected = "Not Pick Up"
            self.apiCall()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelled", style: .default, handler:{ (UIAlertAction)in
            self.selected = "Cancelled"
            self.apiCall()
        }))
        
        alert.addAction(UIAlertAction(title: "Open", style: .default, handler:{ (UIAlertAction)in
            self.selected = "Open"
            self.apiCall()
        }))
        
        alert.addAction(UIAlertAction(title: "Canecel", style: .cancel, handler:{ (UIAlertAction)in

        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
}

extension MyOrders{
    
    //MARK: - API CALL
    func apiCall()  {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        self.selected = selected.replacingOccurrences(of: " ", with: "%20")
        NetWorker.shared.callAPIService(type: APIV2.myOrderList(patientID: patientID,orderstatus: selected)) { [weak self](data: [orderList]?, error) in
            if data!.count > 0 {
                for item in  data! {
                    if item.orderDetailslist.count > 1 {
                        for val in item.orderDetailslist {
                            self?.dataValue.append(val)
                        }
                    } else {
                        self?.dataValue.append(item.orderDetailslist[0])
                    }
                }
                
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
        cell.summaryurl = dataValue[indexPath.row].orderSummaryReportLink
        cell.invoiceurl = dataValue[indexPath.row].orderInvoiceReportLink
        let url = URL(string: "\(dataValue[indexPath.row].imageURL)")!
        cell.productImage.sd_setImage(with: url, placeholderImage: UIImage(named: "lab.jpeg"))
        cell.delegate = self
        cell.viewonmapBtn.tag = indexPath.row
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValue.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MyOrders:TrackOnMap {
    func getId(value: Int) {
        if dataValue[value].sellerLatitude != "" {
            let vc = driverRouteViewController.instantiate()
            vc.lati = Double(dataValue[value].patientLatitude) ?? 0.0
            vc.longi = Double(dataValue[value].patientLongitude) ?? 0.0
            vc.latdriver = Double(dataValue[value].sellerLatitude) ?? 0.0
            vc.longdriver = Double(dataValue[value].sellerLongitude) ?? 0.0
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            AppManager.shared.showAlert(title: "Error", msg: "Driver Not assigned", vc: self)
        }
    }
}
