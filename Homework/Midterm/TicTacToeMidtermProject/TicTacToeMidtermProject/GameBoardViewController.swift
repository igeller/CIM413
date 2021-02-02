//
//  GameBoardViewController.swift
//  TicTacToeMidtermProject
//
//  Created by Izzy Geller on 2/25/19.
//  Copyright © 2019 Isabelle Geller. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {
    /***************************** GLOBAL VARIABLES DECLARATIONS/ INSTANTIATIONS *****************************/
    //variables passed by segue
    var p1Name:String  = "Player 1"
    var p2Name:String = "Player 2"
    var boardColor:UIColor = UIColor(red: 251/255, green: 215/255, blue: 253/255, alpha: 1)
    var p1Color:UIColor = UIColor.green
    var p2Color:UIColor = UIColor.cyan

    
    
    var board:[[Int]]!      //create board array of ints to store player move
    var moveNum:Int!        //indicate the number of total moves that have happened
    var whoseTurn:Int!      //hold the value the current player's turn
    var playerName:String!  //holds the value of the player name
    var winner:Bool!        //variable to hold if there is currently a winner
    
    //Global storyboard variables
    @IBOutlet weak var homeBtn:UIButton!    //home button variable
    @IBOutlet var currentPlayerLabel:UILabel!    //be displayed and hidden when the it is the players turn

    //declaring the board variables so their appearance can be changed
    @IBOutlet var B00 : UIButton!;       @IBOutlet var B01 : UIButton!;       @IBOutlet var B02 : UIButton!
    @IBOutlet var B10 : UIButton!;       @IBOutlet var B11 : UIButton!;       @IBOutlet var B12 : UIButton!
    @IBOutlet var B20 : UIButton!;       @IBOutlet var B21 : UIButton!;       @IBOutlet var B22 : UIButton!
    
    /********************************************************************************************************/
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalState();    //call original state so that all variables are initalized to 0
        print("NAME::::" + p1Name)
    }//end view did load


    //make and orginal state function
    func originalState(){
        board = [ [0,0,0], [0,0,0], [0,0,0] ]   //set value of each position in the array to 0 to indicate no one has played in that square
        moveNum = 0;                            //set the number of moves made to 0 to indicate the game can be played
        whoseTurn = startPlayer();                        //set the start player to player1
        currentPlayer(turn: whoseTurn)      //show the current player lable
        winner = false;                         //at start no one is the winner
        
        
        currentPlayerLabel.text = currentPlayer(turn: whoseTurn)    //set the player labels
        
        
        //set initial color of buttons
        B00.backgroundColor = boardColor
        B01.backgroundColor = boardColor
        B02.backgroundColor = boardColor
        B10.backgroundColor = boardColor
        B11.backgroundColor = boardColor
        B12.backgroundColor = boardColor
        B20.backgroundColor = boardColor
        B21.backgroundColor = boardColor
        B22.backgroundColor = boardColor
        
        //enable buttons to be clicked
        B00.isEnabled = true
        B01.isEnabled = true
        B02.isEnabled = true
        B10.isEnabled = true
        B11.isEnabled = true
        B12.isEnabled = true
        B20.isEnabled = true
        B21.isEnabled = true
        B22.isEnabled = true
    }
    
    
    
    
    /********************************* BUTTON ACTION FUNCTIONS *********************************/
    //declare board buttons actions when clicked from the grid view
    @IBAction func B00Click(){
        B00.isEnabled = false   //disable clicking after space is used

        if(whoseTurn == 1){
            board[0][0] = 1
            B00.backgroundColor = p1Color
        }else{
            board[0][0] = 2
            B00.backgroundColor = p2Color

        }
        changeTurn(r: 0,c: 0)
    }//end B00
    
    @IBAction func B01Click(){
        B01.isEnabled = false   //disable clicking after space is used
        
        if(whoseTurn == 1){
            board[0][1] = 1
            B01.backgroundColor = p1Color

        }else{
            board[0][1] = 2
            B01.backgroundColor = p2Color

        }
        changeTurn(r: 0,c: 1)
    }//end B00
    
    @IBAction func B02Click(){
        B02.isEnabled = false   //disable clicking after space is used
        
        if(whoseTurn == 1){
            board[0][2] = 1
            B02.backgroundColor = p1Color

        }else{
            board[0][2] = 2
            B02.backgroundColor = p2Color

        }
        changeTurn(r: 0,c: 2)
    }//end B00
    
    @IBAction func B10Click(){
        B10.isEnabled = false   //disable clicking after space is used
        
        if(whoseTurn == 1){
            board[1][0] = 1
            B10.backgroundColor = p1Color

        }else{
            board[1][0] = 2
            B10.backgroundColor = p2Color

        }
        changeTurn(r: 1,c: 0)
    }//end B00
    
    @IBAction func B11Click(){
        B11.isEnabled = false   //disable clicking after space is used
        
        if(whoseTurn == 1){
            board[1][1] = 1
            B11.backgroundColor = p1Color

        }else{
            board[1][1] = 2
            B11.backgroundColor = p2Color

        }
        changeTurn(r: 1,c: 1)
    }//end B00
    
    @IBAction func B12Click(){
        B12.isEnabled = false   //disable clicking after space is used
        
        if(whoseTurn == 1){
            board[1][2] = 1
            B12.backgroundColor = p1Color

        }else{
            board[1][2] = 2
            B12.backgroundColor = p2Color

        }
        changeTurn(r: 1,c: 2)
    }//end B00
    
    @IBAction func B20Click(){
        B20.isEnabled = false   //disable clicking after space is used
        
        if(whoseTurn == 1){
            board[2][0] = 1
            B20.backgroundColor = p1Color

        }else{
            board[2][0] = 2
            B20.backgroundColor = p2Color

        }
        changeTurn(r: 2,c: 0)
    }//end B00
    
    @IBAction func B21Click(){
        B21.isEnabled = false   //disable clicking after space is used
        
        if(whoseTurn == 1){
            board[2][1] = 1
            B21.backgroundColor = p1Color

        }else{
            board[2][1] = 2
            B21.backgroundColor = p2Color
        }
        changeTurn(r: 2,c: 1)
    }//end B00
    
    @IBAction func B22Click(){
        B22.isEnabled = false   //disable clicking after space is used
        
        if(whoseTurn == 1){
            board[2][2] = 1
            B22.backgroundColor = p1Color

        }else{
            board[2][2] = 2
            B22.backgroundColor = p2Color
        }
        changeTurn(r: 2,c: 2)
    }//end B00
    /********************************* END BUTTON ACTION FUNCTIONS *********************************/


    
    
    func changeTurn(r: Int, c: Int){      //change player back and fourth
        if(checkForWinner(r: r, c: c)){
            //display popup for winner
            gameOverAlert(winner: true);
        }else if(!notFullBoard()){ //if the board is not not full (ie the board is full)
            gameOverAlert(winner: notFullBoard());
        }
        
        if(whoseTurn == 1){
            whoseTurn = 2
            currentPlayer(turn: whoseTurn)
            
        }else{
            whoseTurn = 1
            currentPlayer(turn: whoseTurn)
        }
    }//end whose turn
    
    
    //display and hide player label
    func currentPlayer(turn:Int) -> String{
        if(whoseTurn == 1){ //then show p1Label and hide p2Label
            currentPlayerLabel.text = p1Name
            currentPlayerLabel.backgroundColor = p1Color
        }else{  //then show p2 label and hid p1Label
            currentPlayerLabel.text = p2Name
            currentPlayerLabel.backgroundColor = p2Color
        }
          return currentPlayerLabel.text!;   //return the name of the current player
    }

        
    //function that checks the board for a winner
    func checkForWinner(r:Int, c:Int) -> Bool{
        //check row
        var win: Bool = true
        for i in 0...2{
            if(board[r][i] != whoseTurn){
                win=false;
                break;
            }
        }
        
        if(win){
            return true;
        }
        
        //check column
        win=true;
        for i in 0...2{
            if(board[i][c] != whoseTurn){
                win=false;
                break;
            }
        }
        
        if(win){
            return true;
        }
        
        //check back diagonal
        win=true;
        for i in 0...2{
            if(board[i][i] != whoseTurn){
                win=false;
                break;
            }
        }
        
        if(win){
            return true;
        }
        
        //check forward diagonal
        win=true;
        for i in 0...2{
            if(board[i][3-i-1] != whoseTurn){
                win=false;
                break;
            }
        }
        
        if(win){
            return true;
        }
        
        return false;
        
    }//end check winner
    
    //create the alert to display when a winner is determined
    func gameOverAlert(winner:Bool){
        var message:String
        var title:String
        
        if(winner){
            message = "The the winner is: " + currentPlayer(turn: whoseTurn)
            title = "WINNER"
        }else{
            message = "It was a cat's game"
            title = "GAMEOVER"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
       
        let rematchAction = UIAlertAction(title: "REMATCH", style: .default, handler: {(UIAlertAction) in
            self.originalState();       //reset board to original state to play another game
        })
        
        let startOverAction = UIAlertAction(title: "STARTOVER", style: .default) { (UIAlertAction) in
            self.performSegue(withIdentifier: "GoHome", sender: Any?.self)  //return to homescreen to start a fresh game with new players
        }
        
        alert.addAction(rematchAction)      //add the rematchAction to alert
        alert.addAction(startOverAction)    //add startOverAction to alert
        present(alert, animated: true, completion: nil)
    }
    
    
    
    //game ended alert
    func gameOverAlert(){
        
    }
    
    
    //method to failrly determine the start player
    func startPlayer() -> Int{
        var player:Int;
        let ran:Double = Double.random(in: 0.0...1.0);
        print(ran);
        var baseLine:Double = 0.5;
        
        if(ran < baseLine){
            player = 2;
        }else{
            player = 1;
            
        }
        return player;
    }
    
    func notFullBoard()->Bool{
        for i in 0...2{
            for j in 0...2{
                if(board[i][j] == 0){ //if there is a 0 on the board that means that the board isnt full and game is not over
                    return true;
                }
            }
        }
        return false;
    }
    
    
    
    
    
    

}

