//
//  ViewController.swift
//  ClimaCidades
//
//  Created by Rodrigo Calegario on 13/01/17.
//  Copyright © 2017 RodrigoCalegario. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var coordinates = CLLocationCoordinate2D()
    var listOfCity = [] as NSArray
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
        
        let location = sender.location(in: self.mapView)
        
        coordinates = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = "ponto escolhido"
        
        self.mapView.removeAnnotations(mapView.annotations)
        
        self.mapView.addAnnotation(annotation)
        
    }

    @IBAction func search(_ sender: UIButton) {
        
        let lat = coordinates.latitude
        let lon = coordinates.longitude
        
        let urlWeather = "http://api.openweathermap.org/data/2.5/find?lat=\(lat)&lon=\(lon)&cnt=15&APPID=b7448e21c0c1f2d706694d1dac66bea4"
        print(urlWeather)
        
        let url = URL(string: urlWeather)
        let data = NSData(contentsOf: url!)
        do{
            let json = try JSONSerialization.jsonObject(with: data! as Data, options: []) as! [String:Any]
            
            let array = json["list"] as! NSArray
            
            for temp in array {
                let city = temp as! Dictionary<String, AnyObject>
                let description = (city["weather"] as! NSArray)[0] as! Dictionary<String, AnyObject>
                listOfCity = listOfCity.adding(["name": city["name"] as! String,
                                   "temp_min": city["main"]?["temp_min"] as! Double,
                                   "temp_max": city["main"]?["temp_max"] as! Double,
                                   "description": description["description"] as! String]
                ) as NSArray
            }
        } catch {
            print("erro")
        }
        
        print(listOfCity)
        
    }
}

