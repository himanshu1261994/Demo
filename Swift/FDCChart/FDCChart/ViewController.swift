//
//  ViewController.swift
//  FDCChart
//
//  Created by indianic on 30/06/16.
//  Copyright © 2016 indianic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.blackColor()
        
        
        let objChartView :ChartView = ChartView(viewFrame: self.view.frame, numberOfPie: 5)
        
        self.view.addSubview(objChartView)
        
        
        
        
    }
    
    
   

}

