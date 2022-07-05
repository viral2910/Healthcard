//
//  driverRouteViewController.swift
//  HealthCard
//
//  Created by Viral on 24/06/22.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class driverRouteViewController:UIViewController, XIBed {
    
    @IBOutlet weak var mapviewRef: GMSMapView!
    var isIntialPinSet = false
    var latdriver : Double = 0.0
    var longdriver : Double = 0.0
    var lati : Double = 0.0
    var longi : Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dstloc = CLLocationCoordinate2D(latitude: lati, longitude: longi)
        let src = CLLocationCoordinate2D(latitude: latdriver, longitude: longdriver)
        draw(src: src, dst: dstloc)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func draw(src: CLLocationCoordinate2D, dst: CLLocationCoordinate2D){

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(src.latitude),\(src.longitude)&destination=\(dst.latitude),\(dst.longitude)&sensor=false&mode=driving&key=AIzaSyCOkXvGWFAfSccRS-azPprnqKEn9vf2LLI")!

        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {

                        let preRoutes = json["routes"] as! NSArray
                        let routes = preRoutes[0] as! NSDictionary
                        let routeOverviewPolyline:NSDictionary = routes.value(forKey: "overview_polyline") as! NSDictionary
                        let polyString = routeOverviewPolyline.object(forKey: "points") as! String

                        DispatchQueue.main.async(execute: {
                            let path = GMSPath(fromEncodedPath: polyString)
                            let polyline = GMSPolyline(path: path)
                            polyline.strokeWidth = 5.0
                            polyline.strokeColor = UIColor(named: "AppColor")!
                            polyline.map = self.mapviewRef
                        })
                    }

                } catch {
                    print("parsing error")
                }
            }
        })
        task.resume()
    }
    
}
