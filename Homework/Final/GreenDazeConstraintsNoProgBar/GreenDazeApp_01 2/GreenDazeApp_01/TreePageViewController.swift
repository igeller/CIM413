//
//  TreePageViewController.swift
//  GreenDazeApp_01
//
//  Created by Juniette Fiore on 4/14/19.
//  Copyright © 2019 Juniette Fiore. All rights reserved.
//

import UIKit

class TreePageViewController: UIViewController {

    //globals
    let defaults = UserDefaults();
    var recycleEndDate:Date!
    var currentNumRecycleLoggings:Int!
    var goalNumRecycleLoggings:Int!
    
    @IBOutlet var recycleGoalBtn:UIButton!
    @IBOutlet var recyclePercentLabel: UILabel!
    
    //recycle leave iboutlet
    @IBOutlet var g1:UIImageView!
    @IBOutlet var g2:UIImageView!
    @IBOutlet var g3:UIImageView!
    @IBOutlet var g4:UIImageView!
    @IBOutlet var g5:UIImageView!
    @IBOutlet var g6:UIImageView!
    @IBOutlet var g7:UIImageView!
    @IBOutlet var g8:UIImageView!
    @IBOutlet var g9:UIImageView!
    @IBOutlet var g10:UIImageView!
    @IBOutlet var g11:UIImageView!
    @IBOutlet var g12:UIImageView!
    @IBOutlet var g13:UIImageView!
    
    var recycleLeavesAreHidden:[Bool] = [Bool](repeating: true, count: 13);
    
    //user default keys
    var recGoalEndDateKey = "recycleGoalEndDate"
    var recTrackGoalToggleKey = "recycleTrackToggleIsOn"
    var recCurrentNumberOfLoggingsKey = "currentNumOfRecycleLoggings"
    var recNumTimesToLogKey = "numTimesToLogRecycle"
    var recLeafAddedYetKey = "recycleLeafAddedYet"
    var recLeavesAreHiddenArrKey = "recycleLeavesAreHiddenArr"
    
    
    
    
    //reuse leave iboutlet
    @IBOutlet var r1:UIImageView!
    @IBOutlet var r2:UIImageView!
    @IBOutlet var r3:UIImageView!
    @IBOutlet var r4:UIImageView!
    @IBOutlet var r5:UIImageView!
    @IBOutlet var r6:UIImageView!
    @IBOutlet var r7:UIImageView!
    @IBOutlet var r8:UIImageView!
    @IBOutlet var r9:UIImageView!
    @IBOutlet var r10:UIImageView!
    @IBOutlet var r11:UIImageView!
    @IBOutlet var r12:UIImageView!
    @IBOutlet var r13:UIImageView!
    
    var reuseEndDate:Date!
    var currentNumReuseLoggings:Int!
    var goalNumReuseLoggings:Int!
    
    @IBOutlet var reuseGoalBtn:UIButton!
    @IBOutlet var reusePercentLabel: UILabel!
    
    var reuseLeavesAreHidden:[Bool] = [Bool](repeating: true, count: 13);
    
    //user default keys
    var reuGoalEndDateKey = "reuseGoalEndDate"
    var reuTrackGoalToggleKey = "reuseTrackToggleIsOn"
    var reuCurrentNumberOfLoggingsKey = "currentNumOfReuseLoggings"
    var reuNumTimesToLogKey = "numTimesToLogReuse"
    var reuLeafAddedYetKey = "reuseLeafAddedYet"
    var reuLeavesAreHiddenArrKey = "reuseLeavesAreHiddenArr"
    
    
    
    
    //transport leave iboutlet
    @IBOutlet var y1:UIImageView!
    @IBOutlet var y2:UIImageView!
    @IBOutlet var y3:UIImageView!
    @IBOutlet var y4:UIImageView!
    @IBOutlet var y5:UIImageView!
    @IBOutlet var y6:UIImageView!
    @IBOutlet var y7:UIImageView!
    @IBOutlet var y8:UIImageView!
    @IBOutlet var y9:UIImageView!
    @IBOutlet var y10:UIImageView!
    @IBOutlet var y11:UIImageView!
    @IBOutlet var y12:UIImageView!
    @IBOutlet var y13:UIImageView!
    
    var transportEndDate:Date!
    var currentNumTransportLoggings:Int!
    var goalNumTransportLoggings:Int!
    
    @IBOutlet var transportGoalBtn:UIButton!
    @IBOutlet var transportPercentLabel: UILabel!
    
    var transportLeavesAreHidden:[Bool] = [Bool](repeating: true, count: 13);
    
    //user default keys
    var tranGoalEndDateKey = "transportGoalEndDate"
    var tranTrackGoalToggleKey = "transportTrackToggleIsOn"
    var tranCurrentNumberOfLoggingsKey = "currentNumOfTransportLoggings"
    var tranNumTimesToLogKey = "numTimesToLogTransport"
    var tranLeafAddedYetKey = "transportLeafAddedYet"
    var tranLeavesAreHiddenArrKey = "transportLeavesAreHiddenArr"
    
    
    //transport leave iboutlet
    @IBOutlet var b1:UIImageView!
    @IBOutlet var b2:UIImageView!
    @IBOutlet var b3:UIImageView!
    @IBOutlet var b4:UIImageView!
    @IBOutlet var b5:UIImageView!
    @IBOutlet var b6:UIImageView!
    @IBOutlet var b7:UIImageView!
    @IBOutlet var b8:UIImageView!
    @IBOutlet var b9:UIImageView!
    @IBOutlet var b10:UIImageView!
    @IBOutlet var b11:UIImageView!
    @IBOutlet var b12:UIImageView!
    @IBOutlet var b13:UIImageView!
    
    var waterEndDate:Date!
    var currentNumWaterLoggings:Int!
    var goalNumWaterLoggings:Int!
    
    @IBOutlet var waterGoalBtn:UIButton!
    @IBOutlet var waterPercentLabel: UILabel!
    
    var waterLeavesAreHidden:[Bool] = [Bool](repeating: true, count: 13);
    
    //user default keys
    var watGoalEndDateKey = "waterGoalEndDate"
    var watTrackGoalToggleKey = "waterTrackToggleIsOn"
    var watCurrentNumberOfLoggingsKey = "currentNumOfWaterLoggings"
    var watNumTimesToLogKey = "numTimesToLogWater"
    var watLeafAddedYetKey = "waterLeafAddedYet"
    var watLeavesAreHiddenArrKey = "waterLeavesAreHiddenArr"

    
    var recycleEndDateSetKey = "recycleEndDateHasBeenSet"
    var reuseEndDateSetKey = "reuseEndDateHasBeenSet"
    var transportEndDateSetKey = "transportEndDateHasBeenSet"
    var waterEndDateSetKey = "waterEndDateHasBeenSet"
    

/**************************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //recycle goal stuff
        recycleEndDate = defaults.object(forKey: recGoalEndDateKey) as? Date ?? Date(); //gets the date and time at which your goal will end based on the time at which the goal was saved NOT at which the alert time was set!!!
        print("end date: ", recycleEndDate)
        if(Date() >= recycleEndDate && defaults.bool(forKey: recTrackGoalToggleKey) && defaults.bool(forKey: recycleEndDateSetKey)){
            print("oh no, you failed");
            makeDidNotReachGoalAlert(category: "recycling");
            defaults.set(0, forKey: recCurrentNumberOfLoggingsKey);
        }
        setRecyclePicFortreeRoot(); //set the picture based on percent for the root goal tracker
        defaultGreenLeavesView(); //set the values for leaves
        
        
        
        //reuse goal stuff
        reuseEndDate = defaults.object(forKey: reuGoalEndDateKey) as? Date ?? Date(); //gets the date and time at which your goal will end based on the time at which the goal was saved NOT at which the alert time was set!!!
        print("end date: ", reuseEndDate)
        if(Date() >= reuseEndDate && defaults.bool(forKey: reuTrackGoalToggleKey) && defaults.bool(forKey: reuseEndDateSetKey)){
            print("oh no, you failed");
            makeDidNotReachGoalAlert(category: "reuse");
            defaults.set(0, forKey: reuCurrentNumberOfLoggingsKey);
        }
        setReusePicFortreeRoot(); //set the picture based on percent for the root goal tracker
        defaultRedLeavesView(); //set the values for leaves
        
        
        
        //transport goal stuff
        transportEndDate = defaults.object(forKey: tranGoalEndDateKey) as? Date ?? Date(); //gets the date and time at which your goal will end based on the time at which the goal was saved NOT at which the alert time was set!!!
        print("end date: ", transportEndDate)
        if(Date() >= transportEndDate && defaults.bool(forKey: tranTrackGoalToggleKey) && defaults.bool(forKey: transportEndDateSetKey)){
            print("oh no, you failed");
            makeDidNotReachGoalAlert(category: "transport");
            defaults.set(0, forKey: tranCurrentNumberOfLoggingsKey);
        }
        setTransportPicFortreeRoot(); //set the picture based on percent for the root goal tracker
        defaultYellowLeavesView(); //set the values for leaves
        
        
        
        waterEndDate = defaults.object(forKey: watGoalEndDateKey) as? Date ?? Date(); //gets the date and time at which your goal will end based on the time at which the goal was saved NOT at which the alert time was set!!!
        print("end date: ", waterEndDate)
        if(Date() >= waterEndDate && defaults.bool(forKey: watTrackGoalToggleKey) && defaults.bool(forKey: waterEndDateSetKey)){
            print("oh no, you failed");
            makeDidNotReachGoalAlert(category: "water usage");
            defaults.set(0, forKey: watCurrentNumberOfLoggingsKey);
        }
        setWaterPicFortreeRoot(); //set the picture based on percent for the root goal tracker
        defaultBlueLeavesView(); //set the values for leaves
        navigationController?.isNavigationBarHidden = false;
        navigationController?.hidesBarsOnTap = false
    }
    override var prefersStatusBarHidden: Bool {
        return navigationController?.isNavigationBarHidden == true
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    
    
    
    @IBAction func recycleBtnClick(_ sender: Any){
        self.performSegue(withIdentifier: "segueFromRecycleTreeGoalToRecycleTreeLog", sender: self); //segue to the log
    }
    
    @IBAction func reuseBtnClick(_ sender: Any){
        self.performSegue(withIdentifier: "segueFromRecycleTreeGoalToRecycleTreeLog", sender: self); //segue to the log
    }
    
    @IBAction func transportBtnClick(_ sender: Any){
        self.performSegue(withIdentifier: "segueFromRecycleTreeGoalToRecycleTreeLog", sender: self); //segue to the log
    }
    
    @IBAction func waterBtnClick(_ sender: Any){
        self.performSegue(withIdentifier: "segueFromRecycleTreeGoalToRecycleTreeLog", sender: self); //segue to the log
    }
    
    
    
    //determine percent of goal
    func determineRecycleGoalCompletionPercent() -> Double{
        currentNumRecycleLoggings = defaults.integer(forKey: recCurrentNumberOfLoggingsKey); //get the number of
        goalNumRecycleLoggings = defaults.integer(forKey: recNumTimesToLogKey);
        
        var dec = Double(currentNumRecycleLoggings) / Double(goalNumRecycleLoggings);
        if(dec == 1 && defaults.bool(forKey: recLeafAddedYetKey) == false){
            recycleGoalAchieved();
            defaults.set(true, forKey: recLeafAddedYetKey);
        }else if(dec == 0){
            dec = 0;
        }
        print("percent", dec)
        //dec = (dec * 100) / 100
        let perc = dec * 100;
        recyclePercentLabel?.text = "\(perc)%"
        return dec
    }
    
    func recycleGoalAchieved(){
        var spotAvailable:Bool = false;
        var isHidden = defaults.array(forKey: recLeavesAreHiddenArrKey) as? [Bool] ?? [Bool()]
        
        for i in 0...12{
            if(isHidden[i] == true){
                isHidden[i] = false;
                makeLeafAlert(category: "recyling");
                spotAvailable = true;
                break;
            }//end if
            
        }//end for
        defaults.set(isHidden, forKey: recLeavesAreHiddenArrKey); //update defaults array
        print(isHidden)
        defaultGreenLeavesView();
        if(!spotAvailable){
            makeFullTreeAlert(category: "recycling")
        }
    }//end recycleGoalAchieved
    
    //set recycle pics
    func setRecyclePicFortreeRoot(){
        let percent = determineRecycleGoalCompletionPercent();
        if(percent >= 0 && percent < 0.1){
            let recycle0 = #imageLiteral(resourceName: "Recycle-0");
            recycleGoalBtn.setImage(recycle0, for: .normal);
        }else if(percent >= 0.1 && percent < 0.2){
            let recycle1 = #imageLiteral(resourceName: "Recycle-10.png");
            recycleGoalBtn.setImage(recycle1, for: .normal);
        }else if(percent >= 0.2 && percent < 0.3){
            let recycle2 = #imageLiteral(resourceName: "Recycle-20.png");
            recycleGoalBtn.setImage(recycle2, for: .normal);
        }else if(percent >= 0.3 && percent < 0.4){
            let recycle3 = #imageLiteral(resourceName: "Recycle-30");
            recycleGoalBtn.setImage(recycle3, for: .normal);
        }else if(percent >= 0.4 && percent < 0.5){
            let recycle4 = #imageLiteral(resourceName: "Recycle-40.png");
            recycleGoalBtn.setImage(recycle4, for: .normal);
        }else if(percent >= 0.5 && percent < 0.6){
            let recycle5 = #imageLiteral(resourceName: "Recycle-50.png");
            recycleGoalBtn.setImage(recycle5, for: .normal);
        }else if(percent >= 0.6 && percent < 0.7){
            let recycle6 = #imageLiteral(resourceName: "Recycle-60.png");
            recycleGoalBtn.setImage(recycle6, for: .normal);
        }else if(percent >= 0.7 && percent < 0.8){
            let recycle7 = #imageLiteral(resourceName: "Recycle-70.png");
            recycleGoalBtn.setImage(recycle7, for: .normal);
        }else if(percent >= 0.8 && percent < 0.9){
            let recycle8 = #imageLiteral(resourceName: "Recycle-80.png");
            recycleGoalBtn.setImage(recycle8, for: .normal);
        }else if(percent >= 0.9 && percent < 1){
            let recycle9 = #imageLiteral(resourceName: "Recycle-100.png");
            recycleGoalBtn.setImage(recycle9, for: .normal);
        }else if(percent == 1){
            let recycle10 = #imageLiteral(resourceName: "Recycle-100");
            recycleGoalBtn.setImage(recycle10, for: .normal);
        }else{
            let recycle0 = #imageLiteral(resourceName: "Recycle-0");
            recycleGoalBtn.setImage(recycle0, for: .normal);
        }
    }
    
    func defaultGreenLeavesView(){ //the leaves are going to be set with default values of false
        var isHidden = defaults.array(forKey: recLeavesAreHiddenArrKey) as? [Bool] ?? [Bool()] //array ofboolean values, which contains the value of hidden or visible of each leaf
        if(isHidden.count < 13){
            isHidden = recycleLeavesAreHidden;
        }
        for i in 0...12{
            if isHidden[i] == true{
                if(i == 0){
                    g1.isHidden = true;
                }else if(i == 1){
                    g2.isHidden = true;
                }else if(i == 2){
                    g3.isHidden = true;
                }else if(i == 3){
                    g4.isHidden = true;
                }else if(i == 4){
                    g5.isHidden = true;
                }else if(i == 5){
                    g6.isHidden = true;
                }else if(i == 6){
                    g7.isHidden = true;
                }else if(i == 7){
                    g8.isHidden = true;
                }else if(i == 8){
                    g9.isHidden = true;
                }else if(i == 9){
                    g10.isHidden = true;
                }else if(i == 10){
                    g11.isHidden = true;
                }else if(i == 11){
                    g12.isHidden = true;
                }else if(i == 12){
                    g13.isHidden = true;
                }
            }else{
                if(i == 0){
                    g1.isHidden = false;
                    print("i should be unhidden")
                }else if(i == 1){
                    g2.isHidden = false;
                }else if(i == 2){
                    g3.isHidden = false;
                }else if(i == 3){
                    g4.isHidden = false;
                }else if(i == 4){
                    g5.isHidden = false;
                }else if(i == 5){
                    g6.isHidden = false;
                }else if(i == 6){
                    g7.isHidden = false;
                }else if(i == 7){
                    g8.isHidden = false;
                }else if(i == 8){
                    g9.isHidden = false;
                }else if(i == 9){
                    g10.isHidden = false;
                }else if(i == 10){
                    g11.isHidden = false;
                }else if(i == 11){
                    g12.isHidden = false;
                }else if(i == 12){
                    g13.isHidden = false;
                }
                isHidden[i] = false
            }//end else
        }//end for
        defaults.set(isHidden, forKey: recLeavesAreHiddenArrKey); //update defaults array
    }//end defaultLeavesView
    
    
    
    
    
    //determine percent of goal
    func determineReuseGoalCompletionPercent() -> Double{
        currentNumReuseLoggings = defaults.integer(forKey: reuCurrentNumberOfLoggingsKey); //get the number of
        goalNumReuseLoggings = defaults.integer(forKey: reuNumTimesToLogKey);
        
        var dec = Double(currentNumReuseLoggings) / Double(goalNumReuseLoggings);
        if(dec == 1 && defaults.bool(forKey: reuLeafAddedYetKey) == false){
            reuseGoalAchieved();
            defaults.set(true, forKey: reuLeafAddedYetKey);
        }else if(dec == 0){
            dec = 0;
        }
        print("percent", dec)
        //dec = (dec * 100) / 100
        let perc = dec * 100;
        reusePercentLabel?.text = "\(perc)%"
        return dec
    }
    
    func reuseGoalAchieved(){
        var spotAvailable:Bool = false;
        var isHidden = defaults.array(forKey: reuLeavesAreHiddenArrKey) as? [Bool] ?? [Bool()]
        
        for i in 0...12{
            if(isHidden[i] == true){
                isHidden[i] = false;
                makeLeafAlert(category: "reuse");
                spotAvailable = true;
                break;
            }//end if
            
        }//end for
        defaults.set(isHidden, forKey: reuLeavesAreHiddenArrKey); //update defaults array
        print(isHidden)
        defaultRedLeavesView();
        if(!spotAvailable){
            makeFullTreeAlert(category: "reuse")
        }
    }//end reusegoalachieved
    
    //set REUSE pics
    func setReusePicFortreeRoot(){
        let percent = determineReuseGoalCompletionPercent();
        if(percent >= 0 && percent < 0.1){
            let recycle0 = #imageLiteral(resourceName: "Reuse-0.png");
            reuseGoalBtn.setImage(recycle0, for: .normal);
        }else if(percent >= 0.1 && percent < 0.2){
            let recycle1 = #imageLiteral(resourceName: "Reuse-10.png");
            reuseGoalBtn.setImage(recycle1, for: .normal);
        }else if(percent >= 0.2 && percent < 0.3){
            let recycle2 = #imageLiteral(resourceName: "Reuse-20.png");
            reuseGoalBtn.setImage(recycle2, for: .normal);
        }else if(percent >= 0.3 && percent < 0.4){
            let recycle3 = #imageLiteral(resourceName: "Reuse-30.png");
            reuseGoalBtn.setImage(recycle3, for: .normal);
        }else if(percent >= 0.4 && percent < 0.5){
            let recycle4 = #imageLiteral(resourceName: "Reuse-40.png");
            reuseGoalBtn.setImage(recycle4, for: .normal);
        }else if(percent >= 0.5 && percent < 0.6){
            let recycle5 = #imageLiteral(resourceName: "Reuse-50.png");
            reuseGoalBtn.setImage(recycle5, for: .normal);
        }else if(percent >= 0.6 && percent < 0.7){
            let recycle6 = #imageLiteral(resourceName: "Reuse-60.png");
            reuseGoalBtn.setImage(recycle6, for: .normal);
        }else if(percent >= 0.7 && percent < 0.8){
            let recycle7 = #imageLiteral(resourceName: "Reuse-70.png");
            reuseGoalBtn.setImage(recycle7, for: .normal);
        }else if(percent >= 0.8 && percent < 0.9){
            let recycle8 = #imageLiteral(resourceName: "Reuse-80.png");
            reuseGoalBtn.setImage(recycle8, for: .normal);
        }else if(percent >= 0.9 && percent < 1){
            let recycle9 = #imageLiteral(resourceName: "Reuse-90.png");
            reuseGoalBtn.setImage(recycle9, for: .normal);
        }else if(percent == 1){
            let recycle10 = #imageLiteral(resourceName: "Reuse-100.png");
            reuseGoalBtn.setImage(recycle10, for: .normal);
        }else{
            let recycle0 = #imageLiteral(resourceName: "Reuse-0.png");
            reuseGoalBtn.setImage(recycle0, for: .normal);
        }
    }
    
    func defaultRedLeavesView(){ //the leaves are going to be set with default values of false
        var isHidden = defaults.array(forKey: reuLeavesAreHiddenArrKey) as? [Bool] ?? [Bool()] //array ofboolean values, which contains the value of hidden or visible of each leaf
        if(isHidden.count < 13){
            isHidden = reuseLeavesAreHidden;
        }
        for i in 0...12{
            if isHidden[i] == true{
                if(i == 0){
                    r1.isHidden = true;
                }else if(i == 1){
                    r2.isHidden = true;
                }else if(i == 2){
                    r3.isHidden = true;
                }else if(i == 3){
                    r4.isHidden = true;
                }else if(i == 4){
                    r5.isHidden = true;
                }else if(i == 5){
                    r6.isHidden = true;
                }else if(i == 6){
                    r7.isHidden = true;
                }else if(i == 7){
                    r8.isHidden = true;
                }else if(i == 8){
                    r9.isHidden = true;
                }else if(i == 9){
                    r10.isHidden = true;
                }else if(i == 10){
                    r11.isHidden = true;
                }else if(i == 11){
                    r12.isHidden = true;
                }else if(i == 12){
                    r13.isHidden = true;
                }
            }else{
                if(i == 0){
                    r1.isHidden = false;
                    print("i should be unhidden")
                }else if(i == 1){
                    r2.isHidden = false;
                }else if(i == 2){
                    r3.isHidden = false;
                }else if(i == 3){
                    r4.isHidden = false;
                }else if(i == 4){
                    r5.isHidden = false;
                }else if(i == 5){
                    r6.isHidden = false;
                }else if(i == 6){
                    r7.isHidden = false;
                }else if(i == 7){
                    r8.isHidden = false;
                }else if(i == 8){
                    r9.isHidden = false;
                }else if(i == 9){
                    r10.isHidden = false;
                }else if(i == 10){
                    r11.isHidden = false;
                }else if(i == 11){
                    r12.isHidden = false;
                }else if(i == 12){
                    r13.isHidden = false;
                }
                isHidden[i] = false
            }//end else
        }//end for
        defaults.set(isHidden, forKey: reuLeavesAreHiddenArrKey); //update defaults array
    }//end defaultLeavesView
    
    
    
    //transport
    //determine percent of goal
    func determineTransportGoalCompletionPercent() -> Double{
        currentNumTransportLoggings = defaults.integer(forKey: tranCurrentNumberOfLoggingsKey); //get the number of
        goalNumTransportLoggings = defaults.integer(forKey: tranNumTimesToLogKey);
        
        var dec = Double(currentNumTransportLoggings) / Double(goalNumTransportLoggings);
        if(dec == 1 && defaults.bool(forKey: tranLeafAddedYetKey) == false){
            transportGoalAchieved();
            defaults.set(true, forKey: tranLeafAddedYetKey);
        }else if(dec == 0){
            dec = 0;
        }
        print("percent", dec)
        //dec = (dec * 100) / 100
        let perc = dec * 100;
        transportPercentLabel?.text = "\(perc)%"
        return dec
    }
    
    func transportGoalAchieved(){
        var spotAvailable:Bool = false;
        var isHidden = defaults.array(forKey: tranLeavesAreHiddenArrKey) as? [Bool] ?? [Bool()]
        
        for i in 0...12{
            if(isHidden[i] == true){
                isHidden[i] = false;
                makeLeafAlert(category: "transport");
                spotAvailable = true;
                break;
            }//end if
            
        }//end for
        defaults.set(isHidden, forKey: tranLeavesAreHiddenArrKey); //update defaults array
        print(isHidden)
        defaultYellowLeavesView();
        if(!spotAvailable){
            makeFullTreeAlert(category: "transport")
        }
    }//end reusegoalachieved
    
    
    func setTransportPicFortreeRoot(){
        let percent = determineTransportGoalCompletionPercent();
        if(percent >= 0 && percent < 0.1){
            let recycle0 = #imageLiteral(resourceName: "Transportation-0.png");
            transportGoalBtn.setImage(recycle0, for: .normal);
        }else if(percent >= 0.1 && percent < 0.2){
            let recycle1 = #imageLiteral(resourceName: "Transportation-10.png");
            transportGoalBtn.setImage(recycle1, for: .normal);
        }else if(percent >= 0.2 && percent < 0.3){
            let recycle2 = #imageLiteral(resourceName: "Transportation-20.png");
            transportGoalBtn.setImage(recycle2, for: .normal);
        }else if(percent >= 0.3 && percent < 0.4){
            let recycle3 = #imageLiteral(resourceName: "Transportation-30.png");
            transportGoalBtn.setImage(recycle3, for: .normal);
        }else if(percent >= 0.4 && percent < 0.5){
            let recycle4 = #imageLiteral(resourceName: "Transportation-40.png");
            transportGoalBtn.setImage(recycle4, for: .normal);
        }else if(percent >= 0.5 && percent < 0.6){
            let recycle5 = #imageLiteral(resourceName: "Transportation-50.png");
            transportGoalBtn.setImage(recycle5, for: .normal);
        }else if(percent >= 0.6 && percent < 0.7){
            let recycle6 = #imageLiteral(resourceName: "Transportation-60.png");
            transportGoalBtn.setImage(recycle6, for: .normal);
        }else if(percent >= 0.7 && percent < 0.8){
            let recycle7 = #imageLiteral(resourceName: "Transportation-70.png");
            transportGoalBtn.setImage(recycle7, for: .normal);
        }else if(percent >= 0.8 && percent < 0.9){
            let recycle8 = #imageLiteral(resourceName: "Transportation-80.png");
            transportGoalBtn.setImage(recycle8, for: .normal);
        }else if(percent >= 0.9 && percent < 1){
            let recycle9 = #imageLiteral(resourceName: "Transportation-90.png");
            transportGoalBtn.setImage(recycle9, for: .normal);
        }else if(percent == 1){
            let recycle10 = #imageLiteral(resourceName: "Transportation-100.png");
            transportGoalBtn.setImage(recycle10, for: .normal);
        }else{
            let recycle0 = #imageLiteral(resourceName: "Transportation-0.png");
            transportGoalBtn.setImage(recycle0, for: .normal);
        }
    }
    
    func defaultYellowLeavesView(){ //the leaves are going to be set with default values of false
        var isHidden = defaults.array(forKey: tranLeavesAreHiddenArrKey) as? [Bool] ?? [Bool()] //array ofboolean values, which contains the value of hidden or visible of each leaf
        if(isHidden.count < 13){
            isHidden = transportLeavesAreHidden;
        }
        for i in 0...12{
            if isHidden[i] == true{
                if(i == 0){
                    y1.isHidden = true;
                }else if(i == 1){
                    y2.isHidden = true;
                }else if(i == 2){
                    y3.isHidden = true;
                }else if(i == 3){
                    y4.isHidden = true;
                }else if(i == 4){
                    y5.isHidden = true;
                }else if(i == 5){
                    y6.isHidden = true;
                }else if(i == 6){
                    y7.isHidden = true;
                }else if(i == 7){
                    y8.isHidden = true;
                }else if(i == 8){
                    y9.isHidden = true;
                }else if(i == 9){
                    y10.isHidden = true;
                }else if(i == 10){
                    y11.isHidden = true;
                }else if(i == 11){
                    y12.isHidden = true;
                }else if(i == 12){
                    y13.isHidden = true;
                }
            }else{
                if(i == 0){
                    y1.isHidden = false;
                    print("i should be unhidden")
                }else if(i == 1){
                    y2.isHidden = false;
                }else if(i == 2){
                    y3.isHidden = false;
                }else if(i == 3){
                    y4.isHidden = false;
                }else if(i == 4){
                    y5.isHidden = false;
                }else if(i == 5){
                    y6.isHidden = false;
                }else if(i == 6){
                    y7.isHidden = false;
                }else if(i == 7){
                    y8.isHidden = false;
                }else if(i == 8){
                    y9.isHidden = false;
                }else if(i == 9){
                    y10.isHidden = false;
                }else if(i == 10){
                    y11.isHidden = false;
                }else if(i == 11){
                    y12.isHidden = false;
                }else if(i == 12){
                    y13.isHidden = false;
                }
                isHidden[i] = false
            }//end else
        }//end for
        defaults.set(isHidden, forKey: tranLeavesAreHiddenArrKey); //update defaults array
    }//end defaultLeavesView
    
    
    
    //water
    //determine percent of goal
    func determineWaterGoalCompletionPercent() -> Double{
        currentNumWaterLoggings = defaults.integer(forKey: watCurrentNumberOfLoggingsKey); //get the number of
        goalNumWaterLoggings = defaults.integer(forKey: watNumTimesToLogKey);
        
        var dec = Double(currentNumWaterLoggings) / Double(goalNumWaterLoggings);
        if(dec == 1 && defaults.bool(forKey: watLeafAddedYetKey) == false){
            waterGoalAchieved();
            defaults.set(true, forKey: watLeafAddedYetKey);
        }else if(dec == 0){
            dec = 0;
        }
        print("percent", dec)
        //dec = (dec * 100) / 100
        let perc = dec * 100;
        waterPercentLabel?.text = "\(perc)%"
        return dec
    }
    
    func waterGoalAchieved(){
        var spotAvailable:Bool = false;
        var isHidden = defaults.array(forKey: watLeavesAreHiddenArrKey) as? [Bool] ?? [Bool()]
        
        for i in 0...12{
            if(isHidden[i] == true){
                isHidden[i] = false;
                makeLeafAlert(category: "water usage");
                spotAvailable = true;
                break;
            }//end if
            
        }//end for
        defaults.set(isHidden, forKey: watLeavesAreHiddenArrKey); //update defaults array
        print(isHidden)
        defaultBlueLeavesView();
        if(!spotAvailable){
            makeFullTreeAlert(category: "water usage")
        }
    }//end reusegoalachieved
    
    
    func setWaterPicFortreeRoot(){
        let percent = determineWaterGoalCompletionPercent();
        if(percent >= 0 && percent < 0.1){
            let recycle0 = #imageLiteral(resourceName: "WaterUsage-0.png");
            waterGoalBtn.setImage(recycle0, for: .normal);
        }else if(percent >= 0.1 && percent < 0.2){
            let recycle1 = #imageLiteral(resourceName: "WaterUsage-10.png");
            waterGoalBtn.setImage(recycle1, for: .normal);
        }else if(percent >= 0.2 && percent < 0.3){
            let recycle2 = #imageLiteral(resourceName: "WaterUsage-20.png");
            waterGoalBtn.setImage(recycle2, for: .normal);
        }else if(percent >= 0.3 && percent < 0.4){
            let recycle3 = #imageLiteral(resourceName: "WaterUsage-30.png");
            waterGoalBtn.setImage(recycle3, for: .normal);
        }else if(percent >= 0.4 && percent < 0.5){
            let recycle4 = #imageLiteral(resourceName: "WaterUsage-40.png");
            waterGoalBtn.setImage(recycle4, for: .normal);
        }else if(percent >= 0.5 && percent < 0.6){
            let recycle5 = #imageLiteral(resourceName: "WaterUsage-50.png");
            waterGoalBtn.setImage(recycle5, for: .normal);
        }else if(percent >= 0.6 && percent < 0.7){
            let recycle6 = #imageLiteral(resourceName: "WaterUsage-60.png");
            waterGoalBtn.setImage(recycle6, for: .normal);
        }else if(percent >= 0.7 && percent < 0.8){
            let recycle7 = #imageLiteral(resourceName: "WaterUsage-70.png");
            waterGoalBtn.setImage(recycle7, for: .normal);
        }else if(percent >= 0.8 && percent < 0.9){
            let recycle8 = #imageLiteral(resourceName: "WaterUsage-80.png");
            waterGoalBtn.setImage(recycle8, for: .normal);
        }else if(percent >= 0.9 && percent < 1){
            let recycle9 = #imageLiteral(resourceName: "WaterUsage-90.png");
            waterGoalBtn.setImage(recycle9, for: .normal);
        }else if(percent == 1){
            let recycle10 = #imageLiteral(resourceName: "WaterUsage-100.png");
            waterGoalBtn.setImage(recycle10, for: .normal);
        }else{
            let recycle0 = #imageLiteral(resourceName: "WaterUsage-0.png");
            waterGoalBtn.setImage(recycle0, for: .normal);
        }
    }
    
    func defaultBlueLeavesView(){ //the leaves are going to be set with default values of false
        print("should show blue leaves!")
        var isHidden = defaults.array(forKey: watLeavesAreHiddenArrKey) as? [Bool] ?? [Bool()] //array ofboolean values, which contains the value of hidden or visible of each leaf
        if(isHidden.count < 13){
            isHidden = waterLeavesAreHidden;
        }
        for i in 0...12{
            if isHidden[i] == true{
                if(i == 0){
                    b1.isHidden = true;
                }else if(i == 1){
                    b2.isHidden = true;
                }else if(i == 2){
                    b3.isHidden = true;
                }else if(i == 3){
                    b4.isHidden = true;
                }else if(i == 4){
                    b5.isHidden = true;
                }else if(i == 5){
                    b6.isHidden = true;
                }else if(i == 6){
                    b7.isHidden = true;
                }else if(i == 7){
                    b8.isHidden = true;
                }else if(i == 8){
                    b9.isHidden = true;
                }else if(i == 9){
                    b10.isHidden = true;
                }else if(i == 10){
                    b11.isHidden = true;
                }else if(i == 11){
                    b12.isHidden = true;
                }else if(i == 12){
                    b13.isHidden = true;
                }
            }else{
                if(i == 0){
                    b1.isHidden = false;
                }else if(i == 1){
                    b2.isHidden = false;
                }else if(i == 2){
                    b3.isHidden = false;
                }else if(i == 3){
                    b4.isHidden = false;
                }else if(i == 4){
                    b5.isHidden = false;
                }else if(i == 5){
                    b6.isHidden = false;
                }else if(i == 6){
                    b7.isHidden = false;
                }else if(i == 7){
                    b8.isHidden = false;
                }else if(i == 8){
                    b9.isHidden = false;
                }else if(i == 9){
                    b10.isHidden = false;
                }else if(i == 10){
                    b11.isHidden = false;
                }else if(i == 11){
                    b12.isHidden = false;
                }else if(i == 12){
                    b13.isHidden = false;
                }
                isHidden[i] = false
            }//end else
        }//end for
        defaults.set(isHidden, forKey: watLeavesAreHiddenArrKey); //update defaults array
    }//end defaultLeavesView
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func makeFullTreeAlert(category: String){
        let message:String="You have completed all of your \(category) goals!";
        
        let alert = UIAlertController(title: "Congratulations!", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Yay! Let's see the pretty tree!", style: .default, handler: nil)
        
        alert.addAction(action);
        present(alert, animated: true, completion: nil)
    }
    
    func makeLeafAlert(category: String){
        let message:String="You have earned a new \(category) leaf! Don't forget to set a new goal!";
        
        let alert = UIAlertController(title: "Way to Go!", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Yay! Let's see the pretty tree!", style: .default, handler: nil)
        
        alert.addAction(action);
        present(alert, animated: true, completion: nil)
    }
    
    func makeDidNotReachGoalAlert(category: String){
        let message:String="You did not meet your \(category) goal by the deadline :(";
        
        let alert = UIAlertController(title: "Oh No!", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Restart Goal", style: .default, handler: {
            action in self.performSegue(withIdentifier: "segueFromRecycleTreeGoalToRecycleTreeLog", sender: self)
        })
        alert.addAction(action);
        present(alert, animated: true, completion: nil)
    }

}//end main


extension TreePageViewController{
    //unwind segue to homepage
    @IBAction func unwindFromTreeToHome(_ segue: UIStoryboardSegue){
        
    }
}



