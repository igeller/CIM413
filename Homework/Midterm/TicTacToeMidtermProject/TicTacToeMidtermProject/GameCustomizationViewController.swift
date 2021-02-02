//
//  GameCustomizationViewController.swift
//  TicTacToeMidtermProject
//
//  Created by Izzy Geller on 2/25/19.
//  Copyright © 2019 Isabelle Geller. All rights reserved.
//

import UIKit

class GameCustomizationViewController: UIViewController, UITextFieldDelegate {
    
    /***************************** GLOBAL VARIABLES DECLARATIONS/ INSTANTIATIONS *****************************/
    var p1Name:String = "Player 1"  //string variable to hold the name of player 1
    var p2Name:String = "Player 2" //string variable to hold the name of player 2
    
    @IBOutlet weak var p1Field:UITextField!  //make text fields variables so we can save their text later
    @IBOutlet weak var p2Field:UITextField!
    
    @IBOutlet var p1Label:UILabel!      //create labels to display the current player characteristics
    @IBOutlet var p2Label:UILabel!
    @IBOutlet var boardLabel:UILabel!
    
    @IBOutlet var chooseColors:UIButton!
  
    //variables passed bac from ColorPicker
    var boardColor:UIColor = UIColor(red: 251/255, green: 215/255, blue: 253/255, alpha: 1)              //default colort
    var p1Color:UIColor = UIColor.green
    var p2Color:UIColor = UIColor.cyan
    
    
    
    //colo picker popup
    //@IBOutlet var colorPickPOP:UIView!
    //var colorPicked:UIColor!
    /********************************************************************************************************/

    
    
    /******************************************* FUNCTIONS ******************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        boardLabel.backgroundColor = boardColor
        p1Label.backgroundColor = p1Color
        p2Label.backgroundColor = p2Color
        
        //set the borders of the labels
        boardLabel.layer.borderWidth = 0.3
        boardLabel.layer.borderColor = UIColor.gray.cgColor
        
        p1Label.layer.borderWidth = 0.3
        p1Label.layer.borderColor = UIColor.gray.cgColor
        
        p2Label.layer.borderWidth = 0.3
        p2Label.layer.borderColor = UIColor.gray.cgColor
        
        chooseColors.layer.cornerRadius = 17
        p2Label.layer.borderWidth = 0.1
        p2Label.layer.borderColor = UIColor.gray.cgColor

        
        p1Field.delegate = self
        p2Field.delegate = self

    }//END viewDidLoad
    
    
    //function to set values to defaults
    func defaultValues(){
        p1Name = "Player 1"
        p2Name = "Player 2"
        
        p1Label.text = p1Name
        p2Label.text = p2Name
        
        boardColor = UIColor(red: 251/255, green: 215/255, blue: 253/255, alpha: 1)
        
    }//end defaultValues
    
    
    //function to pass data between views
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue){
        if sender.source is ColorPickerViewController{
            if let senderVC = sender.source as? ColorPickerViewController{
                boardLabel.backgroundColor = senderVC.colorArray[0]
                p1Label.backgroundColor = senderVC.colorArray[1]
                p2Label.backgroundColor = senderVC.colorArray[2]
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "StartGameCustom"){
            let displayNextScene = segue.destination as? GameBoardViewController    //set the next view
            displayNextScene?.p1Name = p1Name   //send the name of player 1 to board
            displayNextScene?.p2Name = p2Name   //send the name of player 2 to board
            displayNextScene?.boardColor = (boardLabel.backgroundColor)!   //send the color selected for the board
            displayNextScene?.p1Color = (p1Label.backgroundColor)!   //send the color selected for the board
            displayNextScene?.p2Color = (p2Label.backgroundColor)!   //send the color selected for the board

        }else if(segue.identifier == "ColorPick"){
            let displayNextScene = segue.destination as? ColorPickerViewController
            displayNextScene?.p1Name = (p1Label.text)!
            displayNextScene?.p2Name = (p2Label.text)!
        }
     }
    
    
    /***************************************** IBACTION FUNCTIONS *****************************************/
    //function to obtain the names from p1 text field and save it
    @IBAction func updateDefaults(){
        if(p1Field.text != ""){     //set p1Name and label to value in the field if it is not empty
            p1Name = p1Field.text!
            p1Label.text = p1Name
        }
        
        if(p2Field.text != ""){    //set p1Name and label to value in the field if it is not empty
            p2Name = p2Field.text!
            p2Label.text = p2Name
        }
    }//end updateDefaults
    
    
    //hide keyboard when tap outside field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //hide keyboard if return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
