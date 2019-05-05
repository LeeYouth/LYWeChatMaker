//
//  AppDelegate.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/8/16.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+UMSocial.h"
#import "LYHomePageViewController.h"
#import "LYBaseNavigationController.h"
#import "LYADLaunchViewController.h"

@interface AppDelegate ()<LYADLaunchViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (iOS11) {
        if (@available(iOS 11.0, *)) {
            [UIScrollView appearance].
            contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
#warning - 在这里配置正式、测试，log开关
//    //配置服务器类型
//    [LYServerConfig setLYConfigEnv:LYServerEnvDevelop];
//    [LYNetworkTools enableInterfaceDebug:YES];
//
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
//    
//
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    // 设置状态栏的状态
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//

    //配置服务器类型
    [LYServerConfig setLYConfigEnv:LYServerEnvProduct];
    bg_setDebug(YES);//打开调试模式,打印输出调试信息.

//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.window = [[UIWindow alloc] init];
    
    
//    LYADLaunchViewController *adVC = [[LYADLaunchViewController alloc] init];
//    adVC.delegate = self;
//    [self.window setRootViewController:adVC];
    
    LYHomePageViewController *homeVC = [[LYHomePageViewController alloc] init];
    LYBaseNavigationController *nav = [[LYBaseNavigationController alloc] initWithRootViewController:homeVC];
    [self.window setRootViewController:nav];

    
    [self.window makeKeyAndVisible];
    // 友盟UMSocial
    [self LYUMSocialApplication:application didFinishLaunchingWithOptions:launchOptions];
    //谷歌广告
    [GADMobileAds configureWithApplicationID:GOOGLEADS_APPID];


    // 开启网络状态监听
//    [[LYNetworkStatusObserver defaultObserver] startNotifier];
    
    return YES;
}

#pragma - LYADLaunchViewControllerDelegate
- (void)launchSuccessAction:(LYADLaunchViewController *)launchViewController{
//    LYBaseNavigationController *nav = [[LYBaseNavigationController alloc] initWithRootViewController:[[LYHomePageViewController alloc] init]];
//    [self.window setRootViewController: nav];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 禁止旋转屏幕
- (NSUInteger)application:(UIApplication *)application
supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}


@end
