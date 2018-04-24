//
//  RegisterationVC.m
//  SqliteDemo
//
//  Created by Himanshu on 19/11/1937 SAKA.
//  Copyright © 1937 SAKA Himanshu. All rights reserved.
//

#import "RegisterationVC.h"

@interface RegisterationVC ()

@end

@implementation RegisterationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication]delegate ];
    
    NSLog(@"Datapath %@",[appDelegate getDbPath]);
    
}



- (IBAction)aBtnRegisterAction:(id)sender {
    
   
    
    NSString *insertQuery = [NSString stringWithFormat:@"insert into User_master(fullname,contact_no,email,password) values('%@','%@','%@','%@')",aTxtFullname.text,aTxtContactno.text,aTxtEmail.text,aTxtPassword.text];
    
    FMDatabase *fmdb = [FMDatabase databaseWithPath:[appDelegate getDbPath]];
    if ([fmdb open]) {
        BOOL success = [fmdb executeUpdate:insertQuery];
        if (success) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Register Success" message:@"You have been register successfully.Please Login again" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                LoginVC *objLoginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
                [self.navigationController pushViewController:objLoginVC animated:YES];
            }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }
    
}

@end
