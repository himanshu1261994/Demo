//
//  ViewController.h
//  ScrollingGraphDemo
//
//  Created by Himanshu on 18/01/1938 SAKA.
//  Copyright © 1938 SAKA Himanshu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
  
    NSMutableArray *graphData;
    CAShapeLayer *graphLayer;
    UIBezierPath *graphPath;
    
    CGFloat scrollViewHeight,scrollViewWidth;
    CGPoint startPoint,endPoint;
    
    CGFloat lastScrollPoint,changeY;
    
    int tapCount;
    TTMCaptureManager *captureManager;
    CADisplayLink *displayLink;
    
    

}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *videoTimer;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *lblRating;
@property (weak, nonatomic) IBOutlet UIView *graphView;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)btnRecordAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnRecord;



@end

