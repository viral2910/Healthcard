
//
//  SelectLocationVC.swift
//  HealthCard
//
//  Created by Viral on 23/05/22.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces
import MapKit

class SelectLocationVC: UIViewController,XIBed,CLLocationManagerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
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
    let locationManager = CLLocationManager()
    var isIntialPinSet = false
    var newPincode = ""
    @IBOutlet weak var yourpinLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        yourpinLabel.text = "Your Pin Code is \(Pincode)"
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(Pincode) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let locationval = placemarks.first?.location else {
                    return
                }
            let camera = GMSCameraPosition.camera(withLatitude: (locationval.coordinate.latitude), longitude: (locationval.coordinate.longitude), zoom: 17.0)
            
            self.mapviewRef?.animate(to: camera)
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(searchBar.text ?? "") { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let locationval = placemarks.first?.location else {
                    return
                }
            let camera = GMSCameraPosition.camera(withLatitude: (locationval.coordinate.latitude), longitude: (locationval.coordinate.longitude), zoom: 15.0)
            self.mapviewRef?.animate(to: camera)
            let marker = GMSMarker(position: locationval.coordinate)
            marker.map = self.mapviewRef
            self.getAddressFromLatLon(pdblLatitude: "\(locationval.coordinate.latitude)", pdblLongitude: "\(locationval.coordinate.longitude)")
        }
    }
    
    
    func getAddressFromLatLon(pdblLatitude: String, pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = placemarks![0]
                self.newPincode = pm.postalCode ?? ""
            }
        })
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ProcedAction(_ sender: UIButton) {
        if Pincode == newPincode {
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
        } else {
            AppManager.shared.showAlert(title: "Error", msg: "Please Select correct Area", vc: self)
        }
        
    }
    
}
