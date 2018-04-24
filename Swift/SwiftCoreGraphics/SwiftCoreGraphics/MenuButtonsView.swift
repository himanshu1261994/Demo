//
//  MenuButtonsView.swift
//  SwiftCoreGraphics
//
//  Created by indianic on 11/06/16.
//  Copyright © 2016 indianic. All rights reserved.
//

import UIKit

class MenuButtonsView: UIView {


    init( numberOfbuttons : Int, buttonTitles : NSArray , viewController : UIViewController ){
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
        self.frame.size.width = viewController.view.frame.size.width/1.5
        self.frame.size.height = viewController.view.frame.size.height/3
        self.center = viewController.view.center
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
        
        
        
//        if numberOfbuttons == buttonTitles.count {
//            
//            for index in 1...numberOfbuttons {
//                
//                let buttonFrame : CGRect = CGRect(x: 0, y: 0, width: 50, height: 50)
//                
//                let menuButton : UIButton = UIButton(frame: buttonFrame)
//                menuButton.setTitle(buttonTitles[index] as? String, forState: .Normal)
//                
//                
//                self.addSubview(menuButton)
//            }
//            
//            
//        }else{
//        
//        
//        }
        
        


    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
