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
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var seachButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check if there is internet conection
        if(!self.internetConnection()){
            //if does't have internet conection, a messenger appear for the user
            self.alertButton()
            seachButton.isEnabled = false
        }
        

    }

    func internetConnection() -> Bool {
        var connection:Bool = true
        var internetReach: Reachability?
        internetReach = Reachability.forInternetConnection()
        internetReach?.startNotifier()
        if internetReach != nil {
            let networkStatus: NetworkStatus = internetReach!.currentReachabilityStatus()
            if(networkStatus.rawValue == 0){
                connection = false
            }
        }
        return connection
    }
    
    func alertButton() {
        let alert = UIAlertController(title: "Sem Conexão", message: "Você esta sem internet", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            print("ok")
        }))
        self.present(alert, animated: true, completion: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
        
        let location = sender.location(in: self.mapView)
        
        coordinates = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        
        let span = MKCoordinateSpanMake(3, 3)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        self.mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = "ponto escolhido"
        
        self.mapView.removeAnnotations(mapView.annotations)
        
        self.mapView.addAnnotation(annotation)
        
    }

    @IBAction func search(_ sender: UIButton) {
        
        //removing info from previous cities
        listOfCity = [] as NSArray
        
        //URL to call for weather info for 15 cities next to the coordenates
        let urlWeather = "http://api.openweathermap.org/data/2.5/find?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&cnt=15&APPID=b7448e21c0c1f2d706694d1dac66bea4"
        
        //send request and recive data
        print(NSDate.debugDescription())
        let url = URL(string: urlWeather)
        let data = NSData(contentsOf: url!)
        print(NSDate.debugDescription())
        do{
                
            let json = try JSONSerialization.jsonObject(with: data! as Data, options: []) as! [String:Any]
                
            //get the util info on the data
            let array = json["list"] as! NSArray
                
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
        
        //preper infomation to the other view
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "itemList")
        userDefaults.set(listOfCity, forKey: "itemList")
        userDefaults.synchronize()
     
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //check internet connection to allow the transition between views
        if(!self.internetConnection()){
            self.alertButton()
            return false
        }
        return true
    }
}

