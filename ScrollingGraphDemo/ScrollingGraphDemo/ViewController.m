//
//  ViewController.m
//  ScrollingGraphDemo
//
//  Created by indianic on 18/01/1938 SAKA.
//  Copyright © 1938 SAKA indianic. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<TTMCaptureManagerDelegate>{
  
    CGFloat counter;
    NSDate *startDate;
   
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
   
    counter = 0;
    _videoTimer.text = [NSString stringWithFormat:@"0:0:0"];
    
    // Basic intialization
    scrollViewHeight = _scrollView.frame.size.height;
    scrollViewWidth = _scrollView.frame.size.width;
    changeY = scrollViewHeight;
    _lblRating.text = @"0";
    
    _slider.minimumValue = 0;
    _slider.maximumValue = 10;
    
    
    appDel.mutArray = [[NSMutableArray alloc]init];
    appDel.path = [UIBezierPath bezierPath];
    startPoint = CGPointMake(0,scrollViewHeight);
   
    
    captureManager = [[TTMCaptureManager alloc]initWithPreviewView:self.view preferredCameraType:CameraTypeBack outputMode:OutputModeVideoData ];
    captureManager.delegate = self;
    [self graphFunction:NO];
    
   

}
-(void)graphFunction:(BOOL)showGraph{
    
    if (showGraph) {
        
        _graphView.hidden = NO;
      
        
        // UIBezierPath
        graphPath = [UIBezierPath bezierPath];
        [graphPath moveToPoint:startPoint];


        // CAshapeLayer
        graphLayer = [CAShapeLayer layer];
        [graphLayer setPath:graphPath.CGPath];
        graphLayer.shadowColor = [UIColor blackColor].CGColor;
        graphLayer.shadowOpacity = 0.5;
        graphLayer.shadowOffset = CGSizeMake(5.0, 0.0);
        [graphLayer setFillColor:[UIColor clearColor].CGColor];
        [graphLayer setStrokeColor:[UIColor redColor].CGColor];
      
        [graphLayer setLineWidth:5.0];
      
        [_scrollView.layer addSublayer:graphLayer];
        
        
        
        // Slider changeValue function
        [_slider addTarget:self action:@selector(changeY) forControlEvents:UIControlEventValueChanged];
        
        startDate = [NSDate date];
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeValue)];
        displayLink.frameInterval = 5.0;
        
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }else{
        _graphView.hidden = YES;

        [displayLink invalidate];
        [graphLayer removeFromSuperlayer];
        graphPath = nil;
    }
    


}
-(NSString *)sinceDate:(NSDate *)sinceDate andCurrentDate:(NSDate *)currentDate{

   
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:sinceDate];
    NSDate *dateWithInterval = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"H:m:s"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:dateWithInterval];
    
    return timeString;
}
-(NSDictionary *)storePointX:(float)pointX withPointY:(float)pointY andTime:(NSString *)timeStamp{
    
    
    NSDictionary *videoDict = [[NSDictionary alloc]initWithObjects:@[@(pointX),
                                                                     @(pointY),
                                                                     @(ceilf(_slider.value)),
                                                                     timeStamp]
                                                           forKeys:@[@"graphPointX",
                                                                     @"graphPointY",
                                                                     @"rating",
                                                                     @"timeStamp"] ];
    
    
   
    return videoDict;
}
-(void)changeValue{
    
   
    
    _videoTimer.text = [self sinceDate:startDate andCurrentDate:[NSDate date]];
    
    endPoint = CGPointMake(startPoint.x+10, changeY);
    
    if (endPoint.y == startPoint.y) {
        [graphPath addLineToPoint:endPoint];
       
    }else{
    
        
        CGPoint s1 = startPoint;
        CGPoint e1 = endPoint;
     
    
        CGPoint centerPoint = CGPointMake((s1.x+e1.x)/2, (s1.y+e1.y)/2);
    
        CGPoint controlPoint1 = CGPointMake(centerPoint.x,s1.y);
        CGPoint controlPoint2 = CGPointMake(centerPoint.x,e1.y);
        
        [graphPath addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];

    }
    
    
    
    [graphLayer setPath:graphPath.CGPath];
    appDel.path = nil;
    appDel.path = graphPath;
    

    [appDel.mutArray addObject:[self storePointX:endPoint.x withPointY:endPoint.y andTime:_videoTimer.text]];
   
    [_scrollView setContentOffset:CGPointMake(endPoint.x-scrollViewWidth,0) animated:NO];

     startPoint = endPoint;
    
}

-(void)changeY{
    
    changeY = scrollViewHeight - (ceilf(_slider.value)*(scrollViewHeight/10));
    _lblRating.text = [NSString stringWithFormat:@"%d",(int)ceilf(_slider.value) ];
}

#pragma mark CONTROL ACTIONS
- (IBAction)itemSlider:(UISlider *)itemSlider withEvent:(UIEvent*)e{
    UITouch * touch = [e.allTouches anyObject];
    
    if( touch.phase != UITouchPhaseMoved && touch.phase != UITouchPhaseBegan)
    {
        _slider.value = 0;

       
    }
    
}
- (IBAction)btnRecordAction:(UIButton *)sender {

    if (!captureManager.isRecording) {
        
        [captureManager startRecording];
        [_btnRecord setBackgroundImage:[UIImage imageNamed:@"startRecording.jpg"] forState:UIControlStateNormal];
        [self graphFunction:YES];
    }
   
    else {
       [_activityIndicator startAnimating];
        [captureManager stopRecording];
        [_btnRecord setBackgroundImage:[UIImage imageNamed:@"stopRecording.jpg"] forState:UIControlStateNormal];
        [self graphFunction:NO];
     
    }
    
    
}
#pragma mark VIDEO FUNCTIONS
- (void)didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL
                                      error:(NSError *)error{
    
    [self saveRecordedFile:outputFileURL];
    
    
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    [captureManager updateOrientationWithPreviewView:self.view];
}
- (void)saveRecordedFile:(NSURL *)recordedFile {
    
    
             appDel.videoURL = recordedFile;
             [_activityIndicator stopAnimating];
             [self performSegueWithIdentifier:@"segFromVCToEditVideoVC" sender:nil];

}

@end
