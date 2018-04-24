//
//  ViewController.swift
//  BasicDemo
//
//  Created by indianic on 27/03/17.
//  Copyright © 2017 ImagePlus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var lblTest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seg" {
            let detsVC : ViewController2 = segue.destination as! ViewController2
            detsVC.myClos = { value in
            
                self.lblTest.text = value
            
            }
            
        }
    }
}

