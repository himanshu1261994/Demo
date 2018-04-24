//
//  ViewController.m
//  CoreGraphicsPrac
//
//  Created by indianic on 11/06/16.
//  Copyright © 2016 indianic. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){

    BOOL showOtherButton;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    showOtherButton = NO;
    
   // UIView *toggleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, self.view.frame.size.height/2) ];
    
    
    
    UIButton *centerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    centerButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
    centerButton.center = self.view.center;
    centerButton.layer.cornerRadius = 25.0;
    centerButton.clipsToBounds = YES;
    
    [centerButton addTarget:self action:@selector(btnCenterClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [self.view addSubview:centerButton];
    
    

    
}
-(void)btnCenterClicked:(UIButton *)sender{

    
    if (showOtherButton) {
        showOtherButton = NO;
        
    sender.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        
        [UIView animateWithDuration:0.3/1.5 animations:^{
            sender.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                sender.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3/2 animations:^{
                    sender.transform = CGAffineTransformIdentity;
                }];
            }];
        }];
        
        
        
        
        sender.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    }else{
        
        
        showOtherButton = YES;
        sender.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
    }
    
    
    
    

}


@end
