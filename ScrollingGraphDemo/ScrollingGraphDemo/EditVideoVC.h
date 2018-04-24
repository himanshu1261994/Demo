//
//  EditVideoVC.h
//  ScrollingGraphDemo
//
//  Created by indianic on 23/01/1938 SAKA.
//  Copyright © 1938 SAKA indianic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditVideoVC : UIViewController{
    
    AVPlayer *player;
    AVPlayerLayer *playerLayer;
    AVAsset *avasset;
    AVPlayerItem *playerItem;
    
    CGFloat scrollViewHeight,scrollViewWidth;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIView *playerView;
- (IBAction)btnPlayerVideo:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblSliderValue;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentDuration;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalDuration;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalSelectedTime;

@end
