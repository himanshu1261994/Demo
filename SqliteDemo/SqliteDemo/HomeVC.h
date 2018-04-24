//
//  ViewController.h
//  SqliteDemo
//
//  Created by indianic on 19/11/1937 SAKA.
//  Copyright © 1937 SAKA indianic. All rights reserved.
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

