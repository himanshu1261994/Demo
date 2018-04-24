//
//  ViewController.swift
//  ProtocolDemo
//
//  Created by indianic on 17/03/17.
//  Copyright © 2017 ImagePlus. All rights reserved.
//

import UIKit

class ViewController: UIViewController,SecondVCProtocol {

    @IBOutlet var lblText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additionvarsetup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func abc(value: String) {
        lblText.text = value
    }
    @IBAction func btnnextvc(_ sender: UIButton) {
        let obj : ViewController2 = self.storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        obj.delegate = self
        
        self.navigationController?.pushViewController(obj, animated: true)
        
        
    }


}

