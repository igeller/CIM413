//
//  ViewController.swift
//  InstaDiary
//
//  Created by Izzy Geller on 1/23/19.
//  Copyright © 2019 Isabelle Geller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //variables for the diaryEntry Function
    @IBOutlet var weatherLabel:UILabel!
    @IBOutlet var weatherTextField:UITextField!

    @IBOutlet var activityLabel: UILabel!
    @IBOutlet var activityTextField:UITextField!
    
    @IBOutlet var button:UIButton!
    @IBOutlet var buttonTextField:UITextField!
    
    //get diary information function
    @IBAction func diaryEntry(){
        //get text from from the weatherTextField
        
        let weatherText = weatherTextField.text!
        let activityText = activityTextField.text!
        
        buttonTextField.text = "Today is " + weatherText + " and I am going " + activityText
    }
    


}

