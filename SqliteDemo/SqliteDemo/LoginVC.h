//
//  LoginVC.h
//  SqliteDemo
//
//  Created by Himanshu on 19/11/1937 SAKA.
//  Copyright © 1937 SAKA Himanshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDB/fmdb/FMDB.h"
#import "AppDelegate.h"
#import "HomeVC.h"

@interface LoginVC : UIViewController{
    AppDelegate *appDelegate;

}
- (IBAction)aBtnLoginAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *aTxtEmail;
@property (weak, nonatomic) IBOutlet UITextField *aTxtPassword;

@end
