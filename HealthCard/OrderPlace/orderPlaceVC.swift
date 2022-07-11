//
//  orderPlaceVC.swift
//  HealthCard
//
//  Created by Viral on 24/05/22.
//

import UIKit
import Razorpay

class orderPlaceVC: UIViewController,XIBed, RazorpayProtocol {
    
    var razorpay: RazorpayCheckout!
    var razorpayTestKey = "rzp_live_a06lrHIHAADxOP"
    var amount = ""
    var patientAddressID = 0
    var cartID = ""
    var sellerMasterID = ""
    var docID = ""
    var DocType = ""
    var ProductId = ""
    var qty = ""
    var MRP = ""
    var DiscountAmt = ""
    var DiscountPer = ""
    var GSTAmt = ""
    var GSTPer = ""
    var PricePerUnit = ""
    var TotalAmount = ""
    var SellerType = ""
    var Pincode = ""
    var Latitude = ""
    var Longitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        razorpay = RazorpayCheckout.initWithKey(razorpayTestKey, andDelegate: self)
        // Do any additional setup after loading the view.
    }
    @IBAction func payOnDeliveryAction(_ sender: Any) {
        OrderapiCall(PaymentId: "")
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func payOnlineAction(_ sender: Any) {
        self.showPaymentForm(amount: Int(amount) ?? 0, orderId: "154546548", desc: "Order Booking")
    }
    

    //MARK: - API CALL
    func OrderapiCall(PaymentId:String)  {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        var method = ""
        if PaymentId == "" {
            method = "COD"
        } else {
            method = "Online"
        }
        NetWorker.shared.callAPIService(type: APIV2.saveOrder(patientID: patientID, patientAddressID: patientAddressID, cartID: cartID, sellerMasterID: sellerMasterID, docID: docID, DocType: DocType, ProductId: ProductId, qty: qty, MRP: MRP, DiscountAmt: DiscountAmt, DiscountPer: DiscountPer, GSTAmt: GSTAmt, GSTPer: GSTPer, PricePerUnit: PricePerUnit, TotalAmount: TotalAmount, SellerType: SellerType, Pincode: Pincode, PaymentId: PaymentId, PaymentMethod: method, Latitude: Latitude, Longitude: Longitude)) { [weak self] (data: [orderplace]?, error) in
            
            if data?[0].status == "1" {
                
                let controllers = self?.navigationController?.viewControllers
                for vc in controllers! {
                    if vc is CustomTabBarViewController {
                        _ = self?.navigationController?.popToViewController(vc as! CustomTabBarViewController, animated: true)
                        
                        AppManager.shared.showAlert(title: "Success", msg: data?[0].message ?? "", vc: self!)
                    }
                }
                
            }
        }
    }
}

extension orderPlaceVC: RazorpayPaymentCompletionProtocol{
    func onPaymentError(_ code: Int32, description str: String) {
        print("Failed \(str)")
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        print("Success \(payment_id)")
        OrderapiCall(PaymentId: payment_id)
    }
    
    internal func showPaymentForm(amount: Int,orderId: String, desc: String){
        let options: [String:Any] = [
            "amount": "\(amount * 100)", //This is in currency subunits. 100 = 100 paise= INR 1.
            "currency": "INR",//We support more that 92 international currencies.
            "description": "\(desc)",
            //"order_id": orderId,
            "name": "Health Card",
            "theme": [
                "color": "#F37254"
            ]
        ]
        razorpay.open(options)
    }
}
struct orderplace: Codable {
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
