//
//  LYBaseNavigationController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYBaseNavigationController.h"

@interface LYBaseNavigationController ()

@end

@implementation LYBaseNavigationController

#pragma mark - Life CyCle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Public Method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self setUpNavigationBarAppearance];
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
  
        UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"lybaseLeftBackItemIcon"] style:UIBarButtonItemStyleDone target:self action:@selector(popAction)];
        viewController.navigationItem.leftBarButtonItem = itemleft;

    }
    [super pushViewController:viewController animated:YES];
}

#pragma mark - 设置全局的导航栏属性
- (void)setUpNavigationBarAppearance
{
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    NSDictionary *textAttributes = @{NSFontAttributeName:LYSystemFont(16),
                                     NSForegroundColorAttributeName: [UIColor blackColor]
                                     };
    
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    navigationBarAppearance.tintColor = [UIColor blackColor];
    //    navigationBarAppearance.barTintColor = LYColorWithHexStr(@"#dedede");
}
//- (void)setUpCustomNavigationBarWithViewController:(UIViewController *)viewController
//{
//    UIBarButtonItem * item = [UIBarButtonItem itemWithTarget: self action:@selector(btnLeftBtn) image:@"icon_nav_back_white_19x18_"  selectImage:@"icon_nav_back_white_19x18_"];
//    viewController.navigationItem.leftBarButtonItem = item;
//}
- (void)popAction
{
    [self popViewControllerAnimated:YES];
}
#pragma mark - UIStatusBar
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
    //    return UIStatusBarStyleLightContent;
}
@end

