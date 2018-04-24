//
//  ViewController.swift
//  DemoPageController
//
//  Created by indianic on 20/05/17.
//  Copyright © 2017 Indianic. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ABC {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func changeBGColor(color : UIColor){
    
        self.view.backgroundColor = color
    
    }
    @IBAction func btnPushAction(_ sender: UIButton) {
        
        let vc1 : VC1 = (self.storyboard?.instantiateViewController(withIdentifier: "VC1") as? VC1)!
        vc1.delegate = self
        
        self.navigationController?.pushViewController(vc1, animated: true)
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

