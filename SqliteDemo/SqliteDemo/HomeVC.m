//
//  ViewController.m
//  SqliteDemo
//
//  Created by Himanshu on 19/11/1937 SAKA.
//  Copyright © 1937 SAKA Himanshu. All rights reserved.
//

#import "HomeVC.h"
#import "NewPostVC.h"
@interface HomeVC (){

    NSMutableArray *allBlogsArray;
}

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];

   
}
-(void)viewWillAppear:(BOOL)animated{
    appDelegate = [[UIApplication sharedApplication]delegate];
    allBlogsArray = [[NSMutableArray alloc]init ];
    
    
    [self allBlogsOfUser];
    [_tblView reloadData];
}
-(void)allBlogsOfUser{

    NSString *selectQuery = [NSString stringWithFormat:@"select * from Blog_master where user_id = %@",[appDelegate.currentUser valueForKey:@"user_id"]];
    FMDatabase *fmdb = [FMDatabase databaseWithPath:[appDelegate getDbPath]];
    if ([fmdb open]) {
        FMResultSet *result = [fmdb executeQuery:selectQuery];
        while ([result next]) {
            [allBlogsArray addObject:result.resultDictionary];
        }
        
        
    }
    
    [fmdb close];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return allBlogsArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [[allBlogsArray objectAtIndex:indexPath.row]objectForKey:@"blog_title" ];
    
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;

}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSString *deleteQuery = [NSString stringWithFormat:@"delete from Blog_master where blog_id = '%@'",[[allBlogsArray objectAtIndex:indexPath.row] valueForKey:@"blog_id"]];
          FMDatabase *fmdb = [FMDatabase databaseWithPath:[appDelegate getDbPath]];
        if ([fmdb open]) {
            BOOL success;
            success = [fmdb executeUpdate:deleteQuery];
            if (success) {
                
                [allBlogsArray removeObjectAtIndex:indexPath.row];
                [_tblView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

            
            }
        }
        
    }

}
#pragma TableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

   
}

#pragma UnWindSegue
-(IBAction)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC{


}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"segueFromHomeVCToNewPostVC"]) {
        NewPostVC *newPostVC = [segue destinationViewController];
         NSIndexPath *path = [_tblView indexPathForSelectedRow];
        newPostVC.aBlogData=[allBlogsArray objectAtIndex:path.row];
    }

}



- (IBAction)aBtnNewPostAction:(id)sender {
    [self performSegueWithIdentifier:@"segueFromHomeVCToNewPostVC" sender:nil];
}
@end
