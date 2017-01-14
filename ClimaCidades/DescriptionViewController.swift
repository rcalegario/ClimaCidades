//
//  DescriptionViewController.swift
//  ClimaCidades
//
//  Created by Rodrigo Calegario on 14/01/17.
//  Copyright © 2017 RodrigoCalegario. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var cityName_tf: UITextField! = UITextField()
    @IBOutlet weak var maxTemp_tf: UITextField! = UITextField()
    @IBOutlet weak var minTemp_tf: UITextField! = UITextField()
    @IBOutlet weak var description_tf: UITextField! = UITextField()
    
    var cityInfo:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityName_tf.isUserInteractionEnabled = false
        maxTemp_tf.isUserInteractionEnabled = false
        minTemp_tf.isUserInteractionEnabled = false
        description_tf.isUserInteractionEnabled = false
        
        let tempMax = String((cityInfo["temp_max"] as? Double)!)
        let tempMin = String((cityInfo["temp_min"] as? Double)!)
        
        cityName_tf.text = cityInfo["name"] as? String
        description_tf.text = cityInfo["description"] as? String
        minTemp_tf.text = tempMin
        maxTemp_tf.text = tempMax
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
