//
//  AppDelegate.h
//  SqliteDemo
//
//  Created by Himanshu on 19/11/1937 SAKA.
//  Copyright © 1937 SAKA Himanshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FMDB.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,strong) NSString *databaseName;
@property (nonatomic,strong) NSString *databasePath;
@property (nonatomic,strong) NSMutableDictionary *currentUser;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(NSString *)getDbPath;

@end

