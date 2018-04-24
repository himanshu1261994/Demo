//
//  ViewController2.swift
//  ProtocolDemo
//
//  Created by indianic on 17/03/17.
//  Copyright © 2017 ImagePlus. All rights reserved.
//

import UIKit
protocol SecondVCProtocol {
    func abc(value : String)
}
class ViewController2: UIViewController {


    @IBOutlet var txtDemo: UITextField!
    var delegate : SecondVCProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.abc(value: txtDemo.text!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  

}
