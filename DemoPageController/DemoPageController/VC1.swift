//
//  VC1.swift
//  DemoPageController
//
//  Created by indianic on 20/05/17.
//  Copyright © 2017 Indianic. All rights reserved.
//

import UIKit
protocol ABC  {
    func changeBGColor(color : UIColor)
}
class VC1: UIViewController {

    var delegate : ABC?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnChangeBGColor(_ sender: UIButton) {
        
        delegate?.changeBGColor(color: UIColor.red)
        self.navigationController?.popViewController(animated: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
