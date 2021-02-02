//
//  ViewController.swift
//  QuizAppW5D1
//
//  Created by Izzy Geller on 2/13/19.
//  Copyright © 2019 Isabelle Geller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    let q : [String] = ["What is the Capital of Florida?", "What is 12 % 7?", "What is the name of UM's Mascot?", "What is the Capital of Kentucky?", "Who is the current President?"]
    let a : [String] = ["Tallahassee", "5", "Sebastian", "Frankfort", "Satan"]

    
    @IBOutlet var printQuestAnsw:UIButton!
    @IBOutlet var questAnswList:UILabel!
    var stuff : String = ""
    
    @IBAction func printAllQuestAnsw(sender: AnyObject){
        var i : Int = 0
        while i < q.count {
            stuff += q[i] + "\n" + "\t" + a[i] + "\n"
            i += 1
        }
        
        questAnswList.text = stuff
        print(stuff)
    }
    
    

    var questAnsNum : Int!              //created a global variable so that you could randomize the questions
    func generateRandNum(qCount: Int){
        questAnsNum = Int.random(in: 0..<qCount)
    }
    

    
    
    
    //vars for connection first method
    @IBOutlet var showQuestBtn:UIButton!
    @IBOutlet var questLabel:UILabel!
    
    //function for show question
    @IBAction func questionFunc(sender: AnyObject){
        let qMaxIndex : Int = q.count
        let curIndex = questAnsNum
        
        //generate a new question on click
        while(questAnsNum == curIndex){
            generateRandNum(qCount: qMaxIndex)   //generate a new number for the
        }
        
        questLabel.text = q[questAnsNum]        //set the question to the string at that position in the array
    }//end
    
    
    
    
    
    //var for connections for second method
    @IBOutlet var showAnswBtn:UIButton!
    @IBOutlet var ansLabel:UILabel!
    
    //function for show question
    @IBAction func answerFunc(sender: AnyObject){
        ansLabel.text = a[questAnsNum]
    }
    
    
    

    
    
    

}

