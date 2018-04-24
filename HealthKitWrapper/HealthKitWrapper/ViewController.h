//
//  ViewController.h
//  HealthKitWrapper
//
//  Created by indianic on 02/03/17.
//  Copyright © 2017 indianic. All rights reserved.
//

#import <UIKit/UIKit.h>
@import HealthKit;
@interface ViewController : UIViewController
@property (nonatomic) HKHealthStore *healthStore;

@end

