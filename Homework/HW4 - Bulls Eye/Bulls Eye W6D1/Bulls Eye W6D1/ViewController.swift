//
//  ViewController.swift
//  Bulls Eye W6D1
//
//  Created by Izzy Geller on 2/19/19.
//  Copyright © 2019 Isabelle Geller. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
    
    //generate random target number for the slider to obtain
    var targetInt : Int = 0
    var currentRound : Int = 0
    var roundIncrementOkay : Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //generate random target number (arc4random_uniform(100) + 1 (usually goes 0 to 99 inclusive but we want it to go to 100 so then we add 1 so it goes 1 to 100 not 0 100)
        targetInt = Int(arc4random_uniform(100)) + 1
        targetLabel.text = String(targetInt)
        
        //to ensure the load view is standard upon restart
        scoreLabel.text = "99999"
        if(roundIncrementCondition()){
            currentRound += 1
            roundIncrementOkay = false
        }
        roundLabel.text = String(currentRound)
    }
    
    //create IBOutlets for labels and IBActions for Buttons (buttons only use iboutlet when you want to change appearance or something with button while running
    @IBOutlet var targetLabel:UILabel!
    @IBOutlet var scoreLabel:UILabel!
    @IBOutlet var roundLabel:UILabel!
    @IBOutlet var sliderElement:UISlider!
    
    //get the value of the slider upon moving it
    var currentSlideVal : Int = 50
    @IBAction func getSliderValue(slider:UISlider){
        print("The value of the slider is now: \(slider.value)")
        currentSlideVal = lroundf(slider.value)
    }
    
    //method for what happens when hitBttn is clicked
    @IBAction func hitToShowAlert(){
        let scoreInt = 100 - calcScoreAsDifference() //get the score of the game

        scoreLabel.text = String(scoreInt)    //set the score label with the calculated score
        
        let message = "The value of the slider is: \(currentSlideVal)\n"
            + "The value of the target is: \(targetInt)\n"
            + "You scored \(scoreInt) points!"
        let alert = UIAlertController(title: "Attention:", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        

        roundIncrementOkay = true
    }
    
    
    //create a function to calculate the score and return it
    func calcScoreAsDifference() -> Int{
        var difference : Int = 0
        difference = abs(currentSlideVal - targetInt)
        return difference
    }
    
    //function to prevent increment round unless a score has been calculated
    func roundIncrementCondition() -> Bool{
        if(currentRound == 0 || roundIncrementOkay == true){
            return true
        }
        else{
            return false
        }
    }
    
    
    
    
    //method for what happens when info bttn is clicked
    @IBAction func clickToDisplayInfoAlert(){
        
    }
    
    //start over when button is clicked
    @IBAction func startOver(){
        //currentRound+=1
        viewDidLoad();
    }
    
    
    
    
    
    /*pinning the numbers next to the slider is NOT working*/

}

