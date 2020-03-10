//
//  AppDelegate.m
//  FloatingMenu
//
//  Created by mac on 2020/2/16.
//  Copyright © 2020 GHome. All rights reserved.
//

#import "AppDelegate.h"
#import "GHomeExampleViewController.h"
#import "GHViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UIWindow *window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    GHViewController *vc = [[GHViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    window.rootViewController = nav;
    [window makeKeyAndVisible];
    self.window = window;
    
    return YES;
}


@end
