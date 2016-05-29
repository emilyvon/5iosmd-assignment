//
//  AppDelegate.m
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying FENG on 13/04/2016.
//  Copyright (c) 2016 Mengying FENG. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

NSString *DATABASE_RESOURCE_NAME = @"DBShoppingList";
NSString *DATABASE_RESOURCE_TYPE = @"db";
NSString *DATABASE_FILE_NAME = @"DBShoppingList.db";



- (BOOL) initializeDb {
    NSLog (@"initializeDB");
    // look to see if DB is in known location (~/Documents/$DATABASE_FILE_NAME)
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentFolderPath = [searchPaths objectAtIndex: 0];
    
    _dbFilePath = [documentFolderPath stringByAppendingPathComponent:DATABASE_FILE_NAME];
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath: _dbFilePath]) { // didn't find db, need to copy
        NSString *backupDbPath = [[NSBundle mainBundle] pathForResource:DATABASE_RESOURCE_NAME ofType:DATABASE_RESOURCE_TYPE];
        
        if (backupDbPath == nil) {
            // couldn't find backup db to copy, bail
            return NO;
        } else {
            BOOL copiedBackupDb = [[NSFileManager defaultManager]copyItemAtPath:backupDbPath toPath:_dbFilePath error:nil];
            if (! copiedBackupDb) {
                // copying backup db failed, bail
                return NO;
            } }
    }
    NSLog (@"end of initializeDb");
    return YES;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // copy the database from the bundle if necessary
    if (![self initializeDb]) {
        // TODO: alert the user!
        NSLog (@"couldn't init db");
    }
    
//    UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
//    tabController.selectedIndex = 3;
//    NSLog(@"Root: %@", tabController);
    
    return YES;
}

//-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    NSLog([NSString stringWithFormat:@"Tab bar item tag: %ld", (long)item.tag]);
//    NSLog(item.title);
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
