//
//  AppDelegate.m
//  FloatingMenu
//
//  Created by mac on 2020/2/16.
//  Copyright © 2020 GHome. All rights reserved.
//

#import "AppDelegate.h"
#import "GHomeExampleViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UIWindow *window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    GHomeExampleViewController *vc = [[GHomeExampleViewController alloc]init];
    window.rootViewController = vc;
    [window makeKeyAndVisible];
    self.window = window;
    
    return YES;
}


@end
