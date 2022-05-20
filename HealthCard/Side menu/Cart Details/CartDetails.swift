//
//  CardDetails.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

class CartDetails: UIViewController,XIBed {

    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var totalRsLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var dataValue = [cartDetails]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableCell()
        apiCall()
    }
    
    
    /// TableViewCell Setup
    private func setupTableCell(){
        tableView.register(UINib(nibName: "CartDetailsCell", bundle: nil), forCellReuseIdentifier: "CartDetailsCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func payBtn(_ sender: UIButton) {
        
    }
}

extension CartDetails{

    //MARK: - API CALL
    func apiCall()  {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.myCartList(patientID: patientID)) { [weak self](data: [cartDetails]?, error) in
                self?.dataValue = data!
                self?.tableView.reloadData()
            var sum = 0
            for item in self!.dataValue {
                sum = item.cartDtlslist.compactMap { Int($0.totalAmount) }.reduce(sum, +)
            }
            self?.totalRsLbl.text = "Rs. \(sum)"
        }
    }
}

extension CartDetails: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartDetailsCell", for: indexPath) as! CartDetailsCell
        cell.ListData = dataValue[indexPath.row].cartDtlslist
        cell.tableviewheight.constant = CGFloat(dataValue[indexPath.row].cartDtlslist.count * 120)
        cell.sellerNameLbl.text = dataValue[indexPath.row].sellerName
        cell.tableview.reloadData()
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValue.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension CartDetails : cartDetailsDelegate {
    func updateQty(id: Int, qty: Int) {
        NetWorker.shared.callAPIService(type: APIV2.cartUpdate(cartID: id, qty: qty)) { [weak self](data: [removeCart]?, error) in
            if data?[0].status == "1" {
                self?.apiCall()
            }
        }
    }
    
    func getId(id: Int) {
        NetWorker.shared.callAPIService(type: APIV2.cartRemove(cartID: id)) { [weak self](data: [removeCart]?, error) in
            if data?[0].status == "1" {
                self?.apiCall()
            }
        }
    }
}
struct cartDetails: Codable {
    let sellerName: String
    let sellerType: JSONNull?
    let cartDtlslist: [CartDtlslist]

    enum CodingKeys: String, CodingKey {
        case sellerName = "SellerName"
        case sellerType = "SellerType"
        case cartDtlslist = "CartDtlslist"
    }
}

// MARK: - CartDtlslist
struct CartDtlslist: Codable {
    let cartID, patientID, patientAddressID, docID: Int
    let docType: String
    let sellerMasterID: Int
    let sellerName, sellerType: String
    let productID: Int
    let productName: String
    let qty,deliveryPincode: Int
    let mrp: String
    let discountPer, discountAmt, gstAmt,totalAmount,pricePerUnit,gstPer: Double
    let cartNoOfProducts: JSONNull?
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case cartID = "CartId"
        case patientID = "PatientId"
        case patientAddressID = "PatientAddressId"
        case docID = "DocId"
        case docType = "DocType"
        case sellerMasterID = "SellerMasterId"
        case sellerName = "SellerName"
        case sellerType = "SellerType"
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
        case cartNoOfProducts = "CartNoOfProducts"
        case imageURL = "ImageUrl"
    }
}

struct removeCart: Codable {
    let message, status: String
    let patientID, gender, firstName, middleName: JSONNull?
    let lastName, patientName, pincode, patientProfilePicURL: JSONNull?
    let patientDocumentURL, deliveryBoyID, deliveryBoy, doctorID: JSONNull?
    let doctor, doctorProfilePicURL, labMasterID, labConcernPerson: JSONNull?
    let pharmacyID, pharmacyCoordinator: JSONNull?

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case status = "Status"
        case patientID = "PatientId"
        case gender = "Gender"
        case firstName = "FirstName"
        case middleName = "MiddleName"
        case lastName = "LastName"
        case patientName = "PatientName"
        case pincode = "Pincode"
        case patientProfilePicURL = "PatientProfilePicURL"
        case patientDocumentURL = "PatientDocumentURL"
        case deliveryBoyID = "DeliveryBoyId"
        case deliveryBoy = "DeliveryBoy"
        case doctorID = "DoctorId"
        case doctor = "Doctor"
        case doctorProfilePicURL = "DoctorProfilePicURL"
        case labMasterID = "LabMasterId"
        case labConcernPerson = "LabConcernPerson"
        case pharmacyID = "PharmacyId"
        case pharmacyCoordinator = "PharmacyCoordinator"
    }
}
