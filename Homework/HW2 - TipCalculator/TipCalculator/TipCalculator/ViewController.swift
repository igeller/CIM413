//
//  ViewController.swift
//  TipCalculator
//
//  Created by Izzy Geller on 2/2/19.
//  Copyright © 2019 Isabelle Geller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet var totalB4TipTextField:UITextField!      //variable so we can get the value from the total txt field
    @IBOutlet var tip15AmtLabel:UILabel!           //tip15 text field
    @IBOutlet var tip15TotalAmtLabel:UILabel!           //tip15 text field
    @IBOutlet var tip20AmtLabel:UILabel!           //tip15 text field
    @IBOutlet var tip20TotalAmtLabel:UILabel!           //tip15 text field
    
    
    //function to calculate tip upon button press
    @IBAction func calcTip(sender: AnyObject){
        var total: Float
        var tip15, total15 :  Float
        var tip20, total20 : Float
        
        let totalString = totalB4TipTextField.text!
        total = Float(totalString)!         //convert string in text field to float
        
        tip15 = total*0.15
        tip15AmtLabel.text = "$" + String(format: "%.2f", tip15)    //add the value of tip to the text field
        total15 = total + tip15
        tip15TotalAmtLabel.text = "$" + String(format: "%.2f", total15)
        
        tip20 = total * 0.20
        tip20AmtLabel.text = "$" + String(format: "%.2f", tip20)
        total20 = total + tip20
        tip20TotalAmtLabel.text = "$" + String(format: "%.2f", total20)
    }

    


}

