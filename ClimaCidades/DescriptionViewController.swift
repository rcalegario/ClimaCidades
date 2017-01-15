//
//  DescriptionViewController.swift
//  ClimaCidades
//
//  Created by Rodrigo Calegario on 14/01/17.
//  Copyright © 2017 RodrigoCalegario. All rights reserved.
//

import UIKit
import InLocoMediaAPI

class DescriptionViewController: UIViewController, ILMInterstitialAdDelegate{

    @IBOutlet weak var cityName_tf: UITextField! = UITextField()
    @IBOutlet weak var maxTemp_tf: UITextField! = UITextField()
    @IBOutlet weak var minTemp_tf: UITextField! = UITextField()
    @IBOutlet weak var description_tf: UITextField! = UITextField()
    
    var cityInfo:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
    var ad = ILMInterstitialAd()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ad.delegate = self
        ad.load()
        
        cityName_tf.isUserInteractionEnabled = false
        maxTemp_tf.isUserInteractionEnabled = false
        minTemp_tf.isUserInteractionEnabled = false
        description_tf.isUserInteractionEnabled = false
        
        let tmx = (cityInfo["temp_max"] as? Double)! - 273.15
        let tmn = (cityInfo["temp_min"] as? Double)! - 273.15
        
        cityName_tf.text = cityInfo["name"] as? String
        description_tf.text = cityInfo["description"] as? String
        minTemp_tf.text = "\(String(format: "%.2f", tmn)) °C"
        maxTemp_tf.text = "\(String(format: "%.2f", tmx)) °C"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if(parent == nil){
            ad.present()
        }
    }
    
    func ilmInterstitialAdDidReceive(_ interstitialAd: ILMInterstitialAd) {
        //Called when the view has received an advertisement and is ready to be shown
        //You can call the interstitialAd present method here, or save it for any other moment you wish to present it.
        ad = interstitialAd
    }
    
    func ilmInterstitialAd(_ adView: ILMInterstitialAd, didFailToReceiveAdWithError error: ILMError) {
        //Called when the ad request has failed.
    }
    
    func ilmInterstitialAdWillAppear(_ interstitialAd: ILMInterstitialAd) {
        //Called right before the interstitialAd be shown on the screen
    }
    
    func ilmInterstitialAdWillDisappear(_ interstitialAd: ILMInterstitialAd) {
        //Called right before the interstitialAd be dismissed from the screen
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
