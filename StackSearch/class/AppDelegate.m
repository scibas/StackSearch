//
//  AppDelegate.m
//  StackSearch
//
//  Created by Pawel Scibek on 10/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import "AppDelegate.h"
#import "SearchResultsController.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "QuestionDetailController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

    UIViewController *rootViewController;
    BOOL isOniPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    
    if(isOniPad){
        UISplitViewController *splitViewController = [[UISplitViewController alloc] init];
        UIViewController *masterViewController = [[SearchResultsController alloc]initWithStyle:UITableViewStyleGrouped];
        UIViewController *detailViewController = [[QuestionDetailController alloc] init];
        splitViewController.viewControllers = @[[[UINavigationController alloc] initWithRootViewController:masterViewController],
                                                [[UINavigationController alloc] initWithRootViewController:detailViewController]];
        
        rootViewController = splitViewController;
        
    } else {
        SearchResultsController *searchResultController = [[SearchResultsController alloc]initWithStyle:UITableViewStyleGrouped];
        rootViewController = [[UINavigationController alloc] initWithRootViewController:searchResultController];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
