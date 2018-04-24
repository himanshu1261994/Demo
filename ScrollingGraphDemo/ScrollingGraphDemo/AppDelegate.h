//
//  AppDelegate.h
//  ScrollingGraphDemo
//
//  Created by indianic on 18/01/1938 SAKA.
//  Copyright © 1938 SAKA indianic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong,nonatomic)NSMutableArray *mutArray;
@property (strong,nonatomic)UIBezierPath *path;
@property (strong,nonatomic)NSURL *videoURL;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

