//
//  LYTabBarControllerConfig.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/26.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYTabBarControllerConfig.h"
#import "LYTWatermarkViewController.h"
#import "LYBaseNavigationController.h"

@interface LYTabBarControllerConfig ()

/**  首页 */
@property (strong, nonatomic) LYTWatermarkViewController *waterMarkVC;

@end

@implementation LYTabBarControllerConfig

- (LYTabbarViewController *)tabBarController
{
    return LY_LAZY(_tabBarController, ({
        LYTabbarViewController *tabBarVC = [[LYTabbarViewController alloc] init];
        tabBarVC.viewControllers = [self viewControllersForController];
        [self tabBarAppearanceConfig:tabBarVC];
        tabBarVC;
    }));
}

- (NSArray *)viewControllersForController {
    // 添加
    LYTWatermarkViewController *waterMarkVC = [[LYTWatermarkViewController alloc] init];
    LYBaseNavigationController *waterMarkNav = [self addChildViewController:waterMarkVC title:@"添加" image:@"" selectedImage:@""];
        
    NSArray *viewControllers = @[
                                 waterMarkNav,
                                 ];
    return viewControllers;
}

- (void)tabBarAppearanceConfig:(LYTabbarViewController *)tabBarVC
{
    
}

/**
 *  设置TabBarItem的属性，包括 title、Image、selectedImage。
 */
- (LYBaseNavigationController *)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{

    //1.tababr标题
    childController.tabBarItem.title = title;
    UIImage *normal = [UIImage imageNamed:image];
    UIImage *selected = [UIImage imageNamed:selectedImage];
    
    childController.tabBarItem.image = [normal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    //2.包装导航控制器
    childController.title = title;
    LYBaseNavigationController *nav = [[LYBaseNavigationController alloc]
                                                    initWithRootViewController:childController];
    return nav;
}

@end
