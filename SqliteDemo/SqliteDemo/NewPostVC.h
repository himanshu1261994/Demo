//
//  NewPostVC.h
//  SqliteDemo
//
//  Created by Himanshu on 19/11/1937 SAKA.
//  Copyright © 1937 SAKA Himanshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDB.h"
#import "AppDelegate.h"

@interface NewPostVC : UIViewController{
    AppDelegate *appDelegate;
}
@property (weak, nonatomic) IBOutlet UITextField *aTxtBlogTitle;
@property (weak, nonatomic) IBOutlet UITextView *aTxtBlogDiscription;
@property (nonatomic,strong)id aUserData;
@property (nonatomic,strong)NSMutableDictionary *aBlogData;


- (IBAction)aBtnPostAction:(id)sender;

@end
