//
//  ViewController.h
//  SqliteDemo
//
//  Created by Himanshu on 19/11/1937 SAKA.
//  Copyright © 1937 SAKA Himanshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDB/fmdb/FMDB.h"
#import "AppDelegate.h"

@interface HomeVC : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    AppDelegate *appDelegate;
 
}
@property (weak, nonatomic) IBOutlet UITableView *tblView;
- (IBAction)aBtnNewPostAction:(id)sender;


@end

