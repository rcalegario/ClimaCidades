//
//  ViewController.swift
//  ClimaCidades
//
//  Created by Rodrigo Calegario on 13/01/17.
//  Copyright © 2017 RodrigoCalegario. All rights reserved.
//

import UIKit
import MapKit

class MasterViewController: UIViewController {

    var coordinates = CLLocationCoordinate2D()
    var listOfCity = [] as NSArray
    var internetReach: Reachability?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check if there is internet conection
        internetReach = Reachability.forInternetConnection()
        internetReach?.startNotifier()
        if internetReach != nil {
            let networkStatus: NetworkStatus = internetReach!.currentReachabilityStatus()
            if(networkStatus.rawValue == 0){
                //if does't have internet conection, a messenger appear for the user    
                let alert = UIAlertController(title: "Sem Conexão", message: "Você esta sem internet", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                    print("ok")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }

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
        
        //URL to call for weather info for 15 cities next to the coordenates
        let urlWeather = "http://api.openweathermap.org/data/2.5/find?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&cnt=15&APPID=b7448e21c0c1f2d706694d1dac66bea4"
        
        //use to debug
        //print(urlWeather)
        
        //send request and recive data
        let url = URL(string: urlWeather)
        let data = NSData(contentsOf: url!)

        do{

            let json = try JSONSerialization.jsonObject(with: data! as Data, options: []) as! [String:Any]
            
            //get the util info on the data
            let array = json["list"] as! NSArray
            
            //removing info from previous cities
            listOfCity = [] as NSArray
            
            //creating list with necessary information
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
        
        
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "itemList")
        userDefaults.set(listOfCity, forKey: "itemList")
        userDefaults.synchronize()

        print("ok")
        
    }
}

