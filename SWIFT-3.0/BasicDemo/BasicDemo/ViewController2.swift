//
//  ViewController2.swift
//  BasicDemo
//
//  Created by indianic on 27/03/17.
//  Copyright © 2017 ImagePlus. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet var txtField: UITextField!
    var myClos : (_ valueStr : String) -> () = {_ in}
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidDisappear(_ animated: Bool) {
         self.myClos(txtField.text!)
    }

}
