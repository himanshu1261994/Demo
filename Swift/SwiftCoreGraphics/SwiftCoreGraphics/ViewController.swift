//
//  ViewController.swift
//  SwiftCoreGraphics
//
//  Created by indianic on 10/06/16.
//  Copyright © 2016 indianic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let menuView : MenuButtonsView = MenuButtonsView(numberOfbuttons: 5, buttonTitles: ["a","b","c","d","e","f"] , viewController: self)
        
        self.view.addSubview(menuView)
        
        
        
        
        
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

