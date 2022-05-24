//
//  SelectLocationVC.swift
//  HealthCard
//
//  Created by Viral on 23/05/22.
//

import UIKit
import GoogleMaps

class SelectLocationVC: UIViewController,XIBed {

    @IBOutlet weak var mapviewRef: GMSMapView!
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
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "you are here"
        marker.map = mapviewRef
        // Do any additional setup after loading the view.
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func ProcedAction(_ sender: UIButton) {
        let vc = orderPlaceVC.instantiate()
        vc.amount = amount
        vc.patientAddressID = patientAddressID
        vc.cartID = cartID
        vc.sellerMasterID = sellerMasterID
        vc.docID = docID
        vc.DocType = DocType
        vc.ProductId = ProductId
        vc.qty = qty
        vc.MRP = MRP
        vc.DiscountAmt = DiscountAmt
        vc.DiscountPer = DiscountPer
        vc.GSTAmt = GSTAmt
        vc.GSTPer = GSTPer
        vc.PricePerUnit = PricePerUnit
        vc.TotalAmount = TotalAmount
        vc.SellerType = SellerType
        vc.Pincode = Pincode
        vc.PaymentId = PaymentId
        vc.PaymentMethod = PaymentMethod
        vc.Latitude = Latitude
        vc.Longitude = Longitude
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
