//
//  EditVideoVC.m
//  ScrollingGraphDemo
//
//  Created by indianic on 23/01/1938 SAKA.
//  Copyright © 1938 SAKA indianic. All rights reserved.
//

#import "EditVideoVC.h"

typedef NS_ENUM(NSUInteger, playerFunction) {
    playerSetup,
    playVideo,
    pauseVideo,
    stopVideo,
};
@interface EditVideoVC (){

    CGFloat totalWidthOfGraph;
    NSString *timeStamp;
    CADisplayLink *displayLink;
    BOOL isPlaying;
    NSMutableArray *shapeLayerArray;
    CAShapeLayer *graphLayer,*centerLineLayer;
    UIBezierPath *centerLinePath;
  
    
}

@end

@implementation EditVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",appDel.mutArray);
    [self playerWithFunction:playerSetup];
    
}

#pragma mark PLAYER-SETUP FUNCTION
-(void)playerWithFunction:(playerFunction)function{
    
    
    if (function == playerSetup) {
        
        isPlaying = NO;
        shapeLayerArray = [[NSMutableArray alloc]init];
      
        
        scrollViewHeight = _scrollView.frame.size.height;
        scrollViewWidth = _scrollView.frame.size.width;
     
        totalWidthOfGraph = [[[appDel.mutArray lastObject]objectForKey:@"graphPointX" ] floatValue];
        timeStamp = [[appDel.mutArray lastObject]objectForKey:@"timeStamp" ];
        _lblTotalSelectedTime.text = @"0:0:0";
      

        // SLIDER SETTINGS
        _slider.minimumValue = -1;
        _slider.maximumValue = 10;
        _slider.value = 10;
        
        // ADD LAYER TO SCROLLVIEW
        graphLayer = [CAShapeLayer layer];
        [graphLayer setPath:appDel.path.CGPath];
        [graphLayer setFillColor:[UIColor clearColor].CGColor];
        graphLayer.shadowColor = [UIColor blackColor].CGColor;
        graphLayer.shadowOpacity = 0.5;
        graphLayer.shadowOffset = CGSizeMake(5.0, 0.0);
        [graphLayer setStrokeColor:[UIColor redColor].CGColor];
        [graphLayer setLineWidth:5.0];
        [_scrollView.layer addSublayer:graphLayer];
      
        [self drawSquareWithArray:appDel.mutArray];
         graphLayer.transform = CATransform3DMakeScale(screenWidth/ totalWidthOfGraph, 1, 1);
        
        
        centerLinePath = [UIBezierPath bezierPath];
        [centerLinePath moveToPoint:CGPointMake(0,scrollViewHeight)];
        [centerLinePath addLineToPoint:CGPointMake(screenWidth, scrollViewHeight)];
        
        centerLineLayer = [CAShapeLayer layer];
        [centerLineLayer setPath:centerLinePath.CGPath];
        [centerLineLayer setStrokeColor:[UIColor grayColor].CGColor];
        [centerLineLayer setLineWidth:2.0];
        [centerLineLayer setFillColor:[UIColor grayColor].CGColor];
        [_scrollView.layer addSublayer:centerLineLayer];
       
        
        // ADD AACTIONS
        [_slider addTarget:self action:@selector(sliderValueChange) forControlEvents:UIControlEventTouchCancel | UIControlEventValueChanged];
        
        UIPinchGestureRecognizer *pinchGest = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchHandler:) ];
        
        [_scrollView addGestureRecognizer:pinchGest];
        
        
    }
    
    if (!player) {
        avasset = [AVAsset assetWithURL:appDel.videoURL];
        playerItem = [[AVPlayerItem alloc]initWithAsset:avasset ];
        player = [[AVPlayer alloc]initWithPlayerItem:playerItem];
        playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        [playerLayer setFrame:CGRectMake(0, 0,_playerView.frame.size.width ,_playerView.frame.size.height)];
        [_playerView.layer addSublayer:playerLayer];
        
        _lblTotalDuration.text = [self stringFromCMTime:avasset.duration];
    }
    if (function == playVideo) {
        [player play];
         _lblTotalDuration.text = [self stringFromCMTime:playerItem.duration];
        isPlaying = YES;
       
       
        // RUN GRAPH
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerValueChange)];
        displayLink.frameInterval = 0.01;
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];

    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];

    }
    if (function == pauseVideo) {
        [player pause];
        [displayLink invalidate];
        isPlaying = NO;
        
    }
   
}
-(void)pinchHandler:(UIPinchGestureRecognizer *)handler{


   
    
    
}


#pragma mark ACTION EVENTS
- (IBAction)btnPlayerVideo:(UIButton *)sender {
    if (!isPlaying) {
        [self playerWithFunction:playVideo];
    }else{
        [self playerWithFunction:pauseVideo];
    }
}
- (IBAction)itemSlider:(UISlider *)itemSlider withEvent:(UIEvent*)e{
    UITouch * touch = [e.allTouches anyObject];
    
    if( touch.phase != UITouchPhaseMoved && touch.phase != UITouchPhaseBegan)
    {
        
    }
    
}

#pragma mark VALUE-CHANGE ON TARGET
-(void)sliderValueChange{
    
 
    _lblTotalSelectedTime.text = [NSString stringWithFormat:@"%d",10-(int)ceilf(_slider.value)];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.rating >= %d",10-(int)ceilf(_slider.value)];
    NSArray* mutRating = [NSMutableArray arrayWithArray:[appDel.mutArray filteredArrayUsingPredicate:predicate]];

    CGFloat y = -(scrollViewHeight - ceilf(_slider.value)*(scrollViewHeight/10));
    [centerLineLayer setPosition:CGPointMake(0, y)];
    [self drawSquareWithArray:mutRating];

}
-(void)timerValueChange{
        _lblCurrentDuration.text = [self stringFromCMTime:player.currentTime];

}

#pragma mark OTHER-FUNCTIONS
-(void)itemDidFinishPlaying{
    isPlaying = NO;
    [displayLink invalidate];
    [player pause];
    [player seekToTime:CMTimeMake(0, 1)];
   
    [_scrollView setContentOffset:CGPointMake(0, 0)];
}
-(void)drawSquareWithArray:(NSArray *)rectArray{
    
    if (rectArray.count > 0) {
        
        CGFloat rectX;
        rectX = [rectArray[0][@"graphPointX"]floatValue];
        
        if (shapeLayerArray.count > 0) {
            for (int i = 0; i < shapeLayerArray.count; i++) {
                
                CAShapeLayer *layerTemp = [shapeLayerArray objectAtIndex:i];
                [layerTemp removeFromSuperlayer];
            }
            
            [shapeLayerArray removeAllObjects];
        }
        
        
        for (int i = 0; i < rectArray.count; i++) {
            
            float secondPoint,firstPoint;
            
            if (i>0) {
                
                firstPoint = [rectArray[i-1][@"graphPointX"]floatValue];
                secondPoint = [rectArray[i][@"graphPointX"]floatValue]-10;
                
                
                if (firstPoint != secondPoint || i == rectArray.count-1) {
                    
                    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectMake((rectX-2),0,(firstPoint-rectX)+4,scrollViewHeight)];
                    
                    CAShapeLayer *rectLayer = [CAShapeLayer layer];
                    [rectLayer setPath:rectPath.CGPath];
                    [rectLayer setFillColor:[UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:0.5].CGColor];
                    [_scrollView.layer addSublayer:rectLayer];
                    rectLayer.transform = CATransform3DMakeScale(screenWidth / totalWidthOfGraph, 1, 1);
                    [shapeLayerArray addObject:rectLayer];
                    
                    rectX = [rectArray[i][@"graphPointX"]floatValue];
                    
                }
            }
            
            
        }
        
    }else{
        
        if (shapeLayerArray.count > 0) {
            for (int i = 0; i < shapeLayerArray.count; i++) {
                
                CAShapeLayer *layerTemp = [shapeLayerArray objectAtIndex:i];
                [layerTemp removeFromSuperlayer];
            }
            
            [shapeLayerArray removeAllObjects];
        }
        
        
    }
    
    
    
}
-(NSString *)stringFromCMTime:(CMTime)time{
    
    CMTime totalTime = time;
    NSUInteger totalSeconds = CMTimeGetSeconds(totalTime);
    NSUInteger dHours = floor(totalSeconds / 3600);
    NSUInteger dMinutes = floor(totalSeconds % 3600 / 60);
    NSUInteger dSeconds = floor(totalSeconds % 3600 % 60);
    NSString *timeStr = [NSString stringWithFormat:@"%lu:%lu:%lu",(unsigned long)dHours,(unsigned long)dMinutes,(unsigned long)dSeconds];
    
    return timeStr;
}

@end
