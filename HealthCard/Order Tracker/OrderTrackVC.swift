//
//  OrderTrackVC.swift
//  HealthCard
//
//  Created by Viral on 23/04/22.
//

import UIKit

class OrderTrackVC: UIViewController, XIBed, PushViewControllerDelegate {
    
    weak var pushDelegate: PushViewControllerDelegate?
    @IBOutlet weak var tableView: UITableView!
    var dataValue = [OrderDetailslist]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "OrderTrackerCell", bundle: nil), forCellReuseIdentifier: "OrderTrackerCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
    }

    override func viewWillAppear(_ animated: Bool) {
        apiCall()
    }
}

extension OrderTrackVC{

    //MARK: - API CALL
    func apiCall()  {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.orderTrackList(patientID: patientID)) { [weak self](data: [orderList]?, error) in
            if data!.count > 0 {
                self?.dataValue = data![0].orderDetailslist
                self?.tableView.reloadData()
            } else {
                self?.dataValue = []
                self?.tableView.reloadData()
            }
        }
    }
}
extension OrderTrackVC: UITableViewDelegate, UITableViewDataSource{
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
extension OrderTrackVC:TrackOnMap {
    func getId(value: Int) {
            let vc = driverRouteViewController.instantiate()
        vc.lati = Double(dataValue[value].patientLatitude) ?? 0.0
        vc.longi = Double(dataValue[value].patientLongitude) ?? 0.0
        vc.latdriver = Double(dataValue[value].sellerLatitude) ?? 0.0
        vc.longdriver = Double(dataValue[value].sellerLongitude) ?? 0.0
            self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - WelcomeElement
struct orderList: Codable {
    let orderID: Int
    let patientID, patientAddressID, orderAmount, paymentMethod: JSONNull?
    let orderDate, patientLatitude, patientLongitude, deliveryBoyLatitude: JSONNull?
    let deliveryBoyLongitude, orderType, sellerType, isActive: JSONNull?
    let orderDetailslist: [OrderDetailslist]
    let status, message: JSONNull?

    enum CodingKeys: String, CodingKey {
        case orderID = "OrderId"
        case patientID = "PatientId"
        case patientAddressID = "PatientAddressId"
        case orderAmount = "OrderAmount"
        case paymentMethod = "PaymentMethod"
        case orderDate = "OrderDate"
        case patientLatitude = "PatientLatitude"
        case patientLongitude = "PatientLongitude"
        case deliveryBoyLatitude = "DeliveryBoyLatitude"
        case deliveryBoyLongitude = "DeliveryBoyLongitude"
        case orderType = "OrderType"
        case sellerType = "SellerType"
        case isActive = "IsActive"
        case orderDetailslist = "OrderDetailslist"
        case status = "Status"
        case message = "Message"
    }
}

// MARK: - OrderDetailslist
struct OrderDetailslist: Codable {
    let orderDetailsID, orderID: Int
    let orderNo, orderDate, orderAmount, paymentMethod: String
    let orderType: String
    let patientID: Int
    let patientName: String
    let patientAddressID: Int
    let patientAddressType, patientFlatHouseNo, patientBuilding, patientLaneRoad: String
    let patientNearBy, patientTaluka, patientDistrict, patientState: String
    let patientCountry, patientPinCode, patientMobNo, patientAlternateMobNo: String
    let patientLatitude, patientLongitude: String
    let cartID, sellerMasterID: Int
    let sellerName, sellerType, sellerFlatHouseNo, sellerBuilding: String
    let sellerLaneRoad, sellerNearBy, sellerTaluka, sellerDistrict: String
    let sellerState, sellerCountry, sellerPinCode, sellerMobNo: String
    let sellerAlternateMobNo, sellerLatitude, sellerLongitude: String
    let docID, productID: Int
    let productName: String
    let qty: Int
    let mrp: String
    let discountPer, discountAmt, gstAmt, gstPer: Int
    let pricePerUnit, totalAmount: Int
    let deliveryPincode, isOrderPickup: String
    let isCashCollected: JSONNull?
    let isOrderDelivered, orderStatus: String
    let orderStatusTime, isActive, status, message: JSONNull?
    let viewOnMap, cancelOrder: String
    let imageURL: String
    let orderSummaryReportLink, orderInvoiceReportLink: String

    enum CodingKeys: String, CodingKey {
        case orderDetailsID = "OrderDetailsId"
        case orderID = "OrderId"
        case orderNo = "OrderNo"
        case orderDate = "OrderDate"
        case orderAmount = "OrderAmount"
        case paymentMethod = "PaymentMethod"
        case orderType = "OrderType"
        case patientID = "PatientId"
        case patientName = "PatientName"
        case patientAddressID = "PatientAddressId"
        case patientAddressType = "PatientAddressType"
        case patientFlatHouseNo = "PatientFlatHouseNo"
        case patientBuilding = "PatientBuilding"
        case patientLaneRoad = "PatientLaneRoad"
        case patientNearBy = "PatientNearBy"
        case patientTaluka = "PatientTaluka"
        case patientDistrict = "PatientDistrict"
        case patientState = "PatientState"
        case patientCountry = "PatientCountry"
        case patientPinCode = "PatientPinCode"
        case patientMobNo = "PatientMobNo"
        case patientAlternateMobNo = "PatientAlternateMobNo"
        case patientLatitude = "PatientLatitude"
        case patientLongitude = "PatientLongitude"
        case cartID = "CartId"
        case sellerMasterID = "SellerMasterId"
        case sellerName = "SellerName"
        case sellerType = "SellerType"
        case sellerFlatHouseNo = "SellerFlatHouseNo"
        case sellerBuilding = "SellerBuilding"
        case sellerLaneRoad = "SellerLaneRoad"
        case sellerNearBy = "SellerNearBy"
        case sellerTaluka = "SellerTaluka"
        case sellerDistrict = "SellerDistrict"
        case sellerState = "SellerState"
        case sellerCountry = "SellerCountry"
        case sellerPinCode = "SellerPinCode"
        case sellerMobNo = "SellerMobNo"
        case sellerAlternateMobNo = "SellerAlternateMobNo"
        case sellerLatitude = "SellerLatitude"
        case sellerLongitude = "SellerLongitude"
        case docID = "DocId"
        case productID = "ProductId"
        case productName = "ProductName"
        case qty = "Qty"
        case mrp = "MRP"
        case discountPer = "DiscountPer"
        case discountAmt = "DiscountAmt"
        case gstAmt = "GSTAmt"
        case gstPer = "GSTPer"
        case pricePerUnit = "PricePerUnit"
        case totalAmount = "TotalAmount"
        case deliveryPincode = "DeliveryPincode"
        case isOrderPickup = "IsOrderPickup"
        case isCashCollected = "IsCashCollected"
        case isOrderDelivered = "IsOrderDelivered"
        case orderStatus = "OrderStatus"
        case orderStatusTime = "OrderStatusTime"
        case isActive = "IsActive"
        case status = "Status"
        case message = "Message"
        case viewOnMap = "ViewOnMap"
        case cancelOrder = "CancelOrder"
        case imageURL = "ImageUrl"
        case orderSummaryReportLink = "OrderSummaryReportLink"
        case orderInvoiceReportLink = "OrderInvoiceReportLink"
    }
}
