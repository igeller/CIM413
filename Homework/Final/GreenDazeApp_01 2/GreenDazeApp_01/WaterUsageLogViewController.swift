//
//  LogRecyclingViewController.swift
//  GreenDazeApp_01
//
//  Created by Izzy Geller on 4/15/19.
//  Copyright © 2019 Juniette Fiore. All rights reserved.
//

//Implement TableView in UIViewController demo: http://www.thomashanning.com/uitableview-tutorial-for-beginners/


import UIKit

class WaterUsageLogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    /******** Global ********/
    
    
    @IBOutlet var tableView:UITableView!    //tableview outlet
    @IBOutlet var saveLogBtn:UIButton!
    @IBOutlet var surprise:UILabel!
    
    var itemsStringArr = [          //array of recycleable items
        "Shower under 5 min",
        "Turn sink off while getting ready",
        "Turn sink off while doing dishes",
        "Turn sink off while brushing teeth",
        "Turn sink off while washing hands"
    ]
    
   // var nameOfSelectedItem:String!     //variable holds name of the item selected
    var itemSelectedIndex:Int!         //variable holds the index of the item in the table which was clicked
    
    let defaults = UserDefaults();
    var goalNumTimesToLog:Int!
    var currentNumLogTimes:Int!
    var numItemsSelected = 0;
    
    //userdefault keystrings
    var currentNumberOfLoggingsKey = "currentNumOfWaterLoggings"
    var numTimesToLogKey = "numTimesToLogWater"

    

/**********************************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self     //initialize the data source so that we can specify what data the table shows
        tableView.delegate = self       //initialize delegate for user interaction
        
        currentNumLogTimes = defaults.integer(forKey: currentNumberOfLoggingsKey);
        goalNumTimesToLog  = defaults.integer(forKey: numTimesToLogKey)
        print(goalNumTimesToLog);
        
        if(goalNumTimesToLog != 0 && currentNumLogTimes == goalNumTimesToLog){
            saveLogBtn.isEnabled = false;     //disable the save log button
            surprise.isHidden = false;    //display lable to check tree for a surprise
        }
        else{
            saveLogBtn.isEnabled = true; //enable the save log button
            surprise.isHidden = true;    //hide lable to check tree for a surprise
        }
        
        
    }
    
    @IBAction func saveLogBtnFunc(){
        if(numItemsSelected >= 1 ){ //if the number of items selected is greater than or equal to 1 t
            print("goal time: ", goalNumTimesToLog);
            currentNumLogTimes = currentNumLogTimes + 1; //increase number of times logged when save is clicked
            defaults.set(currentNumLogTimes, forKey: currentNumberOfLoggingsKey) //store how much closer toward goal you
            print("current NumLoggings: ", currentNumLogTimes);
            self.performSegue(withIdentifier: "unwindFromLogPageToHomeWithSaveLog", sender: self); //perform the segue home
        }
    }
    
    
    
    
    
    
    //unwind function
    @IBAction func unwindSaveWaterSettings(segue: UIStoryboardSegue) {
        currentNumLogTimes = defaults.integer(forKey: currentNumberOfLoggingsKey);
        goalNumTimesToLog  = defaults.integer(forKey: numTimesToLogKey)
        if(goalNumTimesToLog != 0 && currentNumLogTimes == goalNumTimesToLog){
            saveLogBtn.isEnabled = false;     //disable the save log button
            surprise.isHidden = false;    //display lable to check tree for a surprise
            print("bttn stil disabled")
        }
        else{
            saveLogBtn.isEnabled = true; //enable the save log button
            surprise.isHidden = true;    //hide lable to check tree for a surprise
            print("bttn enabled")
        }
    }
  
    
    
    
    
/*********** DataSource Functions *************/
    //return the number of different sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //return the number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsStringArr.count
    }
    
    //describes the look of the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.tableView.allowsMultipleSelection = true   //allow for multiple selections in the log
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")! //create the cell
        let text = itemsStringArr[indexPath.row]; //get the string from array that corresponds to  position in array
        cell.textLabel?.text = text     //set the label for the cell
        
        cell.selectionStyle = .none     //prevent highlighting when clicked
        return cell
    }
    



/*********** Delegate Functions *************/
    //set checkmark when clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark       //add check mark
        numItemsSelected = numItemsSelected+1;
        
    }
    
    //unset checkmark when clicked
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none       //remove check mark
        numItemsSelected = numItemsSelected-1;
    }
    


}























//was in the didSelect
    //    let alertController = UIAlertController(title: "Hint", message: "You have selected row \(indexPath.row).", preferredStyle: .alert)
    
    
    //    if IndexPath == indexPath.row{
    //        cell.accessoryType = .checkmark
    //    } else {
    //        cell.accessoryType = .none
    //    }
    //
    //    let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
    //
    //    alertController.addAction(alertAction)
    //
    //    present(alertController, animated: true, completion: nil)





/* //get the number of possible items for the table
 override func tableView(_ tableView: UITableView,
 numberOfRowsInSection section: Int) -> Int {
 return recycleableItems.count
 }
 
 
 //add the values to the table, and allow them to have checkmarks when clicked
 override func tableView(_ tableView: UITableView,
 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
 let cell = table.dequeueReusableCell(withIdentifier: "RecycledItems", for: indexPath)
 //cell.textLabel?.text = recycleableItems[indexPath.row]
 
 
 //add the items in the array as the titles of the rows
 let item = recycleableItems[indexPath.row]
 cell.textLabel?.text = item
 return cell
 
 
 if indexPath.row == itemSelectedIndex {
 cell.accessoryType = .checkmark
 } else {
 cell.accessoryType = .none
 }
 //
 //        return cell
 }
 */


/*  var nameOfSelectedItem: String? {
 didSet {
 guard let nameofSelectedItem = nameOfSelectedItem else { return }
 
 rowLabel.text = recycleableItems
 gameLabel.text = player.game
 nameLabel.text = player.name
 ratingImageView.image = image(forRating: player.rating)
 }
 }*/
