//
//  ChartView.swift
//  FDCChart
//
//  Created by indianic on 30/06/16.
//  Copyright © 2016 indianic. All rights reserved.
//

import UIKit

class ChartView : UIView {

    var numberOfPies : Int = Int()
    var viewX : CGFloat = CGFloat()
    var viewY : CGFloat = CGFloat()
    var viewHeight : CGFloat = CGFloat()
    var viewWidth : CGFloat = CGFloat()
    var viewCenter : CGPoint = CGPoint()
    private var startAngle : CGFloat = 20.0 * CGFloat(M_PI/180)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
   
    init(viewFrame : CGRect,numberOfPie : Int){
        
        numberOfPies = numberOfPie
        viewX = viewFrame.origin.x
        viewY = viewFrame.origin.y
        viewWidth = viewFrame.size.width
        viewHeight = viewFrame.size.height

        super.init(frame: viewFrame )
        viewCenter = self.center
        
        // self.backgroundColor = UIColor.greenColor()
       
        let pieWidth : CGFloat = viewWidth/2
        let pieHeight : CGFloat = viewHeight/2
        
  
        
        let halfOfTotalPie : Float = Float(numberOfPie) / 2.0
        let degreeRotate : CGFloat = CGFloat(160/halfOfTotalPie)
        
        let pieX : CGFloat = viewCenter.x - (pieWidth / 2)
        let pieY : CGFloat = viewCenter.y - (pieHeight / 2)
        
        let pieFrame : CGRect = CGRect(x: pieX , y: pieY , width: pieWidth, height: pieHeight)
        
        
        for index in 1...numberOfPies {
          
            let onePie : onePieView = onePieView(frame: pieFrame, rotationAngle: degreeRotate)
            
            let fixAngle : CGFloat = degreeRotate * CGFloat(M_PI/180)
            
            onePie.transform = CGAffineTransformMakeRotation(startAngle);
            startAngle = fixAngle + startAngle
            
            self.addSubview(onePie)
            
            
        }
    
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
   
    

}
class onePieView : UIView {
    
    var centerPoint : CGPoint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect,rotationAngle : CGFloat) {
        super.init(frame: frame)

        
        // self.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.2)
        
        centerPoint  = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        
        let mlEndPoint : CGPoint = CGPoint(x: frame.size.width , y: frame.size.height/2)

        let mlLayer : middleLineLayer = middleLineLayer(startPoint: centerPoint!, endPoint: mlEndPoint)
        
        
        for index in 0...10 {
            var borderColor : UIColor?
            
            if index == 10 {
                borderColor = UIColor(white: 1.0, alpha: 1.0)
            }else{
                borderColor = UIColor(white: 1.0, alpha: 0.2)
            
            }
            
            
            let clLayer : curveLineLayer = curveLineLayer(centerPoint: centerPoint!, radius: CGFloat(100+CGFloat(index*12)),rotationAngle : rotationAngle, circleWidth: 2, strokeColor: .clearColor(), fillColor: borderColor!)
            
            self.layer.addSublayer(clLayer)
        }
  
        self.layer.addSublayer(mlLayer)
        

        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   
    
    
}
class middleLineLayer : CAShapeLayer{

    var linePath : UIBezierPath = UIBezierPath()
    
    
    override init() {
        super.init()

    }
    init(startPoint : CGPoint, endPoint : CGPoint){
        super.init()
       
        
        let tempPoint : CGPoint = CGPoint(x: startPoint.x+60, y: startPoint.y)
        
        linePath.moveToPoint(tempPoint)
        linePath.addLineToPoint(endPoint)
        linePath.addArcWithCenter(endPoint, radius: 3, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
        self.fillColor = UIColor.whiteColor().CGColor
        self.path = linePath.CGPath
        self.strokeColor = UIColor.whiteColor().CGColor
    }
    
    
    func setStroke(color : UIColor){
        self.strokeColor = color.CGColor
        
    }

    

    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
class curveLineLayer: CAShapeLayer {
    
   
    override init() {
        super.init()
    
    }
    init(centerPoint : CGPoint, radius : CGFloat,rotationAngle : CGFloat,circleWidth : CGFloat,strokeColor : UIColor,fillColor : UIColor){
        super.init()
        
    
            let startAngle : CGFloat = 0
            let endAngle : CGFloat = rotationAngle * CGFloat(M_PI/180)
            
       
            let circlePath : UIBezierPath = UIBezierPath()
            circlePath.addArcWithCenter(centerPoint, radius:radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            circlePath.addArcWithCenter(centerPoint, radius: radius + circleWidth, startAngle: endAngle, endAngle: startAngle, clockwise: false)
        
            circlePath.closePath()
        
        
        
         self.path = circlePath.CGPath
        self.strokeColor = strokeColor.CGColor
        self.fillColor = fillColor.CGColor
        
        
        
        
        
      
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    
}


