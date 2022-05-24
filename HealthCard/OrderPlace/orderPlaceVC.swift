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
    var PaymentId = ""
    var PaymentMethod = ""
    var Latitude = ""
    var Longitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        razorpay = RazorpayCheckout.initWithKey(razorpayTestKey, andDelegate: self)
        // Do any additional setup after loading the view.
    }
    @IBAction func payOnDeliveryAction(_ sender: Any) {
        OrderapiCall()
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func payOnlineAction(_ sender: Any) {
        self.showPaymentForm(amount: Int(amount) ?? 0, orderId: "154546548", desc: "Order Booking")
    }
    

    //MARK: - API CALL
    func OrderapiCall()  {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.saveOrder(patientID: patientID, patientAddressID: patientAddressID, cartID: cartID, sellerMasterID: sellerMasterID, docID: docID, DocType: DocType, ProductId: ProductId, qty: qty, MRP: MRP, DiscountAmt: DiscountAmt, DiscountPer: DiscountPer, GSTAmt: GSTAmt, GSTPer: GSTPer, PricePerUnit: PricePerUnit, TotalAmount: TotalAmount, SellerType: SellerType, Pincode: Pincode, PaymentId: PaymentId, PaymentMethod: PaymentMethod, Latitude: Latitude, Longitude: Longitude)) { [weak self] (data: [cartDetails]?, error) in
            
//            if data?[0].status == "1" {
//                let vc = HomeViewController.instantiate()
//                self?.navigationController?.pushViewController(vc, animated: true)
//            }
        }
    }
}

extension orderPlaceVC: RazorpayPaymentCompletionProtocol{
    func onPaymentError(_ code: Int32, description str: String) {
        print("Failed \(str)")
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        print("Success \(payment_id)")
        
        
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
