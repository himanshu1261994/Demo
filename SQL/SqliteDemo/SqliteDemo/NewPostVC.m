//
//  NewPostVC.m
//  SqliteDemo
//
//  Created by indianic on 19/11/1937 SAKA.
//  Copyright © 1937 SAKA indianic. All rights reserved.
//

#import "NewPostVC.h"

@interface NewPostVC ()

@end

@implementation NewPostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication]delegate ];
    

}
-(void)viewWillAppear:(BOOL)animated{

  NSLog(@"Blog Data %@",_aBlogData);
    
    _aTxtBlogTitle.text = [_aBlogData valueForKey:@"blog_title"];
    _aTxtBlogDiscription.text = [_aBlogData valueForKey:@"blog_discription"];
}



- (IBAction)aBtnPostAction:(id)sender {
    
    
   
        NSString *insertQuery = [NSString stringWithFormat:@"insert into Blog_master(user_id,blog_title,blog_description) values('%@','%@','%@')",[appDelegate.currentUser valueForKey:@"user_id"],_aTxtBlogTitle.text,_aTxtBlogDiscription.text];
        
        FMDatabase *fmdb = [FMDatabase databaseWithPath:[appDelegate getDbPath]];
        if ([fmdb open]) {
            BOOL success = [fmdb executeUpdate:insertQuery];
            if (success) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        
   
    
   
}
@end
