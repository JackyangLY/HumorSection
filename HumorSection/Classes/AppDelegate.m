//
//  AppDelegate.m
//  HumorSection
//
//  Created by 洋洋 on 16/7/13.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "AppDelegate.h"
#import "GuidePageViewController.h"
#import "NavigationViewController.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    /**创建window*/
    _window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    // 根据条件设置跟控制器
    // 1, 从info.plist文件中读取当前的外部版本号
    NSString *strVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    // 2, 读取自己上一次运行引导页保存的版本号
    NSString *strVersionMine = [[NSUserDefaults standardUserDefaults] objectForKey:@"oldVersionKey"];
    if ([strVersion isEqualToString:strVersionMine])
    { // 版本相同, 进入主页
        [self loadMainController];
    }
    else
    { // 版本不同, 进入引导页
        [_window setRootViewController:[[GuidePageViewController alloc] init]];
    }
     /**设置根控制器*/
    //ViewController *vc = [[ViewController alloc]init];
    //_window.rootViewController = vc ;
    /**显示在屏幕上*/
    [_window makeKeyAndVisible];

    return YES;

}
// 直接跳转到主控制器
- (void)loadMainController
{
  //  [_window setRootViewController:[[MainViewController alloc] init]];

       MainViewController  *mainVC=[[MainViewController alloc] init];
    NavigationViewController *navigationVC = [[NavigationViewController alloc]initWithRootViewController:mainVC];
        [_window setRootViewController:navigationVC];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
