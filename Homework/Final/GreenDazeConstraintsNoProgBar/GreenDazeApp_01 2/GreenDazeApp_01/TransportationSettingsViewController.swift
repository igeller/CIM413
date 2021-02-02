//
//  RecycleSettingsViewController.swift
//  GreenDazeApp_01
//
//  Created by Izzy Geller on 4/24/19.
//  Copyright © 2019 Juniette Fiore. All rights reserved.
//

import UIKit
import UserNotifications

class TransportationSettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //IBOutlets for things that will be disabled
    @IBOutlet var trackGoalSwitch: UISwitch!
    @IBOutlet var trackLabel: UILabel!
    @IBOutlet var iWantLabel: UILabel!
    @IBOutlet var numberTimesTxtField: UITextField!
    @IBOutlet var timesALabel: UILabel!
    @IBOutlet var frequencyTextField: UITextField!
    //@IBOutlet var frequencyPicker: UIPickerView!
    var frequencyPicker = UIPickerView()
    
    @IBOutlet var setAlertSwitch: UISwitch!
    @IBOutlet var setAlertLabel: UILabel!
    @IBOutlet var setSundayBtn: UIButton!
    @IBOutlet var setMondayBtn: UIButton!
    @IBOutlet var setTuesdayBtn: UIButton!
    @IBOutlet var setWednesdayBtn: UIButton!
    @IBOutlet var setThursdayBtn: UIButton!
    @IBOutlet var setFridayBtn: UIButton!
    @IBOutlet var setSaturdayBtn: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    
    var arrActiveDays:[Int]!
    var arrOnOffBtnColor = [
        UIColor.clear, //off color
        UIColor(red:1.00, green:0.80, blue:1.00, alpha:1.0)    //on colorthe pink color
    ]
    var activeDaysEdited:Bool = false       //will be a default
    var frequencyArr = [
        "day",
        "week",
        "month"
    ]
    var frequencyPickerChanged:Bool = false
    
    
    
    var trackSwitchOn: Bool = true;
    var currAlertState: Bool = true
    var startedBefore: Bool = true;

    
    var timeToAchieveGoal:Int!
    var startDate: Date!
    var endDate:Date!
    var endDateFormatter = DateFormatter();
    var numTimesToLog:Int!
    
    
    //things that will be user defaults
    let defaults = UserDefaults();
    
    //notification info
    var notificationTitle = "GeenDaze"
    var notificationSubtitle = "Transportation"
    var notificationBody = "Don't forget to log your clean transportation!"
    var notificationSound = UNNotificationSound.default
    
    
    //user default keystrings
    var numTimesToLogKey = "numTimesToLogTransport"
    var trackGoalToggleKey = "transportTrackToggleIsOn"
    var trackAlertToggleFROMITSFuncKey = "transportTrackAlertToggleIsOnFROMITSFunc"
    var currentFrequencyRowKey = "transportCurrentFrequencyRow"
    var arrActiveDays0s1sKey = "arrayOfActiveTransportDays"
    var boolHoldingIfArrActiveDaysEditedKey = "transportActiveDaysEditedBool"
    
    var setSundayBGArrPosKey = "transportSunBG"
    var setMondayBGArrPosKey = "transportMonBG"
    var setTuesdayBGArrPosKey = "transportTueBG"
    var setWednesdayBGArrPosKey = "transportWedBG"
    var setThursdayBGArrPosKey = "transportThuBG"
    var setFridayBGArrPosKey = "transportFriBG"
    var setSaturdayBGArrPosKey = "transportSatBG"
    
    var prevFrequenceyRowValKey = "prevTransportFrequencyRowVal"
    var goalEndDateKey = "transportGoalEndDate"
    var currentNumberOfLoggingsKey = "currentNumOfTransportLoggings"
    var leafAddedYetKey = "transportLeafAddedYet"
    var trackAlertToggleKey = "transportTrackAlertToggleIsOn"
    var startedBeforeKey = "startedBeforeTransport"
    var alertTimeStringKey = "transportAlertTimeString"
    var recycleEndDateSetKey = "transportEndDateHasBeenSet"

    
/**************************************************************************/
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set hint with current number of items to recycle
        if(defaults.integer(forKey: numTimesToLogKey) != 0){
            numberTimesTxtField.placeholder = (String)(defaults.integer(forKey: numTimesToLogKey));
        }
        
        //for the toggles
        startedBefore = defaults.bool(forKey: startedBeforeKey); //if the app has been used before then use default of switch, if not then we want to ensure the toggle is on when we first go to notifications
        if(startedBefore == false){
            trackGoalSwitch.isOn = true;
            setAlertSwitch.isOn = true;
        }else{
            trackGoalSwitch.isOn = defaults.bool(forKey: trackGoalToggleKey);
            setAlertSwitch.isOn = defaults.bool(forKey: trackAlertToggleFROMITSFuncKey);
        }
        
        trackGoalToggle(trackGoalSwitch);
        
        
        //set the delegate and the source for the picker view
        frequencyPicker.delegate = self
        frequencyPicker.dataSource = self
        frequencyTextField.inputView = frequencyPicker;
        let currentFreqRow = defaults.integer(forKey: currentFrequencyRowKey); //get current pos in picker
        self.frequencyPicker.selectRow(currentFreqRow, inComponent: 0, animated: true); //currently selected frequency
        frequencyTextField.text = frequencyArr[currentFreqRow] //set the standard txtfield to have location of picker

        
        
        //alert permission stuff
        //get permission to send alerts
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {
                (granted, error) in
                if granted {
                   // print("yes")
                } else {
                    //print("No")
                }
        }
        
        //reload the array with the correct active values
        //set activeDays array to the stored default value
        if ( ( defaults.array(forKey: arrActiveDays0s1sKey) as? [Int] ?? [Int]() ).count != 0){
            arrActiveDays = defaults.array(forKey: arrActiveDays0s1sKey) as? [Int] ?? [Int]();
        }else{
            arrActiveDays = [0, 0, 0, 0, 0, 0, 0]
        }
        
        
        //set the active button background color
        activeDaysEdited = defaults.bool(forKey: boolHoldingIfArrActiveDaysEditedKey);
        print("the days active has been changed: ", activeDaysEdited)
        /*if(!activeDaysEdited){ //set default color for all buttons when loaded first time (so no changes have been made)
            defaults.set(0, forKey: setSundayBGArrPosKey);    //default is to keep it on
            defaults.set(0, forKey: setMondayBGArrPosKey);
            defaults.set(0, forKey: setTuesdayBGArrPosKey);
            defaults.set(0, forKey: setWednesdayBGArrPosKey);
            defaults.set(0, forKey: setThursdayBGArrPosKey);
            defaults.set(0, forKey: setFridayBGArrPosKey);
            defaults.set(0, forKey: setSaturdayBGArrPosKey);
        }*/
        
        //set the active alert day backgrounds
        setSundayBtn.backgroundColor = arrOnOffBtnColor[defaults.integer(forKey: setSundayBGArrPosKey)];
        setMondayBtn.backgroundColor = arrOnOffBtnColor[defaults.integer(forKey: setMondayBGArrPosKey)];
        setTuesdayBtn.backgroundColor = arrOnOffBtnColor[defaults.integer(forKey: setTuesdayBGArrPosKey)];
        setWednesdayBtn.backgroundColor = arrOnOffBtnColor[defaults.integer(forKey: setWednesdayBGArrPosKey)];
        setThursdayBtn.backgroundColor = arrOnOffBtnColor[defaults.integer(forKey: setThursdayBGArrPosKey)];
        setFridayBtn.backgroundColor = arrOnOffBtnColor[defaults.integer(forKey: setFridayBGArrPosKey)];
        setSaturdayBtn.backgroundColor = arrOnOffBtnColor[defaults.integer(forKey: setSaturdayBGArrPosKey)];

        //set the time picker to be what it was just set as
        let prevSetAlertTime = defaults.object(forKey: alertTimeStringKey)as? Date ?? Date();    //get the set time, and adjust
        datePicker.setDate(prevSetAlertTime, animated: false); //set the date picker to what we have chosen
    }//end viewDidLoad
    
    
    
    
    //send data via the specified segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromRecycleSettingsToRecycleLogWithSave"{
            //when hit save, get the value of txtField
            let currentLog = defaults.integer(forKey: numTimesToLogKey);    //hold value of default goal currently
            numTimesToLog = Int(numberTimesTxtField.text!);         //get value from the textfield
            //defaults.set(numTimesToLog, forKey: numTimesToLogKey);
            
            if numTimesToLog == nil { //if the number of times to recycle wasnt changed keep old value
                defaults.set(currentLog, forKey: numTimesToLogKey);
            }else{ //if the value was changed then send it to the log view
                defaults.set(numTimesToLog, forKey: numTimesToLogKey);
            }
            

            saveNotificationTime(_sender: datePicker);
            
            
            //save the frequency selector and get new enddate
            var prevFrequencyRow = defaults.integer(forKey: prevFrequenceyRowValKey);
            
            let curFrequencyRow = frequencyPicker.selectedRow(inComponent: 0);
            if(prevFrequencyRow == curFrequencyRow){            //if frequency selected
                prevFrequencyRow = curFrequencyRow;             //then we set the picker to remain consistent
                defaults.set(curFrequencyRow, forKey: prevFrequenceyRowValKey); //set the default previous recycle frequency to the new value
                
                if(numTimesToLog != nil){ //the fequency is unchaged, but the number of items to log has changed
                    pickerView(frequencyPicker, didSelectRow: prevFrequencyRow, inComponent: 0); //trigger pickerview to do its thing
                    defaults.set(endDate, forKey: goalEndDateKey); //set enddate default so that we can compare for goal in other files
                    defaults.set(0, forKey: currentNumberOfLoggingsKey) //reset the number of items logged to 0;
                    defaults.set(false, forKey: leafAddedYetKey) //allow leaf to be added when we get to goal completion but prevents addition when looking at the tree again
                    print("curr num loggings bc num chng: ", defaults.integer(forKey: currentNumberOfLoggingsKey))
                    defaults.set(true, forKey: recycleEndDateSetKey);
                }
            }else if(prevFrequencyRow != curFrequencyRow){ //if the picker has changed since last time
                pickerView(frequencyPicker, didSelectRow: curFrequencyRow, inComponent: 0); //forces to get a new enddate --> this may be done without this function because things moved, but will test later
                defaults.set(endDate, forKey: goalEndDateKey); //set enddate default so that we can compare for goal in other files
                defaults.set(curFrequencyRow, forKey: prevFrequenceyRowValKey); //set the default previous recycle frequency to the new value
                 defaults.set(0, forKey: currentNumberOfLoggingsKey) //reset the number of items logged to 0;
                 defaults.set(false, forKey: leafAddedYetKey) //allow leaf to be added when we get to goal completion but prevents addition when looking at the tree again
                print("curr num loggings bc freq chng: ", defaults.integer(forKey: currentNumberOfLoggingsKey))
                defaults.set(true, forKey: recycleEndDateSetKey);
            }
            
            defaults.set(true, forKey: startedBeforeKey);    //if we have hit save button we can set the toggle however it should be set
            defaults.set(trackGoalSwitch.isOn, forKey: trackGoalToggleKey);
            
        }//end unwind from settings to log upon pressing save
    }//end save changes
    
    
    
    @IBAction func trackGoalToggle(_ sender: UISwitch){
        if(sender.isOn == false){ //if the toggle was on save state while setting to off
            defaults.set(false, forKey: trackGoalToggleKey);
            setAlertSwitch.isEnabled = false; //while track is off, we want to prevent from turning on
            disableAlertSaveState();
            //make things greyed out and unclickable
            enableDisableTrackGoalInfo(state: false);
            enableDisableAlertSection(state: false);
            defaults.set(setAlertSwitch.isOn, forKey: trackAlertToggleKey);
            setAlertSwitch.isOn = false;
            
        }else{
            defaults.set(true, forKey: trackGoalToggleKey);
            setAlertSwitch.isEnabled = true; //while track is off, we want to prevent from turning on
            reenableAlertForClickedDays();
            enableDisableTrackGoalInfo(state: true);
            if(defaults.bool(forKey: trackAlertToggleKey)){
                enableDisableAlertSection(state: true);
            }else{
                enableDisableAlertSection(state: false);
            }
            setAlertSwitch.isOn = defaults.bool(forKey: trackAlertToggleKey)
            

        }
    }
    
    @IBAction func trackAlertToggle(_ sender: UISwitch){
        if(sender.isOn == false){
            defaults.set(false, forKey: trackAlertToggleKey);
            defaults.set(false, forKey: trackAlertToggleFROMITSFuncKey);
            enableDisableAlertSection(state: false)
        }else{
            defaults.set(true, forKey: trackAlertToggleKey);
            defaults.set(true, forKey: trackAlertToggleFROMITSFuncKey);
            enableDisableAlertSection(state: true)
        }
    }
    
    func enableDisableTrackGoalInfo(state: Bool){
        iWantLabel.isEnabled = state;
        numberTimesTxtField.isEnabled = state;
        timesALabel.isEnabled = state;
        frequencyTextField.isEnabled = state;
    }
    
    func enableDisableAlertSection(state: Bool){
        setAlertLabel.isEnabled = state;
        
        setSundayBtn.isEnabled = state;
        setMondayBtn.isEnabled = state;
        setTuesdayBtn.isEnabled = state;
        setWednesdayBtn.isEnabled = state;
        setThursdayBtn.isEnabled = state;
        setFridayBtn.isEnabled = state;
        setSaturdayBtn.isEnabled = state;
        datePicker.isEnabled = state;
        
        
    }
    
    func disableAlertSaveState(){
        //turn off all days
        var sender:UIButton!
        //print(arrActiveDays.count);
        if(arrActiveDays != nil){
            for i in 0...6{
                if(i == 0){
                    sender = setSundayBtn
                }else if(i == 1){
                    sender = setMondayBtn
                }else if(i == 2){
                    sender = setTuesdayBtn
                }else if(i == 3){
                    sender = setWednesdayBtn
                }else if(i == 4){
                    sender = setThursdayBtn
                }else if(i == 5){
                    sender = setFridayBtn
                }else if(i == 6){
                    sender = setSaturdayBtn
                }
                sender.accessibilityHint = "off";   //turn the notification for that day off
                arrActiveDays[i] = 0;      //set the day in active daays to off
            }
        }
            
        defaults.set(activeDaysEdited, forKey: boolHoldingIfArrActiveDaysEditedKey);
        print("disableAlertSaveState: active days edited: ", defaults.bool(forKey: boolHoldingIfArrActiveDaysEditedKey) )

        defaults.setValue(arrActiveDays, forKey: arrActiveDays0s1sKey);
    }
    
    func reenableAlertForClickedDays(){
        //turn off all days
        var sender:UIButton!
        for i in 0...6{
            if(i == 0){
                sender = setSundayBtn
            }else if(i == 1){
                sender = setMondayBtn
            }else if(i == 2){
                sender = setTuesdayBtn
            }else if(i == 3){
                sender = setWednesdayBtn
            }else if(i == 4){
                sender = setThursdayBtn
            }else if(i == 5){
                sender = setFridayBtn
            }else if(i == 6){
                sender = setSaturdayBtn
            }
            
            if(sender.backgroundColor == arrOnOffBtnColor[1]){
                print(i, "being set to on");
                sender.accessibilityHint = "on";   //turn the notification for that day off
                arrActiveDays[i] = 1;      //set the day in active daays to off
            }
            defaults.set(activeDaysEdited, forKey: boolHoldingIfArrActiveDaysEditedKey);
            print("reenableActiveDays: active days edited: ", defaults.bool(forKey: boolHoldingIfArrActiveDaysEditedKey) )

            defaults.setValue(arrActiveDays, forKey: arrActiveDays0s1sKey);
        }
    }
    
    
    @IBAction func  freqTxTFieldAction(_ sender: UIPickerView){
    
    }
    
    
    
    
    //when save notifications page, go back to home screen? but save and store all the things changed as userdefaults
    
/*********** PickerView DataSource Functions *************/
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return frequencyArr.count
    }
    
/*********** PickerView Delegate Functions *************/
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return frequencyArr[row]
        
        //user default the current goal amt of time
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        //let pos = pickerView.selectedRow(inComponent: row); //get the position of picker
        startDate = Date();
        print("picker position: \(row)");
        
        switch(row){
        case 0: //day
            timeToAchieveGoal = 1;
            frequencyTextField.text = frequencyArr[row];
            endDate = generateEndDate(startDate: startDate, addbyUnit: .day, value: timeToAchieveGoal);
        case 1: //week
            timeToAchieveGoal = 7;
            frequencyTextField.text = frequencyArr[row];
            endDate = generateEndDate(startDate: startDate, addbyUnit: .day, value: timeToAchieveGoal);

        case 2: //month
            timeToAchieveGoal = 30;
            frequencyTextField.text = frequencyArr[row];
            endDate = generateEndDate(startDate: startDate, addbyUnit: .day, value: timeToAchieveGoal);

        default:
            timeToAchieveGoal = 1;
            frequencyTextField.text = frequencyArr[row];
            endDate = generateEndDate(startDate: startDate, addbyUnit: .day, value: timeToAchieveGoal);
        }
        print("frequency picker selected : ", frequencyArr[row] );
        // use the row to get the selected row from the picker view
        // using the row extract the value from your datasource (array[row])
        //frequencyPickerChanged = true;
        defaults.set(row, forKey: currentFrequencyRowKey);
    }
    
    func generateEndDate(startDate :Date?, addbyUnit:Calendar.Component, value : Int) -> Date {
        //var endDate = [Date]();
        let endDate = Calendar.current.date(byAdding: addbyUnit, value: value, to: startDate!)!
        print("The end date: ", endDate.toLocalTime());
        return endDate;
    }
    
   
    
    
    
    
    

    //hide keyboard when tap outside field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //hide keyboard if return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
/*************** Time/ Notification Functions ****************/
    var date = DateComponents();
    
    //send notification
    func saveNotificationTime(_sender: Any){
        setTimeForNotification(datePicker);
        let notificationCenter = UNUserNotificationCenter.current()
        
        //prepare notifcation content
        let content = UNMutableNotificationContent();
        content.title = notificationTitle
        content.subtitle = notificationSubtitle
        content.body = notificationBody
        content.sound = notificationSound
        
        print("notification date:", date);
        
        var id:String!
        var request:UNNotificationRequest!
        
        //determine when the notification will appear by day
        var removeId:[String] = []
        if(activeDaysEdited == true){
            for i in 0...arrActiveDays.count-1
            {   id = "recycleNotification.\(i+1)";
                if(arrActiveDays[i] == 1){
                    date.weekday = i+1;       //get the day of the week that is set on for notification
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                    request = UNNotificationRequest(identifier: id, content: content, trigger: trigger);
                    notificationCenter.add(request, withCompletionHandler: nil);    //add the request for the specific day to the notification center
                    print("adding: ", i);
                }else{
                    removeId.append(id);
                }
                
            }
            notificationCenter.removePendingNotificationRequests(withIdentifiers: removeId);//removes the alerts when the days are set to off by toggling tracking off
        }
    }//end saveNotificationTime
    
    
    @IBAction func getNumDaysEnabled(_ sender: UIButton){
        //make buttons pretty: https://blog.supereasyapps.com/how-to-create-round-buttons-using-ibdesignable-on-ios-11/
        
        let dayClicked = sender.tag;
        var dayStatusColor:Int!
        if(sender.accessibilityHint == "on"){
            sender.accessibilityHint = "off";   //turn the notification for that day off
            arrActiveDays[dayClicked] = 0;      //set the day in active daays to off
            sender.backgroundColor = arrOnOffBtnColor[0];
            dayStatusColor = 0;                 //set the position of
        }else{
            sender.accessibilityHint = "on";   //turn the notification for that day on
            arrActiveDays[dayClicked] = 1;      //set the day in active daays to on
            sender.backgroundColor = arrOnOffBtnColor[1];
            dayStatusColor = 1;                 //set the position of
        }
        
        //set the default color, so the user knows which days are on and off
        
        switch dayClicked {
        case 0:
            defaults.set(dayStatusColor, forKey: setSundayBGArrPosKey);
        case 1:
            defaults.set(dayStatusColor, forKey: setMondayBGArrPosKey);
        case 2:
            defaults.set(dayStatusColor, forKey: setTuesdayBGArrPosKey);
        case 3:
            defaults.set(dayStatusColor, forKey: setWednesdayBGArrPosKey);
        case 4:
            defaults.set(dayStatusColor, forKey: setThursdayBGArrPosKey);
        case 5:
            defaults.set(dayStatusColor, forKey: setFridayBGArrPosKey);
        case 6:
            defaults.set(dayStatusColor, forKey: setSaturdayBGArrPosKey);
        default:
            defaults.set(1, forKey: setSundayBGArrPosKey);    //default is to keep it on
            defaults.set(1, forKey: setMondayBGArrPosKey);
            defaults.set(1, forKey: setTuesdayBGArrPosKey);
            defaults.set(1, forKey: setWednesdayBGArrPosKey);
            defaults.set(1, forKey: setThursdayBGArrPosKey);
            defaults.set(1, forKey: setFridayBGArrPosKey);
            defaults.set(1, forKey: setSaturdayBGArrPosKey);
        }
        activeDaysEdited = true;
        defaults.set(activeDaysEdited, forKey: boolHoldingIfArrActiveDaysEditedKey);
        print("getNumEnabledDays: active days edited: ", defaults.bool(forKey: boolHoldingIfArrActiveDaysEditedKey) )
        defaults.setValue(arrActiveDays, forKey: arrActiveDays0s1sKey);
        
    }//end getNumEnabledDays
    
    
    @IBAction func setTimeForNotification(_ sender: UIDatePicker){
        let dateFormatter = DateFormatter();
        let time = sender.date.toLocalTime();
        print("get the current time: ", time);
        
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC");
        dateFormatter.dateFormat = "HH";
        date.hour = Int(dateFormatter.string(from: time));
        dateFormatter.dateFormat = "mm";
        date.minute = Int(dateFormatter.string(from: (time)));
        
        defaults.set(time.toGlobalTime(), forKey: alertTimeStringKey);

        //MAKE IT A SPECIFIC DAY TRIGGER NOTIFICATION: https://stackoverflow.com/questions/45061324/repeating-local-notifications-for-specific-days-of-week-swift-3-ios-10
    }//end setTimeForNotifcation
}
