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
    override func viewDidLoad() {
        super.viewDidLoad()
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "you are here"
        marker.map = mapviewRef
        // Do any additional setup after loading the view.
    }
}
