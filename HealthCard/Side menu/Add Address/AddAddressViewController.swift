//
//  AddAddressViewController.swift
//  HealthCard
//
//  Created by Viral on 05/07/22.
//

import UIKit
import CoreLocation

class AddAddressViewController: UIViewController ,CLLocationManagerDelegate,XIBed{
    
    @IBOutlet weak var AddpincodeBtn: UITextField!
    @IBOutlet weak var addAddressPincodeBtn: UIButton!
    @IBOutlet weak var addAddressCurrentBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var addressType: UITextField!
    @IBOutlet weak var flatNo: UITextField!
    @IBOutlet weak var Building: UITextField!
    @IBOutlet weak var roadName: UITextField!
    @IBOutlet weak var nearBy: UITextField!
    @IBOutlet weak var area: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var region: UITextField!
    @IBOutlet weak var pincode: UITextField!
    var selected = ""
    var isLocationSelected = false
    let locationManager = CLLocationManager()
    var finallat = ""
    var finallong = ""
    
    var PatientAddressId = ""
    var AddressType = ""
    var FlatNo = ""
    var Bldg = ""
    var Road = ""
    var Nearby = ""
    var Area = ""
    var TalukaId = ""
    var District = ""
    var StateId = ""
    var CountryId = ""
    var Pincode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        addressType.text = AddressType
        flatNo.text = FlatNo
        Building.text = Bldg
        roadName.text = Road
        nearBy.text = Nearby
        area.text = Area
        country.text = CountryId
        state.text = StateId
        region.text = District
        pincode.text = Pincode
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        apiCall()
    }
    func apiCall()  {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        if selected == "" {
            NetWorker.shared.callAPIService(type: APIV2.saveAddress(patientAddressID: "0",patientID: patientID, vAddressType: addressType.text ?? "", vFlatNo: flatNo.text ?? "", vBldg: Building.text ?? "", vRoad: roadName.text ?? "", vNearby: nearBy.text ?? "", vArea: area.text ?? "", vTalukaId: region.text ?? "", vDistrictId: region.text ?? "", vStateId: state.text ?? "", vCountryId: country.text ?? "", vPincode: pincode.text ?? "", iSEdit: "N")) { [weak self] (data: [AddressStore]?, error) in
                if data?[0].status == "1" {
                    self?.navigationController?.popViewController(animated: true)
                    AppManager.shared.showAlert(title: "Success", msg: data?[0].message ?? "", vc: self!)
                }
            }
        } else {
            NetWorker.shared.callAPIService(type: APIV2.saveAddress(patientAddressID: selected,patientID: patientID, vAddressType: addressType.text ?? "", vFlatNo: flatNo.text ?? "", vBldg: Building.text ?? "", vRoad: roadName.text ?? "", vNearby: nearBy.text ?? "", vArea: area.text ?? "", vTalukaId: region.text ?? "", vDistrictId: region.text ?? "", vStateId: state.text ?? "", vCountryId: country.text ?? "", vPincode: pincode.text ?? "", iSEdit: "Y")) { [weak self] (data: [AddressStore]?, error) in
                
                    if data?[0].status == "1" {
                        self?.navigationController?.popViewController(animated: true)
                        AppManager.shared.showAlert(title: "Success", msg: data?[0].message ?? "", vc: self!)
                    }
            }
        }
    }
    
    @IBAction func addAddressCurrentBtn(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        getAddressFromLatLon(pdblLatitude: finallat, withLongitude: finallong)
    }
    
    @IBAction func addAddressPinBtn(_ sender: Any) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(AddpincodeBtn.text ?? "") { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let locationval = placemarks.first?.location else {
                    return
                }
            self.getAddressFromLatLon(pdblLatitude: "\(locationval.coordinate.latitude)", withLongitude: "\(locationval.coordinate.longitude)")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        if !isLocationSelected {
            isLocationSelected = true
            finallat = "\(locValue.latitude)"
            finallong = "\(locValue.longitude)"
//            getAddressFromLatLon(pdblLatitude: "\(locValue.latitude)", withLongitude: "\(locValue.longitude)")
            self.locationManager.stopUpdatingLocation()
        }else {
            self.locationManager.stopUpdatingLocation()
        }
    }

    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
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
                        self.country.text = pm.country ?? ""
                        self.pincode.text = pm.postalCode ?? ""
                        self.region.text = pm.locality ?? ""
                        self.area.text = pm.thoroughfare ?? ""
                        self.nearBy.text = pm.subThoroughfare ?? ""
                        self.state.text = pm.administrativeArea ?? ""
                        
                        var addressString : String = ""
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare!
                        }
                  }
            })
        }
}

struct AddressStore: Codable {
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
