//
//  XNavigationViewController.m
//  Runner
//
//  Created by 王鹏 on 2018/12/26.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define RETTabBarHeight 49

#import "XNavigationViewController.h"

@interface XNavigationViewController ()

@end

@implementation XNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
{
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
    // 修正push控制器tabbar上移问题
    if ([[self class] ret_isIPhoneX]) {
        CGFloat tabbarTop = SCREEN_HEIGHT - RETTabBarHeight - 34;
        CGRect frame = self.tabBarController.tabBar.frame;
        frame.origin.y = tabbarTop;
        self.tabBarController.tabBar.frame = frame;
    }
}

+ (BOOL)ret_isIPhoneX
{
    if (@available(iOS 11.0, *)) {
        static dispatch_once_t onceToken;
        static BOOL result = NO;
        dispatch_once(&onceToken, ^{
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
            BOOL landscape = (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight);
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                if (!landscape && window.safeAreaInsets.top > 0 && window.safeAreaInsets.bottom > 0) {
                    result = YES;
                } else if (landscape && window.safeAreaInsets.left > 0 && window.safeAreaInsets.right > 0) {
                    result = YES;
                } else {
                    
                }
            }
        });
        return result;
    }
    return NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
