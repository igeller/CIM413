//
//  ColorPickerViewController.swift
//  TicTacToeMidtermProject
//
//  Created by Izzy Geller on 3/18/19.
//  Copyright © 2019 Isabelle Geller. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController {
    
    /***************************** GLOBAL VARIABLES DECLARATIONS/ INSTANTIATIONS *****************************/
    var pickedColor:UIColor! //declare variable to hold the color chosen
    
    var whoseColor:Int = 0
    @IBOutlet var colorPicked:UILabel!
     var defaultCol:UIColor = UIColor.white
    
    //change the background of labels to show what
    @IBOutlet var boardLabel:UILabel!
    @IBOutlet var p1Label:UILabel!
    @IBOutlet var p2Label:UILabel!

    //to hold the data passed by changing names
    var p1Name:String = "Player 1"
    var p2Name:String = "player 2"
    
    
    var boardColor:UIColor!
    var p1Color:UIColor!
    var p2Color:UIColor!
    var click:Int = 0
    var colorArray:[UIColor]!
    
    //color buttons so we can reset titles
    @IBOutlet var B00 : UIButton!;       @IBOutlet var B01 : UIButton!;       @IBOutlet var B02 : UIButton!
    @IBOutlet var B10 : UIButton!;       @IBOutlet var B11 : UIButton!;       @IBOutlet var B12 : UIButton!
    @IBOutlet var B20 : UIButton!;       @IBOutlet var B21 : UIButton!;       @IBOutlet var B22 : UIButton!
    @IBOutlet var B30 : UIButton!;       @IBOutlet var B31 : UIButton!;       @IBOutlet var B32 : UIButton!
    @IBOutlet var B40 : UIButton!;       @IBOutlet var B41 : UIButton!;       @IBOutlet var B42 : UIButton!

    
    
    
    /********************************************************************************************************/
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        colorArray = [defaultCol, defaultCol, defaultCol]
        instructionAlert();
        
        setBorders();
        
        p1Label.text = p1Name;
        p2Label.text = p2Name;
    }
    

    @IBAction func colorSelected(clickBTN:UIButton){
        pickedColor = (clickBTN.backgroundColor)!; //get the color from button clicked
    
        if(colorArray[0] == pickedColor || colorArray[1] == pickedColor || colorArray[2] == pickedColor){
            resetColors(btn: clickBTN);
        }else{
                if(click == 0){
                    setLabels(arrayPos: click, clickedBtn: clickBTN, updateBtnLabel: boardLabel)
                }else if(click == 1){
                    setLabels(arrayPos: click, clickedBtn: clickBTN, updateBtnLabel: p1Label)
                }else if(click == 2){
                    setLabels(arrayPos: click, clickedBtn: clickBTN, updateBtnLabel: p2Label)
                }
                click += 1;
            }
        }
        
    
    @IBAction func setColor(){
        var white:Bool = false;
        for i in 0...2{
            if(colorArray[i] == UIColor.white){
                white = true;
            }
            print(String(i) + ": " + String(white))
        }
        
        if(colorArray[0] == UIColor.white || colorArray[1] == UIColor.white || colorArray[2] == UIColor.white){
            let message = "Colors cannot be white!"
            let alert = UIAlertController(title: "PICK MORE COLORS:", message: message, preferredStyle: .alert)
            
            let dismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil);
            alert.addAction(dismiss)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func inforBttn(){
        instructionAlert();
    }
    
    
    
    func setLabels(arrayPos:Int, clickedBtn:UIButton, updateBtnLabel:UILabel){
        colorArray[arrayPos] = pickedColor
        boardColor = pickedColor;
        updateBtnLabel.backgroundColor = pickedColor
        clickedBtn.setTitle(updateBtnLabel.text, for: .normal)
    }
    
    
    func resetColors(btn:UIButton){
        click = 0;
        boardLabel.backgroundColor = UIColor.white
        p1Label.backgroundColor = UIColor.white
        p2Label.backgroundColor = UIColor.white
        
        for i in 0...2{ //set the color array back to defaults
            colorArray[i] = UIColor.white;
        }
        
        //change all color buttons back to default no title
        B00.setTitle("", for: .normal);     B01.setTitle("", for: .normal);     B02.setTitle("", for: .normal)
        B10.setTitle("", for: .normal);     B11.setTitle("", for: .normal);     B12.setTitle("", for: .normal)
        B20.setTitle("", for: .normal);     B21.setTitle("", for: .normal);     B22.setTitle("", for: .normal)
        B30.setTitle("", for: .normal);     B31.setTitle("", for: .normal);     B32.setTitle("", for: .normal)
        B40.setTitle("", for: .normal);     B41.setTitle("", for: .normal);     B42.setTitle("", for: .normal)
    }
    
    
    func instructionAlert(){
        let message:String="Click three different colors. To reset click a selected color again. Click \"save\" to save.";
        
        let alert = UIAlertController(title: "Intructions", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK! Start Picking!", style: .default, handler: nil)
        
        alert.addAction(action);
        present(alert, animated: true, completion: nil)
    }
    
    func setBorders(){
        boardLabel.layer.borderWidth = 0.3
        boardLabel.layer.borderColor = UIColor.gray.cgColor
        
        p1Label.layer.borderWidth = 0.3
        p1Label.layer.borderColor = UIColor.gray.cgColor

        p2Label.layer.borderWidth = 0.3
        p2Label.layer.borderColor = UIColor.gray.cgColor

        
        
        B00.layer.cornerRadius = 27.5;
        B00.layer.borderWidth = 0.1;
        B00.layer.borderColor = UIColor.gray.cgColor
    
        B01.layer.cornerRadius = 27.5;
        B01.layer.borderWidth = 0.1;
        B01.layer.borderColor = UIColor.gray.cgColor
        
        B02.layer.cornerRadius = 27.5;
        B02.layer.borderWidth = 0.1;
        B02.layer.borderColor = UIColor.gray.cgColor
        
        B10.layer.cornerRadius = 27.5;
        B10.layer.borderWidth = 0.1;
        B10.layer.borderColor = UIColor.gray.cgColor
    
        B11.layer.cornerRadius = 27.5;
        B11.layer.borderWidth = 0.1;
        B11.layer.borderColor = UIColor.gray.cgColor
        
        B12.layer.cornerRadius = 27.5;
        B12.layer.borderWidth = 0.1;
        B12.layer.borderColor = UIColor.gray.cgColor
        
        B20.layer.cornerRadius = 27.5;
        B20.layer.borderWidth = 0.1;
        B20.layer.borderColor = UIColor.gray.cgColor
        
        B21.layer.cornerRadius = 27.5;
        B21.layer.borderWidth = 0.1;
        B21.layer.borderColor = UIColor.gray.cgColor
        
        B22.layer.cornerRadius = 27.5;
        B22.layer.borderWidth = 0.1;
        B22.layer.borderColor = UIColor.gray.cgColor
        
        B30.layer.cornerRadius = 27.5;
        B30.layer.borderWidth = 0.1;
        B30.layer.borderColor = UIColor.gray.cgColor
        
        B31.layer.cornerRadius = 27.5;
        B31.layer.borderWidth = 0.1;
        B31.layer.borderColor = UIColor.gray.cgColor
        
        B32.layer.cornerRadius = 27.5;
        B32.layer.borderWidth = 0.1;
        B32.layer.borderColor = UIColor.gray.cgColor
        
        B40.layer.cornerRadius = 27.5;
        B40.layer.borderWidth = 0.1;
        B40.layer.borderColor = UIColor.gray.cgColor
        
        B41.layer.cornerRadius = 27.5;
        B41.layer.borderWidth = 0.1;
        B41.layer.borderColor = UIColor.gray.cgColor
        
        B42.layer.cornerRadius = 27.5;
        B42.layer.borderWidth = 0.1;
        B42.layer.borderColor = UIColor.gray.cgColor
    }
    
    

}
