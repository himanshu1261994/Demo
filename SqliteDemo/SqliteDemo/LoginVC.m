//
//  LoginVC.m
//  SqliteDemo
//
//  Created by Himanshu on 19/11/1937 SAKA.
//  Copyright © 1937 SAKA Himanshu. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC (){
    NSMutableArray *mutArray;

}

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication]delegate ];
    mutArray = [[NSMutableArray alloc ]init ];
   
}



- (IBAction)aBtnLoginAction:(id)sender {
    
    NSString *selectQuery = [NSString stringWithFormat:@"select * from User_master where email = '%@' and password = '%@'",_aTxtEmail.text,_aTxtPassword.text];
    
    FMDatabase *fmdb = [FMDatabase databaseWithPath:[appDelegate getDbPath]];
    if ([fmdb open]) {
        FMResultSet *result = [fmdb executeQuery:selectQuery];
        while ([result next]) {
            [mutArray addObject:result.resultDictionary];
        }
        if (mutArray.lastObject > 0) {
            HomeVC *objHomeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
            appDelegate.currentUser = [mutArray lastObject];
            [self.navigationController pushViewController:objHomeVC animated:YES];
        }
        
    }
    

    
}

@end
