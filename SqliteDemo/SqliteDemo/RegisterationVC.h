//
//  RegisterationVC.h
//  SqliteDemo
//
//  Created by Himanshu on 19/11/1937 SAKA.
//  Copyright © 1937 SAKA Himanshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeVC.h"
#import "AppDelegate.h"
#import "FMDB/fmdb/FMDB.h"
#import "LoginVC.h"
@interface RegisterationVC : UIViewController{
   
    AppDelegate *appDelegate;
    __weak IBOutlet UITextField *aTxtFullname;

    __weak IBOutlet UITextField *aTxtContactno;
    __weak IBOutlet UITextField *aTxtEmail;
    __weak IBOutlet UITextField *aTxtPassword;
}
- (IBAction)aBtnRegisterAction:(id)sender;

@end
