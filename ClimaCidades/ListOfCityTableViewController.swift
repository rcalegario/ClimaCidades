//
//  ListOfCityTableViewController.swift
//  ClimaCidades
//
//  Created by Rodrigo Calegario on 14/01/17.
//  Copyright © 2017 RodrigoCalegario. All rights reserved.
//

import UIKit

class ListOfCityTableViewController: UITableViewController {

    var listOfCity:NSArray = NSArray()
    
    override func viewDidAppear(_ animated: Bool) {
        let userDefaults:UserDefaults = UserDefaults.standard
        let itemList:NSArray? = userDefaults.object(forKey: "itemList") as? NSArray
        
        if ((itemList) != nil){
            listOfCity = itemList!
        }
        
        self.tableView.reloadData()
        
        let indexPath = IndexPath(row: 10, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfCity.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell

        let city:Dictionary<String, AnyObject> = listOfCity.object(at: indexPath.row) as! Dictionary<String, AnyObject>
        
        cell.textLabel?.text = city["name"] as? String
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if(segue.identifier == "showCityInfo"){
            let selectedIndexPath:IndexPath = self.tableView.indexPathForSelectedRow!
            let descriptionViewController:DescriptionViewController = segue.destination as! DescriptionViewController
            descriptionViewController.cityInfo = listOfCity.object(at: selectedIndexPath.row) as! Dictionary<String,AnyObject>
        }
        
        
    }
    

}
