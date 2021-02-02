//
//  ViewController.swift
//  GreenDazeApp_01
//
//  Created by Juniette Fiore on 4/14/19.
//  Copyright © 2019 Juniette Fiore. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    let defaults = UserDefaults();
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    ///when the homscreen appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true; // prevents the nav bar from displaying on homescreen when we go back from tree view
    }

   
    
    


}

extension HomeViewController{
    //when cancel button on a log page is hit, save settings, but also go back to home
    @IBAction func unwindWithCancelFromLogPage(_ segue: UIStoryboardSegue) {
        
    }
    
    
    @IBAction func unwindWithSaveLogFromLogPage(_ segue: UIStoryboardSegue) {
        //if let gamePickerViewController = segue.source as? HomeViewController,
        // let selectedGame = gamePickerViewController.selectedGame {
        
        // }
    }
    
    @IBAction func unwindWithTreeRecycleBtnToHome(_ segue: UIStoryboardSegue){
       // self.performSegue(withIdentifier: "segueFromHomeToRecycleLog", sender: self);
    }
    
}

